class UninstallSystemAppException implements Exception {
  const UninstallSystemAppException({
    this.message = 'Unable to uninstall a system app',
  });

  final String message;
}
