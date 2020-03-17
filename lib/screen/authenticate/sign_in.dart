import 'package:farmamensajeros/services/auth.dart';
import 'package:farmamensajeros/shared/constants.dart';
import 'package:farmamensajeros/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _fomrKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration( 
          image: DecorationImage( 
            image: AssetImage(
              'assets/what-the-hex.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Center(
          child: Container(
            width: 400.0,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _fomrKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: personalDecoration.copyWith(labelText: 'Email', hintText: 'Email *', icon: Icon(Icons.alternate_email)),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: personalDecoration.copyWith(labelText: 'Contraseña', hintText: 'Contraseña *', icon: Icon(Icons.lock_outline)),
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
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Error de autenticación';
                              loading = false;
                            });
                          }
                        }
                      },
                      color: Colors.lime,
                      child: Text('Ingresar', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}