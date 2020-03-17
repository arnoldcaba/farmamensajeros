
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmamensajeros/models/direccion.dart';

class Servicio {
  String id;
  List<dynamic> directions;
  String uid;
  String cliente;
  String idMensajero;
  String email;
  String estado;
  String fecha;
  int tiempo;
  int distancia;
  int valor;

  Servicio({ this.id, this.directions, this.uid,this.cliente, this.email, this.estado, this.fecha, this.tiempo, this.distancia, this.valor });

}