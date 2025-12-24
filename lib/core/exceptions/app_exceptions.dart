class AppExceptions implements Exception{
  String exTitle, exMsg;
  AppExceptions({required this.exTitle, required this.exMsg});

  @override
  String toString() {
    return "$exTitle : $exMsg";
  }
}


class NoInternetException extends AppExceptions {
  NoInternetException({required String msg})
      : super(exTitle: "No Internet", exMsg: msg);
}

///500 and above
class ServerException extends AppExceptions {
  ServerException({required String msg})
      : super(exTitle: "Server Error", exMsg: msg);
}

class BadRequestException extends AppExceptions {
  BadRequestException({required String msg})
      : super(exTitle: "Bad Request", exMsg: msg);
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException({required String msg})
      : super(exTitle: "Unauthorized", exMsg: msg);
}
///404
class NotFoundException extends AppExceptions {
  NotFoundException({required String msg})
      : super(exTitle: "Not Found", exMsg: msg);
}

class InvalidInputException extends AppExceptions {
  InvalidInputException({required String msg})
      : super(exTitle: "Invalid Input", exMsg: msg);
}
