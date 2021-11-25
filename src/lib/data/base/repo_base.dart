// ignore_for_file: avoid_catching_errors

import 'package:ensure_initialized/ensure_initialized.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:leafy_launcher/data/hive_extensions/hive_listenable_conditioned_box.dart';
import 'package:leafy_launcher/data/hive_extensions/hive_listenable_value.dart';
import 'package:leafy_launcher/utils/log/logable_mixin.dart';

import 'db_entity_base.dart';

abstract class RepositoryBase<T extends DbEntityBase>
    with LogableMixin, EnsureInitialized {
  @protected
  String get boxName;

  @protected
  Box<T>? box;

  @protected
  bool get isClosed => box == null || !box!.isOpen;

  @protected
  void throwIfClosed() {
    if (isClosed) {
      throw Exception('Box is closed');
    }
  }

  Future<RepositoryBase> initBox({List<int>? encryptionKey}) async {
    HiveAesCipher? cipher;

    logger.i('Initializing ...');

    if (encryptionKey != null) {
      cipher = HiveAesCipher(encryptionKey);
    }

    try {
      try {
        box = await Hive.openBox(boxName, encryptionCipher: cipher);

        logger.i('Initialized!');

        return this;
      } on Exception catch (e, s) {
        logger.e('Unable to initialize', e, s);
      } on Error catch (e, s) {
        logger.e('Unable to initialize', e, s);
      }

      if (await Hive.boxExists(boxName)) {
        logger.i('Removing the box ...');

        await Hive.deleteBoxFromDisk(boxName);
      }

      box = await Hive.openBox(boxName, encryptionCipher: cipher);

      logger.i('Initialized!');
    } finally {
      initializedSuccessfully();
    }

    return this;
  }

  Future<void> close() async {
    throwIfClosed();

    logger.i('Closing ...');

    await box!.close();
    box = null;

    logger.i('Closed!');
  }

  T? getById(String id) {
    throwIfClosed();

    return box!.get(id);
  }

  Iterable<T> getAll() {
    throwIfClosed();

    final items = box!.values;

    return items.toList();
  }

  Future<void> add(T model) {
    throwIfClosed();

    return box!.put(model.id, model);
  }

  Future<void> addAll(Iterable<T> models) {
    throwIfClosed();

    return box!.putAll(
      {
        for (var item in models) item.id: item,
      },
    );
  }

  Future<void> clear() async {
    throwIfClosed();

    await box?.clear();
  }

  Future<void> delete(T model) {
    throwIfClosed();

    return box!.delete(model.id);
  }

  Future<void> deleteAll(Iterable<T> models) async {
    throwIfClosed();

    await box!.deleteAll(models.map((item) => item.id));
  }

  HiveListenableConditionedList<T> getConditionedListenableBox({
    FilterRule<T>? filterRule,
    SortFunction<T>? primarySort,
    SortFunction<T>? secondarySort,
  }) {
    if (box == null) {
      throw Exception(
        'Cannot get conditioned listenable box: the repo box was null',
      );
    }

    return HiveListenableConditionedList<T>(
      box!,
      keyFunction: (model) => model.id,
      filterRule: filterRule ?? (_) => true,
      primarySort: primarySort,
      secondarySort: (a, b) => a.id.compareTo(b.id),
    );
  }

  HiveListenableValue<T> getListenableValue(String id) {
    if (box == null) {
      throw Exception(
        'Cannot get conditioned listenable box: the repo box was null',
      );
    }

    return HiveListenableValue<T>(
      box!,
      key: id,
      keyFunction: (model) => model.id,
    );
  }
}
