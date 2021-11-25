import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:leafy_launcher/utils/extensions/iterable_extensions.dart';

import 'item_change.dart';

typedef OnItemChanged<T> = void Function(T item, ItemChange change);

class HiveListenableValue<T> extends ValueListenable<T?> {
  HiveListenableValue(
    this.box, {
    required this.key,
    required this.keyFunction,
  }) {
    _subscription = box.watch().listen(_onBoxChanges);
  }

  final Box<T> box;

  final dynamic key;
  final dynamic Function(T item) keyFunction;

  final List<VoidCallback> _listeners = [];
  final List<OnItemChanged<T>> _itemChangeListeners = [];

  late StreamSubscription? _subscription;
  late T? _item = box.values.firstWhereOrNull(
    (element) => keyFunction(element) == key,
  );

  void _callListeners(T item, ItemChange change) {
    for (final itemListeners in _itemChangeListeners) {
      itemListeners(item, change);
    }

    for (final listener in _listeners) {
      listener();
    }
  }

  void addItemListener(OnItemChanged<T> listener) {
    _itemChangeListeners.add(listener);
  }

  void removeItemListener(OnItemChanged<T> listener) {
    _itemChangeListeners.remove(listener);
  }

  void _onBoxChanges(BoxEvent event) {
    final item = event.value;

    if (item is! T) {
      return;
    }

    if (keyFunction(item) != event.key) {
      return;
    }

    final change = event.deleted ? ItemChange.removed : ItemChange.added;

    if (event.deleted) {
      _item = null;
    }

    _item = item;

    _callListeners(item, change);
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
  T? get value => _item;
}
