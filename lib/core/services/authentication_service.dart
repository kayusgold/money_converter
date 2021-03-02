import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_converter/core/services/firestore_service.dart';
import 'package:money_converter/locator.dart';
import 'package:money_converter/core/models/user.dart' as MyUser;

class AuthenticationService {
  MyUser.User _currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FireStoreService _fireStoreService = locator<FireStoreService>();

  MyUser.User get currentUser => _currentUser;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(user.toString());
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        var user = MyUser.User(
            id: authResult.user.uid, email: authResult.user.email, name: name);
        await _fireStoreService.createUser(user);
      }
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    await _populateCurrentUser(user); // Populate the user information
    return user != null;
  }

  //takes a firebase user as argument and not model user
  Future _populateCurrentUser(User user) async {
    if (user != null) {
      _currentUser = await _fireStoreService.getUser(user.uid);
    }
  }

  Future<bool> logoutUser() async {
    await _firebaseAuth.signOut();
    return true;
  }
}
