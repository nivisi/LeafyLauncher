import '../../resources/localization/l10n.dart';
import '../../resources/localization/l10n_provider.dart';

enum UserSelectedAppType {
  first,
  second,
  third,
  fourth,
  left,
  right,
}

extension UserSelectedAppTypeExtensions on UserSelectedAppType {
  String localize() {
    switch (this) {
      case UserSelectedAppType.first:
        return L10nProvider.getText(L10n.userSelectedAppTypeFirst);
      case UserSelectedAppType.second:
        return L10nProvider.getText(L10n.userSelectedAppTypeSecond);

      case UserSelectedAppType.third:
        return L10nProvider.getText(L10n.userSelectedAppTypeThird);

      case UserSelectedAppType.fourth:
        return L10nProvider.getText(L10n.userSelectedAppTypeFourth);

      case UserSelectedAppType.left:
        return L10nProvider.getText(L10n.userSelectedAppTypeLeft);

      case UserSelectedAppType.right:
        return L10nProvider.getText(L10n.userSelectedAppTypeRight);

      default:
        throw 'Unknown type';
    }
  }
}

const _first = 'First';
const _second = 'Second';
const _third = 'Third';
const _fourth = 'Fourth';
const _left = 'Left';
const _right = 'Right';

String stringifyUserSelectedAppType(UserSelectedAppType type) {
  switch (type) {
    case UserSelectedAppType.first:
      return _first;
    case UserSelectedAppType.second:
      return _second;
    case UserSelectedAppType.third:
      return _third;
    case UserSelectedAppType.fourth:
      return _fourth;
    case UserSelectedAppType.left:
      return _left;
    case UserSelectedAppType.right:
      return _right;
    default:
      throw 'Unknown type';
  }
}

UserSelectedAppType userSelectedAppTypeFromString(String str) {
  switch (str) {
    case _first:
      return UserSelectedAppType.first;
    case _second:
      return UserSelectedAppType.second;
    case _third:
      return UserSelectedAppType.third;
    case _fourth:
      return UserSelectedAppType.fourth;
    case _left:
      return UserSelectedAppType.left;
    case _right:
      return UserSelectedAppType.right;
    default:
      throw 'Unknown!';
  }
}
