import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final String? uid;
  AuthService({this.uid});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  Users _userFromFirebaseUser(User? user) {
    return Users(uid: user!.uid);
  }

// auth change user stream
  Stream<Users?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);

    // .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      // print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
    String name,
    String email,
    String phone,
    String password,
    String address,
    String imageUrl,

  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;

      if (user != null) {
        await DatabaseService(uid: user.uid)
            .updateUserData(name, email, phone, address,imageUrl);
      } else {
        // print('unuble to create account');
      }
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error);

      return null;
    }
  }

  // register with delivery person
  Future registerDelivery(
    String name,
    String phone,
    String email,
    String password,
    String address,
    String imageUrl,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      if (user != null) {
        await DatabaseService(uid: user.uid)
            .addNewDelivery(name, phone, email, address, imageUrl);
        return "registered successfully!";
      } else {
        return "not registerd";
      }
      // return _userFromFirebaseUser(user);
    } catch (error) {
      // print('error:');
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      // print(error.toString());
      return null;
    }
  }
}
