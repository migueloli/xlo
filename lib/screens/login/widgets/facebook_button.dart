import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/login_bloc.dart';
import 'package:xlo/blocs/login/login_bloc_state.dart';

class FacebookButton extends StatelessWidget {

  final LoginBloc loginBloc;

  FacebookButton(this.loginBloc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      height: 50,
      child: StreamBuilder<LoginBlocState>(
        stream: loginBloc.outState,
        initialData: LoginBlocState(LoginState.IDLE),
        builder: (context, snapshot) {
          return RaisedButton(
            elevation: 0,
            color: Color.fromRGBO(58, 89, 152, 1),
            disabledColor: Color.fromRGBO(58, 89, 152, 0.7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: snapshot.data.state == LoginState.LOADING_FACE ?
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white
                ),
              )
              : Text(
                "Entrar com Facebook",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            onPressed: snapshot.data.state != LoginState.LOADING_FACE
                ? () async {
                  final bool success = await loginBloc.loginWithFacebook();

                  if(success){
                    Navigator.of(context).pop();
                  }
                } : null,
          );
        },
      ),
    );
  }
}
