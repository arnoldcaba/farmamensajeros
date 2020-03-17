import 'package:farmamensajeros/models/user.dart';
import 'package:farmamensajeros/services/auth.dart';
import 'package:farmamensajeros/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<Mensajero>(
      stream: DatabaseService(uid: user.uid).mensajeroData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Mensajero mensajero = snapshot.data;
          return Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(mensajero.nombre),
                  accountEmail: Text(mensajero.email),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/farmacomparatest.appspot.com/o/DomiciliariosImages%2Freduced_1570128146640.jpg?alt=media&token=86a6cc61-c603-44b3-be2b-ad7002a0a10b'),
                  )
                ),
                ListTile(
                  title: Text('Historial'),
                  onTap: () async{
                    Navigator.pushNamed(context, '/historial');
                  },
                ),
                ListTile(
                  title: Text('Salir'),
                  onTap: () async{
                    await _auth.signOut();
                    Navigator.pop(context,true);
                  },
                ),
              ],
            ),
          );
        }
      }
    );
  }
}