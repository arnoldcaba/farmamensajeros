import 'package:farmamensajeros/services/auth.dart';
import 'package:farmamensajeros/shared/constants.dart';
import 'package:farmamensajeros/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _fomrKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('sign up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () { widget.toggleView(); }, icon: Icon(Icons.person), label: Text('Sing in'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _fomrKey,
          child: Column(children: <Widget>[
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: personalDecoration.copyWith(hintText: 'Email *', icon: Icon(Icons.person)),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: personalDecoration.copyWith(hintText: 'Password *', icon: Icon(Icons.lock_outline)),
              obscureText: true,
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
              validator: (val) => val.length <= 5 ? 'password must be greater than 6 chars' : null,
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              onPressed: () async {
                if (_fomrKey.currentState.validate()) { // true or false
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                   if (result == null) {
                    setState(() {
                      error = 'Pleasy supply a valid email';
                      loading = false;
                    });
                  }
                }
              },
              color: Colors.pink[400],
              child: Text('Register', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],),
        ),
      )
    );
  }
}