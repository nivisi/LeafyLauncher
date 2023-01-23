import 'package:controllable_flutter/controllable_flutter.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:leafy_data/leafy_data.dart';
import 'package:leafy_domain/leafy_domain.dart';
import 'package:leafy_launcher/presentation/extensions/locale_extensions.dart';

part 'calendar_controller.x.dart';
part 'calendar_event.dart';
part 'calendar_state.dart';

@injectable
@XControllable<CalendarEvent>()
class CalendarController extends XController<CalendarState>
    with _$CalendarController, ControllableSubscriptions {
  CalendarController(this._getStreamablePreferencesUseCase);

  final GetStreamablePreferencesUseCase _getStreamablePreferencesUseCase;

  @override
  CalendarState createInitialState() {
    return createCalendarState(
      locale: SupportedLocale.en.toFlutterLocale(),
    );
  }

  @override
  void onProvided() {
    super.onProvided();

    subscribeTo(
      _getStreamablePreferencesUseCase().listen((event) {
        emitWith(locale: event.locale.toFlutterLocale());
      }),
    );
  }
}
