import 'api_error.dart';

class ApiResponse {

  bool success;
  dynamic result;
  ApiError error;

  ApiResponse.sucess({this.result}) {
    success = true;
  }

  ApiResponse.error({this.error}) {
    success = false;
  }

}