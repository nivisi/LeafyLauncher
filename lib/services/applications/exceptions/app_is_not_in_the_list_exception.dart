class AppIsNotInTheListException implements Exception {
  const AppIsNotInTheListException({
    this.message = 'App was already removed from the list',
  });

  final String message;
}
