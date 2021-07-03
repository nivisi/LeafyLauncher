import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'controller_base.dart';

enum ControllerStatus {
  loading,
  ready,
  error,
}

enum ControllerErrorType {
  connection,
  other,
}

class ControllerError {
  final ControllerErrorType type;
  final String? message;

  ControllerError({
    required this.type,
    this.message,
  });

  @override
  String toString() {
    return message ?? 'Status controller error';
  }
}

abstract class StatusControllerBase extends ControllerBase {
  static const statusGetKey = 'status';

  final Rx<ControllerStatus> _status = ControllerStatus.loading.obs;
  final Completer _loadedCompleter = Completer();

  ControllerError? _error;

  ControllerStatus get status => _status.value;
  ControllerError? get error => _error;

  bool get isLoading => status == ControllerStatus.loading;
  bool get isError => status == ControllerStatus.error;
  bool get isReady => status == ControllerStatus.ready;

  Future get ensureLoaded => _loadedCompleter.future;

  @protected
  @nonVirtual
  // ignore: invalid_override_of_non_virtual_member
  Future init() async {
    logger.i('Initializing ...');

    logger.i('Resolving dependencies ...');

    await resolveDependencies();

    try {
      logger.i('Loading ...');

      await load();

      statusReady();

      logger.i('Initialized!');
    } on Exception {
      logger.e('Initialized with error');

      statusError();
    } finally {
      _loadedCompleter.complete();
    }
  }

  @protected
  Future resolveDependencies() async {}

  @protected
  Future load() async {}

  @protected
  void statusLoading() {
    if (_status.value == ControllerStatus.loading) {
      return;
    }

    _status.value = ControllerStatus.loading;
    update([statusGetKey]);

    logger.d('Status -> Loading');
  }

  @protected
  void statusReady() {
    if (_status.value == ControllerStatus.ready) {
      return;
    }

    _status.value = ControllerStatus.ready;
    update([statusGetKey]);

    logger.d('Status -> Ready');
  }

  @protected
  void statusError([ControllerError? error]) {
    if (_status.value == ControllerStatus.error) {
      return;
    }

    _status.value = ControllerStatus.error;
    _error = error;

    update([statusGetKey]);

    logger.d('Status -> Error');
  }
}
