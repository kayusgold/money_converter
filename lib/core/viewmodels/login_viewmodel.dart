import 'package:flutter/material.dart';
import 'package:money_converter/core/enums/viewstates.dart';
import 'package:money_converter/core/services/authentication_service.dart';
import 'package:money_converter/core/services/shared_preference_service.dart';
import 'package:money_converter/core/viewmodels/base_model.dart';

import '../../locator.dart';

class LoginViewModel extends BaseModel {
  String _error;
  String _email = "";
  String _password = "";

  Map<int, dynamic> errors = {0: null, 1: null};

  var sharedPreferencesService = locator<SharedPreferencesService>();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String get error => _error;
  String get email => _email;
  String get password => _password;

  Future init() async {
    _email = await getFromSharedPreference("email");
    _password = await getFromSharedPreference("password");
    print("Retrieved Email: $_email, Password: $_password");
    setState(ViewState.NotifyMainThread);
  }

  Future login({@required String email, @required String password}) async {
    setErrorMessage(null);

    if (email.length < 5) {
      setErrorList(0, "Invalid Email address.");
      //print("email $email, password $password");
      return false;
    } else {
      setErrorList(0, null);
    }

    if (password.length < 4) {
      setErrorList(1, "Password is too short.");
      return false;
    } else {
      setErrorList(1, null);
    }

    //print("signUp called");
    setState(ViewState.Busy);
    var result = await _authenticationService.loginWithEmail(
        email: email, password: password);
    print("result: ${result.toString()}");
    if (result is bool) {
      if (result != null) {
        //login successful. Save login details to sharedpreferences
        saveToSharedPreference<String>("email", email);
        saveToSharedPreference<String>("password", password);
        return true;
      } else {
        setState(ViewState.Idle);
        setErrorMessage("General login failure. Please try again later");
        return false;
      }
    } else {
      setState(ViewState.Idle);
      setErrorMessage(result.toString());
      return false;
    }
  }

  setErrorMessage(String msg) {
    _error = msg;
    notifyListeners();
  }

  setErrorList(int index, dynamic msg) {
    errors[index] = msg;
    print("ErrorList Set for $index with value $msg");
    print("ErrorList index $index's value: ${errors[index]}");
    notifyListeners();
  }

  void saveToSharedPreference<T>(String key, T content) async {
    var pref = await sharedPreferencesService.sharedPreferences;
    if (content is String) {
      pref
          .setString(key, content)
          .then((result) => print("setString response: ${result.toString()}"));
    }
    if (content is bool) {
      pref.setBool(key, content);
    }
    if (content is int) {
      pref.setInt(key, content);
    }
    if (content is double) {
      pref.setDouble(key, content);
    }
    if (content is List<String>) {
      pref.setStringList(key, content);
    }
  }

  dynamic getFromSharedPreference(String key) async {
    var pref = await sharedPreferencesService.sharedPreferences;
    return pref.get(key);
  }
}
