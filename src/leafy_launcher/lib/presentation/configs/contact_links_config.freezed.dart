// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'contact_links_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ContactLinksConfig _$ContactLinksConfigFromJson(Map<String, dynamic> json) {
  return _ContactLinksConfig.fromJson(json);
}

/// @nodoc
mixin _$ContactLinksConfig {
  String get telegramChat => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get github => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContactLinksConfigCopyWith<ContactLinksConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactLinksConfigCopyWith<$Res> {
  factory $ContactLinksConfigCopyWith(
          ContactLinksConfig value, $Res Function(ContactLinksConfig) then) =
      _$ContactLinksConfigCopyWithImpl<$Res, ContactLinksConfig>;
  @useResult
  $Res call({String telegramChat, String email, String github});
}

/// @nodoc
class _$ContactLinksConfigCopyWithImpl<$Res, $Val extends ContactLinksConfig>
    implements $ContactLinksConfigCopyWith<$Res> {
  _$ContactLinksConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telegramChat = null,
    Object? email = null,
    Object? github = null,
  }) {
    return _then(_value.copyWith(
      telegramChat: null == telegramChat
          ? _value.telegramChat
          : telegramChat // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      github: null == github
          ? _value.github
          : github // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ContactLinksConfigCopyWith<$Res>
    implements $ContactLinksConfigCopyWith<$Res> {
  factory _$$_ContactLinksConfigCopyWith(_$_ContactLinksConfig value,
          $Res Function(_$_ContactLinksConfig) then) =
      __$$_ContactLinksConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String telegramChat, String email, String github});
}

/// @nodoc
class __$$_ContactLinksConfigCopyWithImpl<$Res>
    extends _$ContactLinksConfigCopyWithImpl<$Res, _$_ContactLinksConfig>
    implements _$$_ContactLinksConfigCopyWith<$Res> {
  __$$_ContactLinksConfigCopyWithImpl(
      _$_ContactLinksConfig _value, $Res Function(_$_ContactLinksConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? telegramChat = null,
    Object? email = null,
    Object? github = null,
  }) {
    return _then(_$_ContactLinksConfig(
      telegramChat: null == telegramChat
          ? _value.telegramChat
          : telegramChat // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      github: null == github
          ? _value.github
          : github // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ContactLinksConfig implements _ContactLinksConfig {
  const _$_ContactLinksConfig(
      {required this.telegramChat, required this.email, required this.github});

  factory _$_ContactLinksConfig.fromJson(Map<String, dynamic> json) =>
      _$$_ContactLinksConfigFromJson(json);

  @override
  final String telegramChat;
  @override
  final String email;
  @override
  final String github;

  @override
  String toString() {
    return 'ContactLinksConfig(telegramChat: $telegramChat, email: $email, github: $github)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContactLinksConfig &&
            (identical(other.telegramChat, telegramChat) ||
                other.telegramChat == telegramChat) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.github, github) || other.github == github));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, telegramChat, email, github);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ContactLinksConfigCopyWith<_$_ContactLinksConfig> get copyWith =>
      __$$_ContactLinksConfigCopyWithImpl<_$_ContactLinksConfig>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ContactLinksConfigToJson(
      this,
    );
  }
}

abstract class _ContactLinksConfig implements ContactLinksConfig {
  const factory _ContactLinksConfig(
      {required final String telegramChat,
      required final String email,
      required final String github}) = _$_ContactLinksConfig;

  factory _ContactLinksConfig.fromJson(Map<String, dynamic> json) =
      _$_ContactLinksConfig.fromJson;

  @override
  String get telegramChat;
  @override
  String get email;
  @override
  String get github;
  @override
  @JsonKey(ignore: true)
  _$$_ContactLinksConfigCopyWith<_$_ContactLinksConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
