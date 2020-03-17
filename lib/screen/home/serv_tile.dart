import 'package:farmamensajeros/models/servicio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class ServTile extends StatelessWidget {
  final Servicio servicio;
  ServTile({ this.servicio });
  @override
  Widget build(BuildContext context) {
    // print('servicio');
    // print(servicio.directions);
    final formatter = new NumberFormat("#,###");
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
      amount: servicio.valor.toDouble(),
      settings: MoneyFormatterSettings(
        thousandSeparator: '.',
        decimalSeparator: ',',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      )
    );
    return Container(
      padding: EdgeInsets.only(top: 8.0), 
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/detalle', arguments: { 'servicio': servicio });
          },
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(servicio.cliente),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.map),
                  SizedBox(width: 5.0),
                  Text('${servicio.distancia / 1000} Km'),
                  SizedBox(width: 10.0),
                  Icon(Icons.timer),
                  SizedBox(width: 5.0),
                  Text('${formatter.format(servicio.tiempo / 60)} Min'),
                ],
              ),
              Text(fmf.output.symbolOnLeft, style: TextStyle(fontSize: 20))
          ],),
        ),
      ),
    );
  }
}