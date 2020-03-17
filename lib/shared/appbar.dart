import 'package:farmamensajeros/services/auth.dart';
import 'package:flutter/material.dart';

AppBar MyAppNav(String title, BuildContext context){
  final AuthService _auth = AuthService();
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.purple[400],
    elevation: 0.0,
    actions: <Widget>[
      FlatButton.icon(
        onPressed: () async {
          await _auth.signOut();
          Navigator.pop(context,true);
        },
        icon: Icon(Icons.person, color: Colors.white,),
        label: Text('Logout', style: TextStyle(color: Colors.white))
      )
    ],
  );
}