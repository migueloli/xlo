import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/blocs/cep_bloc.dart';
import 'package:xlo/models/address.dart';

class CepField extends StatefulWidget {

  final InputDecoration decoration;
  final FormFieldSetter<Address> onSaved;

  const CepField({Key key, this.decoration, this.onSaved}) : super(key: key);

  @override
  _CepFieldState createState() => _CepFieldState();
}

class _CepFieldState extends State<CepField> {

  InputDecoration get decoration => widget.decoration;
  FormFieldSetter<Address> get onSaved => widget.onSaved;

  CepBloc _cepBloc;

  @override
  void initState() {
    super.initState();

    _cepBloc = CepBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CepBlocState>(
      stream: _cepBloc.outCep,
      initialData: CepBlocState(cepFieldState: CepFieldState.INITIALIZING),
      builder: (context, snapshot) {
        if(snapshot.data.cepFieldState == CepFieldState.INITIALIZING) {
          return Container();
        }

        return Column(
          children: <Widget>[
            TextFormField(
              initialValue: snapshot.data.cep,
              decoration: decoration,
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ],
              onSaved: (c) {
                onSaved(Address());
              },
              onChanged: _cepBloc.onChanged,
              validator: (c) {
                switch(snapshot.data.cepFieldState) {
                  case CepFieldState.INITIALIZING:
                  case CepFieldState.INCOMPLETE:
                    return "Campo sendo processado";
                  case CepFieldState.INVALID:
                  case CepFieldState.API_ACCESS_ERROR:
                    return "Campo obrigatorio";
                  default:
                    return null;
                }
              },
            )
          ],
        );
      }
    );
  }

  void dispose() {
    _cepBloc?.dispose();

    super.dispose();
  }

}