import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_links_config.freezed.dart';
part 'contact_links_config.g.dart';

@freezed
class ContactLinksConfig with _$ContactLinksConfig {
  const factory ContactLinksConfig({
    required String telegramChat,
    required String email,
    required String github,
  }) = _ContactLinksConfig;

  // factory ContactLinksConfig.fromJson(Map<String, dynamic> json) => _$

  factory ContactLinksConfig.fromJson(Map<String, dynamic> json) =>
      _$ContactLinksConfigFromJson(json);
}
