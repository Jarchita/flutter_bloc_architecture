class APIException implements Exception {
  APIException(this._message);

  final String? _message;

  @override
  String toString() => "$_message";
}
