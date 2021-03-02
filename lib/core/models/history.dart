import 'dart:convert';

import 'package:money_converter/core/models/currency.dart';

class History {
  final Currency fromCurrency;
  final Currency toCurrency;
  final String fromAmount;
  final String toAmount;
  final String date;
  History({
    this.fromCurrency,
    this.toCurrency,
    this.fromAmount,
    this.toAmount,
    this.date,
  });

  History copyWith({
    Currency fromCurrency,
    Currency toCurrency,
    String fromAmount,
    String toAmount,
    String date,
  }) {
    return History(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      fromAmount: fromAmount ?? this.fromAmount,
      toAmount: toAmount ?? this.toAmount,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fromCurrency': fromCurrency?.toMap(),
      'toCurrency': toCurrency?.toMap(),
      'fromAmount': fromAmount,
      'toAmount': toAmount,
      'date': date,
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return History(
      fromCurrency: Currency.fromMap(map['fromCurrency']),
      toCurrency: Currency.fromMap(map['toCurrency']),
      fromAmount: map['fromAmount'],
      toAmount: map['toAmount'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory History.fromJson(String source) =>
      History.fromMap(json.decode(source));

  @override
  String toString() {
    return 'History(fromCurrency: $fromCurrency, toCurrency: $toCurrency, fromAmount: $fromAmount, toAmount: $toAmount, date: $date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is History &&
        o.fromCurrency == fromCurrency &&
        o.toCurrency == toCurrency &&
        o.fromAmount == fromAmount &&
        o.toAmount == toAmount &&
        o.date == date;
  }

  @override
  int get hashCode {
    return fromCurrency.hashCode ^
        toCurrency.hashCode ^
        fromAmount.hashCode ^
        toAmount.hashCode ^
        date.hashCode;
  }
}
