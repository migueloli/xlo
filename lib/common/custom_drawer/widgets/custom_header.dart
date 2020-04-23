import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo/screens/login/login_screen.dart';

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 115,
        padding: const EdgeInsets.only(left: 40),
        color: Colors.blue,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(width:20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Acesse sua conta",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    "Clique aqui",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginScreen()
        ));
      },
    );
  }
}
