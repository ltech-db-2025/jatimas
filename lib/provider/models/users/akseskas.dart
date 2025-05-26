import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

class AksesKas {
  String? email;
  double? id;
  String? rekening;
  String? alias;
  double? saldo;

  AksesKas({this.email, this.id, this.rekening, this.alias, this.saldo});

  @override
  String toString() {
    return 'AksesKas(email: $email, id: $id, rekening: $rekening, alias: $alias, saldo: $saldo)';
  }

  factory AksesKas.fromMap(Map<String, dynamic> data) => AksesKas(
        email: makeStr(data['email']),
        id: makeDouble(data['id']),
        rekening: makeStr(data['rekening']),
        alias: makeStr(data['alias']) ?? "${(makeDouble(data['id']) ?? 0.0).toStringAsFixed(2)} - ${makeStr(data['rekening']) ?? ''}",
        saldo: makeDouble(data['saldo']),
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'id': id,
        'rekening': rekening,
        'alias': alias,
        'saldo': saldo,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AksesKas].
  factory AksesKas.fromJson(String data) {
    return AksesKas.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AksesKas] to a JSON string.
  String toJson() => json.encode(toMap());

  AksesKas copyWith({
    String? email,
    double? id,
    String? rekening,
    String? alias,
    double? saldo,
  }) {
    return AksesKas(
      email: email ?? this.email,
      id: id ?? this.id,
      rekening: rekening ?? this.rekening,
      alias: alias ?? this.alias,
      saldo: saldo ?? this.saldo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AksesKas) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => email.hashCode ^ id.hashCode ^ rekening.hashCode ^ alias.hashCode ^ saldo.hashCode;
}
