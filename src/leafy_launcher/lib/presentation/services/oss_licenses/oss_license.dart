class OssLicense {
  OssLicense({
    required this.name,
    required this.version,
    this.description,
    required this.license,
    this.homepage,
  });

  final String name;
  final String version;
  final String? description;
  final String license;
  final String? homepage;
}
