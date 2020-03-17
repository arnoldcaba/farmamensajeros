import 'package:farmamensajeros/screen/detalles/detalles.dart';
import 'package:farmamensajeros/screen/historial/historial.dart';
import 'package:farmamensajeros/screen/wrapper.dart';
import 'package:farmamensajeros/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value( // all the childs provider can access the value
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
          '/detalle': (context) => Detalles(),
          '/historial': (context) => Historial()
        },
        theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.lime,
          textTheme: TextTheme(body1: TextStyle(color: Colors.white)),
        )
      ),
    );
  }
}