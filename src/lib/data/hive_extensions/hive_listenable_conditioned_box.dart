import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'item_change.dart';

typedef OnItemListChanged<T> = void Function(
  T? item,
  int index,
  ItemChange change,
);

typedef FilterRule<T> = bool Function(T model);
typedef SortFunction<T> = int Function(T a, T b);

class HiveListenableConditionedList<T> extends ValueListenable<Iterable<T>> {
  HiveListenableConditionedList(
    this.box, {
    required this.filterRule,
    required this.keyFunction,
    this.primarySort,
    this.secondarySort,
  }) : assert(
          (primarySort == null && secondarySort == null) ||
              (primarySort != null && secondarySort != null),
          'Primary and secondary sorts must either both be set or be null',
        ) {
    _subscription = box.watch().listen(_onBoxChanges);

    _values = box.values
        .where(
          (element) => filterRule(element),
        )
        .toList();

    if (secondarySort != null) {
      _values.sort(secondarySort);
    }

    if (primarySort != null) {
      _values.sort(primarySort);
    }
  }

  final Box<T> box;
  final FilterRule<T> filterRule;
  final SortFunction<T>? primarySort;

  /// Must be unique to determine item position if the primary sort function
  /// found equal items.
  final SortFunction<T>? secondarySort;
  final dynamic Function(T item) keyFunction;

  final List<VoidCallback> _listeners = [];
  final List<OnItemListChanged<T>> _itemChangeListeners = [];

  late StreamSubscription? _subscription;
  late final List<T> _values;

  void _callListeners(T? item, int index, ItemChange change) {
    for (final itemListeners in _itemChangeListeners) {
      itemListeners(item, index, change);
    }

    for (final listener in _listeners) {
      listener();
    }
  }

  void addItemListener(OnItemListChanged<T> listener) {
    _itemChangeListeners.add(listener);
  }

  void removeItemListener(OnItemListChanged<T> listener) {
    _itemChangeListeners.remove(listener);
  }

  void _smartInsert(T newItem) {
    if (primarySort == null && secondarySort == null) {
      _values.add(newItem);

      return;
    }

    for (final existingItem in _values) {
      final sortResult = primarySort!(existingItem, newItem);

      if (sortResult == -1) {
        continue;
      }

      final existingItemIndex = _values.indexOf(existingItem);

      if (sortResult == 1) {
        _values.insert(existingItemIndex, newItem);

        return;
      }

      final secondarySortResult = secondarySort!(existingItem, newItem);

      if (secondarySortResult == 1) {
        _values.insert(existingItemIndex, newItem);
      } else {
        _values.insert(existingItemIndex + 1, newItem);
      }

      return;
    }

    // For a reason if the item was the last one, it never sorts correctly.
    // We add it to the end manually in this case.
    if (!_values.contains(newItem)) {
      _values.add(newItem);
    }
  }

  void _onBoxChanges(BoxEvent event) {
    final index = _values.indexWhere((e) => keyFunction(e) == event.key);

    final isInTheList = index != -1;

    if (event.deleted && isInTheList) {
      try {
        _values.removeAt(index);

        _callListeners(null, index, ItemChange.removed);
      } catch (_) {
        /* Nothing to do */
      }

      return;
    }

    final item = event.value as T;

    if (filterRule(item)) {
      if (isInTheList) {
        _values.replaceRange(index, index + 1, [item]);

        _callListeners(item, index, ItemChange.updated);
      } else {
        _smartInsert(item);

        final itemIndex = _values.indexOf(item);

        _callListeners(item, itemIndex, ItemChange.added);
      }
    } else {
      if (isInTheList) {
        _values.remove(item);

        _callListeners(item, index, ItemChange.removed);
      }
    }
  }

  @override
  @Deprecated('Use [addItemListener] instead')
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);

    if (_listeners.isEmpty) {
      _subscription?.cancel();
      _subscription = null;
    }
  }

  void dispose() {
    _listeners.clear();

    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Iterable<T> get value => _values;
}
