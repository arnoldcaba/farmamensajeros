import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmamensajeros/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference mensajeros = Firestore.instance.collection('Mensajeros');

  // create user obj
  User _userFromFirebase (FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebase(user));
  }
  
  // sign in anon
  Future signInAnon () async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in email pass
  Future signInWithEmailAndPassword (String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      DocumentSnapshot snap = await mensajeros.document(user.uid).get();
      if (snap.data.isNotEmpty) {
        return _userFromFirebase(user);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  // register email & password
  Future registerWithEmailAndPassword (String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // create an instance in the data base
      await DatabaseService(uid: user.uid).updateUserData('0', 'new Crew membre', 100);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}