abstract class Failure implements Exception {
  final String message;
  Failure({this.message = 'An error has occurred'});

  @override
  String toString() => message;
}
