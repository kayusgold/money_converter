import 'dart:convert';

class Currency {
  final String name;
  final String symbol;
  final String acronym;

  Currency({
    this.name,
    this.symbol,
    this.acronym,
  });

  Currency copyWith({
    String name,
    String symbol,
    String acronym,
  }) {
    return Currency(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      acronym: acronym ?? this.acronym,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'symbol': symbol,
      'acronym': acronym,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Currency(
      name: map['name'],
      symbol: map['symbol'],
      acronym: map['acronym'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));

  @override
  String toString() =>
      'Currency(name: $name, symbol: $symbol, acronym: $acronym)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Currency &&
        o.name == name &&
        o.symbol == symbol &&
        o.acronym == acronym;
  }

  @override
  int get hashCode => name.hashCode ^ symbol.hashCode ^ acronym.hashCode;
}
