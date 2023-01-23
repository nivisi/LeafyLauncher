enum CornerButtonType {
  phone,
  messages,
  camera,
}

const _phone = 'phone';
const _messages = 'messages';
const _camera = 'camera';

String stringifyCornerButtonType(CornerButtonType type) {
  switch (type) {
    case CornerButtonType.phone:
      return _phone;
    case CornerButtonType.messages:
      return _messages;
    case CornerButtonType.camera:
      return _camera;
    default:
      throw Exception('Unknown type');
  }
}

CornerButtonType cornerButtonTypeFromString(String str) {
  switch (str) {
    case _phone:
      return CornerButtonType.phone;
    case _messages:
      return CornerButtonType.messages;
    case _camera:
      return CornerButtonType.camera;
    default:
      throw Exception('Unknown!');
  }
}
