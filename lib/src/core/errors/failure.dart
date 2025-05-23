abstract class Failure implements Exception {
  final String message;
  Failure({this.message = 'genericError'});

  @override
  String toString() => message;
}
