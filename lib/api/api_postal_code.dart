import 'package:dio/dio.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/repositories/api_error.dart';
import 'package:xlo/repositories/api_response.dart';

Future<ApiResponse> getAddressFromAPI(String postalCode) async {

  final String endpoint =
    'http://viacep.com.br/'
    'ws/${postalCode.replaceAll('.', '').replaceAll('-', '')}/json/';

  try{
    final Response response = await Dio().get<Map>(endpoint);

    if(response.data.containsKey('erro') && response.data['erro']) {
      return ApiResponse.error(
        error: ApiError(
          code: 1,
          message: "CEP inválido",
        )
      );
    }

    final Address address = Address.fromMap(response.data);

    return ApiResponse.sucess(
      result: address,
    );
  } on DioError {
    return ApiResponse.error(
      error: ApiError(
        code: 2,
        message: "Falha ao contactar VIACEP",
      )
    );
  }
}