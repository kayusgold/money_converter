import 'package:flutter/material.dart';
import 'package:money_converter/core/enums/viewstates.dart';
import 'package:money_converter/core/services/authentication_service.dart';
import 'package:money_converter/core/viewmodels/base_model.dart';

import '../../locator.dart';

class SignUpViewModel extends BaseModel {
  String _error;
  Map<int, dynamic> errors = {0: null, 1: null};

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String get error => _error;

  Future signUp(
      {@required String name,
      @required String email,
      @required String password}) async {
    setErrorMessage(null);

    if (name.length < 5) {
      setErrorList(0, "Invalid Name.");
      //print("email $email, password $password");
      return false;
    } else {
      setErrorList(0, null);
    }

    if (email.length < 5) {
      setErrorList(1, "Invalid Email address.");
      //print("email $email, password $password");
      return false;
    } else {
      setErrorList(1, null);
    }

    if (password.length < 4) {
      setErrorList(2, "Password is too short.");
      return false;
    } else {
      setErrorList(2, null);
    }

    //print("signUp called");
    setState(ViewState.Busy);
    var result = await _authenticationService.signUpWithEmail(
        name: name, email: email, password: password);
    setState(ViewState.Idle);
    print("result: ${result.toString()}");
    if (result is bool) {
      if (result != null) {
        return true;
      } else {
        setErrorMessage("General sign up failure. Please try again later");
        return false;
      }
    } else {
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
}
