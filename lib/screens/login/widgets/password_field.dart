import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {

  final FormFieldSetter<String> onSaved;
  final bool enabled;

  PasswordField({this.onSaved, this.enabled});

  @override
  Widget build(BuildContext context) {

    List<Widget> _buildBars(int level){
      List<Widget> list = [];
      final Color color = _getColor(level);
      final Border border = Border.all(color: Colors.grey);

      for(int i = 0; i < 4; i++) {
        list.add(
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color:  i <= level ? color : Colors.transparent,
                border: i > level ? border : null,
              ),
            ),
          )
        );
      }

      return list;
    }

    return FormField<String>(
      initialValue: "",
      onSaved: this.onSaved,
      validator: (text) {
        if(text.isEmpty || _calcScore(text) < 2) {
          return 'Senha inválida.';
        }

        return null;
      },
      builder: (state) {
        final int _level = _calcScore(state.value);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: state.didChange,
              enabled: enabled,
            ),
            if(state.value.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 6),
                height: 8,
                child: Row(
                  children: _buildBars(_level),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 10),
              child: state.value.isNotEmpty || state.hasError ? Text(
                state.value.isNotEmpty ? _getText(_level) : 'Senha inválida!',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: _getColor(_level),
                  fontSize: 12,
                ),
              ) : Container(),
            )
          ],
        );
      },
    );
  }

  int _calcScore(String text) {
    int score = 0;

    if(text.length > 8){
      score++;
    }

    if(text.contains(RegExp(r'[0-9]'))){
      score++;
    }
    
    if(text.contains(RegExp(r'[A-Z]'))){
      score++;
    }

    return score;
  }

  Color _getColor(int level) {
    switch(level) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.greenAccent;
      case 3:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  String _getText(int level) {
    switch(level) {
      case 0:
        return 'Senha muito fraca';
      case 1:
        return 'Senha razoavelmente fraca';
      case 2:
        return 'Senha razoavelmente forte';
      case 3:
        return 'Senha forte';
      default:
        return '';
    }
  }

}
