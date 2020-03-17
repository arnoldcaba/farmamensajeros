import 'package:farmamensajeros/models/servicio.dart';
import 'package:farmamensajeros/screen/home/serv_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServList extends StatefulWidget {
  @override
  _ServListState createState() => _ServListState();
}

class _ServListState extends State<ServList> {
  @override
  Widget build(BuildContext context) {
    final servicios = Provider.of<List<Servicio>>(context) ?? [];
    return ListView.builder(
      itemCount: servicios.length,
      itemBuilder: (contex, index) {
        return ServTile(servicio: servicios[index]);
      },);
  }
}