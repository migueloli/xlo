import 'package:flutter/foundation.dart';

class ApiError {

  final int code;
  final String message;

  ApiError({
    this.code = -1, 
    @required this.message
  });

}