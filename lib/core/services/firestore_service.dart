import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_converter/core/models/history.dart';
import 'package:money_converter/core/models/models.dart';

class FireStoreService {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _historyCollectionReference =
      FirebaseFirestore.instance.collection("history");

  Future createUser(User user) async {
    try {
      await _userCollectionReference.doc(user.id).set(user.toMap());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _userCollectionReference.doc(uid).get();
      return User.fromMap(userData.data());
    } catch (e) {
      return e.message;
    }
  }

  Future saveHistory(User user, History history) async {
    try {
      await _historyCollectionReference.doc(user.id).set(history.toMap());
    } catch (e) {
      return e.message;
    }
  }

  Future getHistory(String uid) async {
    try {
      var mHistory = await _historyCollectionReference.doc(uid).get();
      return History.fromMap(mHistory.data());
    } catch (e) {
      return e.message;
    }
  }
}
