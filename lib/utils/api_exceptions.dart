class ApiException implements Exception {
  final String message;
  final String? prefix;

  ApiException(this.message, [this.prefix]);

  @override
  String toString() {
    if (prefix != null) {
      return "$prefix$message";
    }
    return message;
  }
}

class NetworkException extends ApiException {
  NetworkException([String? message])
    : super(message ?? "No Internet Connection", "Network Error: ");
}

class RequestException extends ApiException {
  RequestException([String? message])
    : super(message ?? "Request Timed Out", "Timeout: ");
}

class ServerException extends ApiException {
  ServerException([String? message])
    : super(message ?? "Internal Server Error", "Server Error: ");
}

class UnauthorizedException extends ApiException {
  UnauthorizedException([String? message])
    : super(message ?? "Unauthorized", "Auth Error: ");
}

class BadRequestException extends ApiException {
  BadRequestException([String? message])
    : super(message ?? "Invalid Request", "Bad Request: ");
}
