import 'dart:ffi';
import 'package:farmamensajeros/models/direccion.dart';
import 'package:farmamensajeros/models/servicio.dart';
import 'package:farmamensajeros/models/user.dart';
import 'package:farmamensajeros/screen/detalles/card_directions.dart';
import 'package:farmamensajeros/services/database.dart';
import 'package:farmamensajeros/shared/appbar.dart';
import 'package:farmamensajeros/shared/custom_drawer.dart';
import 'package:farmamensajeros/shared/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class Detalles extends StatefulWidget {
  @override
  _DetallesState createState() => _DetallesState();
}

class _DetallesState extends State<Detalles> {

  List<TimelineModel> items = []; // declaracion de lista de timeline
  Direccion _dirSel; // direccion seleccionada

  function(value) { // funcion para actualizar la direccion seleccinada
    _dirSel = value;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    Map data = {};
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments; // recupera los argumentos pasados por url
    Servicio service = data['servicio']; // servicio en la activity
    List<dynamic> direcciones = data['servicio'].directions; // array de direcciones
    final user = Provider.of<User>(context); // trae el usuario

    Void _getColection(List<dynamic> directions) {
      items.clear();
      for (var dir in directions) {
        print(service.estado);
        Direccion direccion = Direccion(ciudad: dir['ciudad'], direccion: dir['direccion'], detalles: dir['detalles']);
        var colorSel = (direccion == _dirSel && service.estado == 'asignado') ? Colors.lime : Colors.grey; // solo el color si se selecciona
        items.add(
          TimelineModel(
            CardDirections(direccion: direccion, func: function),
            position: TimelineItemPosition.random,
            iconBackground: colorSel,
            icon: Icon(Icons.blur_circular)),
        );
      }
      return null;
    }

    // boton para tomar pedido
    var widgetAction;
    var tomarPed = RaisedButton(
      onPressed: () async {
        DatabaseService dataServ = DatabaseService(uid: service.uid);
        service.idMensajero = user.uid;
        service.estado = 'asignado';
        var actualiza = await dataServ.updateService(service);
        if (actualiza != null) {
          print('Error en la actualización de estado');
        } else {
          setState(() {
            
          });
        }
      },
      color: Colors.purple,
      child: Text('Tomar pedido', style: TextStyle(color: Colors.white)),
    );

    // boton para termnar pedido
    var terminarPed = RaisedButton(
      onPressed: () async {
        DatabaseService dataServ = DatabaseService(uid: service.uid);
        service.estado = 'terminado';
        var actualiza = await dataServ.updateService(service);
        if (actualiza != null) {
          print('Error en la actualización de estado');
        } else {
          Navigator.pop(context, 1);
        }
      },
      color: Colors.purple,
      child: Text('Terminar pedido', style: TextStyle(color: Colors.white)),
    );

    // seleccionando el boton correcto deacuerdo al estado
    if (service.estado == 'creado') {
      widgetAction = tomarPed;
    } else if (service.estado == 'asignado') {
      widgetAction = terminarPed;
    }
    
    final formatter = new NumberFormat("#,###");
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
      amount: service.valor.toDouble(),
      settings: MoneyFormatterSettings(
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      )
    );

    _getColection(direcciones);
    return Scaffold(
      appBar: MyAppNav('Detalles',context),
      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/what-the-hex.png'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                       child: ListTile(
                        /* leading: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.brown[brew.strength],
                          backgroundImage: AssetImage('assets/coffee_icon.png'),
                        ), */
                        onTap: () {},
                        title: Text(service.cliente),// Text(service.cliente),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(service.fecha),
                            Text(service.estado, style: TextStyle(fontSize: 20),)
                          ],
                        )
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                        child: Text(fmf.output.symbolOnLeft, style: TextStyle(fontSize: 20, color: Colors.black)),
                      )
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              child: Timeline(
                children: items,
                position: TimelinePosition.Left
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: widgetAction,
            )
          ],
        ),
      ),
      floatingActionButton: floatingButton(),
    );
  }
}