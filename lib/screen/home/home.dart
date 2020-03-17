import 'package:farmamensajeros/models/brew.dart';
import 'package:farmamensajeros/models/servicio.dart';
import 'package:farmamensajeros/screen/home/serv_list.dart';
import 'package:farmamensajeros/screen/home/settings_form.dart';
import 'package:farmamensajeros/services/auth.dart';
import 'package:farmamensajeros/services/database.dart';
import 'package:farmamensajeros/shared/appbar.dart';
import 'package:farmamensajeros/shared/custom_drawer.dart';
import 'package:farmamensajeros/shared/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  // final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    /*void _showsettingsPanel () {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    } */

    return StreamProvider<List<Servicio>>.value(
      value: DatabaseService().servicios,
      child: Scaffold(
        // backgroundColor: Colors.brown[50],
        appBar: MyAppNav('FarmaMensajeros', context),
        drawer: CustomDrawer(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/what-the-hex.png'),
              fit: BoxFit.cover
            )
          ),
          child: ServList()
        ),
        floatingActionButton: floatingButton(),
      ),
    );
  }
}