// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

/// Provides [Ticker] objects.
///
/// To create an [AnimationController] in a class that uses this mixin, pass
/// `vsync: this` to the animation controller constructor whenever you
/// create a new animation controller.
///
/// If you only have a single [Ticker] (for example only a single
/// [AnimationController]) for the lifetime of your object, then using a
/// [GetSingleTickerProviderMixin] is more efficient. This is the common case.
mixin GetMultipleTickersProviderMixin on DisposableInterface
    implements TickerProvider {
  Set<Ticker>? _tickers;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _tickers ??= <_Ticker>{};
    final _Ticker result = _Ticker(
      onTick,
      this,
      debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null,
    );
    _tickers!.add(result);
    return result;
  }

  void _removeTicker(_Ticker ticker) {
    assert(_tickers != null);
    assert(_tickers!.contains(ticker));
    _tickers!.remove(ticker);
  }

  @override
  void onClose() {
    assert(
      () {
        if (_tickers != null) {
          for (final Ticker ticker in _tickers!) {
            if (ticker.isActive) {
              throw FlutterError.fromParts(<DiagnosticsNode>[
                ErrorSummary('$this was disposed with an active Ticker.'),
                ErrorDescription(
                  '$runtimeType created a Ticker via its TickerProviderStateMixin, but at the time '
                  'dispose() was called on the mixin, that Ticker was still active. All Tickers must '
                  'be disposed before calling super.dispose().',
                ),
                ErrorHint(
                  'Tickers used by AnimationControllers '
                  'should be disposed by calling dispose() on the AnimationController itself. '
                  'Otherwise, the ticker will leak.',
                ),
                ticker.describeForError('The offending ticker was'),
              ]);
            }
          }
        }
        return true;
      }(),
    );
    super.onClose();
  }
}

// This class should really be called _DisposingTicker or some such, but this
// class name leaks into stack traces and error messages and that name would be
// confusing. Instead we use the less precise but more anodyne "_WidgetTicker",
// which attracts less attention.
class _Ticker extends Ticker {
  _Ticker(TickerCallback onTick, this._creator, {String? debugLabel})
      : super(onTick, debugLabel: debugLabel);

  final GetMultipleTickersProviderMixin _creator;

  @override
  void dispose() {
    _creator._removeTicker(this);
    super.dispose();
  }
}
