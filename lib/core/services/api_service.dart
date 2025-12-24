import 'dart:convert';
import 'dart:io';

import 'package:ecomm_422/core/exceptions/app_exceptions.dart';
import 'package:http/http.dart' as http;

class APIService {
  getAPI() {}

  Future<dynamic> postAPI({
    required String url,
    Map<String, dynamic>? mBody,
  }) async {
    Uri uri = Uri.parse(url);

    try {
      var response = await http.post(
        uri,
        body: mBody != null ? jsonEncode(mBody) : null,
      );
      return returnResponse(response);
    } on SocketException catch (e) {
      throw NoInternetException(msg: e.toString());
    } catch (e) {
      print(e);
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          print("Success");
          var data = jsonDecode(response.body);
          return data;
        }

      case 400:
        {
          throw BadRequestException(
            msg: "with status code ${response.statusCode}",
          );
        }

      case 401:
        {
          throw UnauthorizedException(
            msg: "with status code ${response.statusCode}",
          );
        }

      case 404:
        {
          throw NotFoundException(
            msg: "with status code ${response.statusCode}",
          );
        }

      case 500:
      default:
        {
          throw ServerException(msg: "with status code ${response.statusCode}");
        }
    }
  }
}
