class UnknownApplicationTypeException implements Exception {
  const UnknownApplicationTypeException();

  @override
  String toString() {
    return 'Application is of unknown type';
  }
}
