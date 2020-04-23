import 'package:rxdart/rxdart.dart';
import 'package:xlo/api/api_postal_code.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/repositories/api_response.dart';

enum CepFieldState {
  INITIALIZING,
  INCOMPLETE,
  API_ACCESS_ERROR,
  INVALID,
  VALID
}

class CepBlocState {

  CepFieldState cepFieldState;
  String cep;
  Address address;

  CepBlocState({this.cepFieldState, this.cep, this.address});

}

class CepBloc {
  
  final BehaviorSubject<CepBlocState> _cepController = BehaviorSubject<CepBlocState>();
  Stream<CepBlocState> get outCep => _cepController.stream;

  void onChanged(String cep) {
    cep = cep.trim().replaceAll('-', '').replaceAll('.', '');

    if(cep.length < 8) {
      _cepController.add(
        CepBlocState(
          cepFieldState: CepFieldState.INCOMPLETE,
          cep: cep,
        ),
      );
    } else {
      searchCep(cep);
    }
  }

  void searchCep(String cep) async {
    final ApiResponse apiResponse = await getAddressFromAPI(cep);

    if(apiResponse.success) {
      _cepController.add(
        CepBlocState(
          cepFieldState: CepFieldState.VALID,
          cep: cep,
          address: apiResponse.result,
        ),
      );
    } else {
      _cepController.add(
        CepBlocState(
          cepFieldState: apiResponse.error.code == 1 ? CepFieldState.INVALID : CepFieldState.API_ACCESS_ERROR,
          cep: cep,
        ),
      );
    }
  }

  void dispose() {
    _cepController.close();
  }

}