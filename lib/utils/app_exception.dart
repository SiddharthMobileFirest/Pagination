class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class InterNetException extends AppException {
  InterNetException([String? message])
      : super(message, 'No internet connection');
}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message]) : super(message, 'Request time out');
}

class ServerException extends AppException {
  ServerException([String? message]) : super(message, 'Internal server error');
}

class InvalidUrlException extends AppException {
  InvalidUrlException([String? message]) : super(message, 'Invalid url');
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error while fetching data ');
}
