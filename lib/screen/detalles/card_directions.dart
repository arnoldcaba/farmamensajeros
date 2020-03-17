import 'package:farmamensajeros/models/direccion.dart';
import 'package:flutter/material.dart';

class CardDirections extends StatelessWidget {
  Direccion direccion;
  final Function func;
  CardDirections({ this.direccion, this.func });

  Direccion getDirection () {
    return this.direccion;
  }

  @override
  Widget build(BuildContext context) {
    double elevacion = 5.0;

    return Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        elevation: elevacion,
        child: ListTile(
          onTap: () {
            func(direccion);
          },
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(direccion.direccion),
          ),
          subtitle: Text(direccion.detalles)
        ),
      );
  }
}