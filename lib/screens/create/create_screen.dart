import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/common/cep_field.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'widgets/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Inserir Anúncio'),
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            ImagesField(
              onSaved: (images) {
                print(images);
              },
              initialValue: [],
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Título *',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                  fontSize: 18,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              ),
              validator: (text) {
                if (text.isEmpty){
                  return 'Campo obrigatório';
                }

                return null;
              },
              onSaved: (t) {

              },
            ),
            TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Descrição *',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                  fontSize: 18,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              ),
              validator: (text) {
                if (text.trim().isEmpty) {
                  return 'Campo obrigatório';
                }

                if (text.trim().length < 10) {
                  return 'Descrição muito curta';
                }

                return null;
              },
              onSaved: (d) {

              },
            ),
            CepField(
              decoration: InputDecoration(
                labelText: 'CEP *',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                  fontSize: 18,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              ),
              onSaved: (a) {

              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Preço *',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                  fontSize: 18,
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                RealInputFormatter(centavos: true),
              ],
              validator: (text) {
                if (text.isEmpty) {
                  return 'Campo obrigatório';
                }

                if (double.tryParse(text) == null) {
                  return 'Utilize valores válidos';
                }

                return null;
              },
              onSaved: (price) {

              },
            ),
            Container(
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  if(_formKey.currentState.validate()){

                  }
                },
                color: Colors.pink,
                child: Text(
                  "Enviar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}