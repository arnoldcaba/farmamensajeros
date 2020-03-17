import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmamensajeros/models/brew.dart';
import 'package:farmamensajeros/models/direccion.dart';
import 'package:farmamensajeros/models/servicio.dart';
import 'package:farmamensajeros/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  // collection reference
  final CollectionReference servCollection = Firestore.instance.collection('Servicios');

  // collection mensajeros
  final CollectionReference mensajeros = Firestore.instance.collection('Mensajeros');
  
  Future updateUserData (String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }


  // servicios list from snapshot
  List<Servicio> _listaDeServicios (QuerySnapshot snapshot) {
    return snapshot.documents.map((snap) {
      return Servicio(id:snap.data['id'] ?? '', directions: snap.data['directions'], uid: snap.data['uid'] ?? '', cliente: snap.data['cliente'] ?? '', email: snap.data['email'] ?? '', estado: snap.data['estado'] ?? '', fecha: snap.data['fecha'] ?? '', tiempo: snap.data['tiempo'] ?? 0, distancia: snap.data['distancia'] ?? 0, valor: snap.data['valor'] ?? 0);
    }).toList();
  }
  // listado de servicios totales
  Stream<List<Servicio>> get servicios {
    return servCollection.snapshots().map(_listaDeServicios);
  }

  Future updateService (Servicio serv) async {
    print('updating state');
    return await servCollection.document(serv.id).updateData({
      'domiciliario': serv.idMensajero,
      'estado': serv.estado
    });
  }


  // brew list from snapshot
  List<Brew> _brewListFromSnapShot (QuerySnapshot snapshot) {
    return snapshot.documents.map((snap) {
      return Brew(name: snap.data['name'] ?? '', sugars: snap.data['sugars'] ?? '', strength: snap.data['strength'] ?? 0);
    }).toList();
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }

  // user data from snapshot
  UserData _userDataFromSnapShot (DocumentSnapshot snapshot) {
    return UserData(uid: uid, name: snapshot.data['name'], sugars: snapshot.data['sugars'], strength: snapshot.data['strength']);
  }
  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapShot);
  }

  // user data from snapshot
  Mensajero _mensajeroDataFromSnapShot (DocumentSnapshot snapshot) {
    return Mensajero(uid: uid, nombre: snapshot.data['nombre'], email: snapshot.data['email'], phone: snapshot.data['phone']);
  }
  // get user doc stream
  Stream<Mensajero> get mensajeroData {
    
    return mensajeros.document(uid).snapshots().map(_mensajeroDataFromSnapShot);
  }

}