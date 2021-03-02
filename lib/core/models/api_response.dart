import 'dart:convert';

import 'package:flutter/foundation.dart';

// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromMap(jsonString);

import 'dart:convert';

ApiResponse apiResponseFromMap(String str) =>
    ApiResponse.fromMap(json.decode(str));

String apiResponseToMap(ApiResponse data) => json.encode(data.toMap());

class ApiResponse {
  ApiResponse({
    this.success,
    this.terms,
    this.privacy,
    this.timestamp,
    this.source,
    this.quotes,
  });

  bool success;
  String terms;
  String privacy;
  int timestamp;
  String source;
  Map<String, double> quotes;

  factory ApiResponse.fromMap(Map<String, dynamic> json) => ApiResponse(
        success: json["success"],
        terms: json["terms"],
        privacy: json["privacy"],
        timestamp: json["timestamp"],
        source: json["source"],
        quotes: Map.from(json["quotes"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "terms": terms,
        "privacy": privacy,
        "timestamp": timestamp,
        "source": source,
        "quotes":
            Map.from(quotes).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

// class ApiResponse {
//   final bool status;
//   final String terms;
//   final String privacy;
//   final int timestamp;
//   final String source;
//   final List<Quote> quotes;
//   ApiResponse({
//     this.status,
//     this.terms,
//     this.privacy,
//     this.timestamp,
//     this.source,
//     this.quotes,
//   });

//   ApiResponse copyWith({
//     bool status,
//     String terms,
//     String privacy,
//     double timestamp,
//     String source,
//     List<Quote> quotes,
//   }) {
//     return ApiResponse(
//       status: status ?? this.status,
//       terms: terms ?? this.terms,
//       privacy: privacy ?? this.privacy,
//       timestamp: timestamp ?? this.timestamp,
//       source: source ?? this.source,
//       quotes: quotes ?? this.quotes,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'status': status,
//       'terms': terms,
//       'privacy': privacy,
//       'timestamp': timestamp,
//       'source': source,
//       'quotes': quotes?.map((x) => x?.toMap())?.toList(),
//     };
//   }

//   factory ApiResponse.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return ApiResponse(
//       status: map['status'],
//       terms: map['terms'],
//       privacy: map['privacy'],
//       timestamp: map['timestamp'],
//       source: map['source'],
//       quotes: List<Quote>.from(map['quotes']?.map((x) => Quote.fromMap(x))),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ApiResponse.fromJson(String source) =>
//       ApiResponse.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'ApiResponse(status: $status, terms: $terms, privacy: $privacy, timestamp: $timestamp, source: $source, quotes: $quotes)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is ApiResponse &&
//         o.status == status &&
//         o.terms == terms &&
//         o.privacy == privacy &&
//         o.timestamp == timestamp &&
//         o.source == source &&
//         listEquals(o.quotes, quotes);
//   }

//   @override
//   int get hashCode {
//     return status.hashCode ^
//         terms.hashCode ^
//         privacy.hashCode ^
//         timestamp.hashCode ^
//         source.hashCode ^
//         quotes.hashCode;
//   }
// }

// class Quote {
//   final String name;
//   final double value;
//   Quote({
//     this.name,
//     this.value,
//   });

//   Quote copyWith({
//     String name,
//     double value,
//   }) {
//     return Quote(
//       name: name ?? this.name,
//       value: value ?? this.value,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'value': value,
//     };
//   }

//   factory Quote.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Quote(
//       name: map['name'],
//       value: map['value'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Quote.fromJson(String source) => Quote.fromMap(json.decode(source));

//   @override
//   String toString() => 'Quote(name: $name, value: $value)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is Quote && o.name == name && o.value == value;
//   }

//   @override
//   int get hashCode => name.hashCode ^ value.hashCode;
// }
