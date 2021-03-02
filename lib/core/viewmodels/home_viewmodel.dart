import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:money_converter/core/enums/convertertype.dart';
import 'package:money_converter/core/enums/viewstates.dart';
import 'package:money_converter/core/models/api_response.dart';
import 'package:money_converter/core/models/currency.dart';
import 'package:money_converter/core/models/models.dart';
import 'package:money_converter/core/services/api_service.dart';
import 'package:money_converter/core/services/authentication_service.dart';
import 'package:money_converter/core/viewmodels/base_model.dart';
import 'package:money_converter/ui/widgets/dropdown.dart';

import '../../locator.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final APIService _api = locator<APIService>();

  User _user;
  Currency _firstCurrency, _secondCurrency;
  String _firstAmount, _secondAmount;

  Currency get firstCurrency => _firstCurrency;
  Currency get secondCurrency => _secondCurrency;
  String get firstAmount => _firstAmount;
  String get secondAmount => _secondAmount;

  User get user => _user;

  Future<bool> initSetup() async {
    //setState(ViewState.Busy);
    bool status;
    var isLoggedIn = await _authenticationService.isUserLoggedIn();
    if (!isLoggedIn) {
      status = false;
    }
    _user = _authenticationService.currentUser;
    status = true;
    //set currencies
    setCurrency(firstOrSecond: 1, currency: currencies[0], updateUI: false);
    setCurrency(firstOrSecond: 2, currency: currencies[1], updateUI: false);
    //set amounts
    setAmount(firstOrSecond: 1, amount: "1", updateUI: false);
    setAmount(firstOrSecond: 2, amount: "498", updateUI: false);
    setState(ViewState.NotifyMainThread);
    return status;
  }

  Future<bool> logout() async {
    await _authenticationService.logoutUser();
    return true;
  }

  setCurrency({int firstOrSecond, Currency currency, bool updateUI = true}) {
    if (firstOrSecond == 1) {
      _firstCurrency = currency;
    } else if (firstOrSecond == 2) {
      _secondCurrency = currency;
    }
    if (updateUI) setState(ViewState.NotifyMainThread);
  }

  setAmount({int firstOrSecond, String amount, bool updateUI = true}) {
    if (firstOrSecond == 1) {
      _firstAmount = amount;
    } else if (firstOrSecond == 2) {
      _secondAmount = amount;
    }
    if (updateUI) setState(ViewState.NotifyMainThread);
  }

  convertTheMoney({
    String firstAmount,
    String secondAmount,
    ConverterType converterType,
  }) async {
    double factor = 1;
    var res;
    print(
        "FirstCurrency: ${_firstCurrency.name}, SecondCurrency: ${_secondCurrency.name}, OldFirstAmount: $_firstAmount, NewFirstAmount: $firstAmount, OldSecondAmount: $_secondAmount, NewSecondAmount: $secondAmount");
    if (converterType == ConverterType.Amount) {
      var first = (_firstAmount != firstAmount && firstAmount.isNotEmpty)
          ? true
          : false;
      var second = (_secondAmount != secondAmount && _secondAmount.isNotEmpty)
          ? true
          : false;
      if (first || second) {
        //there is new amount and it is not empty string.
        if (first) {
          //convert firstAmount in _firstCurrency to newAmount in _secondCurrency
          //update _secondAmount with newAmount
        } else if (second) {
          //convert secondAmount in _secondCurrency to newAmount in _firstCurrency
          //update _firstAmount with newAmount
        }
      }
    }
    //any of the amounts did not change but currency changed.
    if (converterType == ConverterType.Currency) {
      try {
        ApiResponse response = await _api.convert();
        Map<String, double> quotes = response.quotes;
        quotes.forEach((k, v) {
          if (k == "USD${_firstCurrency.acronym}") {
            factor = v;
            res = double.parse(firstAmount) * v;
            print("Result in USD: $res");
            setAmount(
              firstOrSecond: 1,
              amount: res.toString(),
              updateUI: false,
            );
          } else if (k == "USD${_secondCurrency.acronym}") {
            res = double.parse(firstAmount) * v;
            print("Result in USD: $res");
            setAmount(
              firstOrSecond: 2,
              amount: res.toString(),
              updateUI: true,
            );
          }
        });
      } catch (e) {
        print("Error: $e");
      }
    }
  }
}
