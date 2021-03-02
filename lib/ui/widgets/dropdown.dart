import 'package:flutter/material.dart';
import 'package:money_converter/core/models/currency.dart';
import 'package:money_converter/core/viewmodels/home_viewmodel.dart';

myDropdown({
  String hintText,
  Currency selectedItem,
  List<Currency> currencies,
  HomeModel model,
  Function onChanged,
}) {
  return DropdownButton(
    hint: Text(hintText),
    value: selectedItem,
    onChanged: (Currency value) {
      onChanged(value, model);
    },
    items: currencies.map((Currency currency) {
      return DropdownMenuItem<Currency>(
        value: currency,
        child: Row(
          children: <Widget>[
            Text(currency.symbol),
            SizedBox(
              width: 10,
            ),
            Text(
              currency.name,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

List<Currency> currencies = []
  ..add(Currency(name: "US Dollar", symbol: "\$", acronym: "USD"))
  ..add(Currency(name: "Nigeria Naira", symbol: "N", acronym: "NGN"));
