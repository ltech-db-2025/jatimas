import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

class REKENING {
  double? kode;
  String? akun;
  int? nosubklasifikasi;
  String? alias;
  String? aliasInduk;
  int? saldo;
  String? updated;

  REKENING({
    this.kode,
    this.akun,
    this.nosubklasifikasi,
    this.alias,
    this.aliasInduk,
    this.saldo,
    this.updated,
  });

  @override
  String toString() {
    return 'REKENING(kode: $kode, akun: $akun, nosubklasifikasi: $nosubklasifikasi, alias: $alias, aliasInduk: $aliasInduk, saldo: $saldo, updated: $updated)';
  }

  factory REKENING.fromMap(Map<String, dynamic> data) => REKENING(
        kode: makeDouble(data['kode']),
        akun: makeStr(data['akun']),
        nosubklasifikasi: makeInt(data['nosubklasifikasi']),
        alias: makeStr(data['alias']),
        aliasInduk: makeStr(data['alias_induk']),
        saldo: makeInt(data['saldo']),
        updated: makeStr(data['updated']),
      );

  Map<String, dynamic> toMap() => {
        'kode': kode,
        'akun': akun,
        'nosubklasifikasi': nosubklasifikasi,
        'alias': alias,
        'alias_induk': aliasInduk,
        'saldo': saldo,
        'updated': updated,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [REKENING].
  factory REKENING.fromJson(String data) {
    return REKENING.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [REKENING] to a JSON string.
  String toJson() => json.encode(toMap());

  REKENING copyWith({
    double? kode,
    String? akun,
    int? nosubklasifikasi,
    String? alias,
    String? aliasInduk,
    int? saldo,
    String? updated,
  }) {
    return REKENING(
      kode: kode ?? this.kode,
      akun: akun ?? this.akun,
      nosubklasifikasi: nosubklasifikasi ?? this.nosubklasifikasi,
      alias: alias ?? this.alias,
      aliasInduk: aliasInduk ?? this.aliasInduk,
      saldo: saldo ?? this.saldo,
      updated: updated ?? this.updated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! REKENING) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => kode.hashCode ^ akun.hashCode ^ nosubklasifikasi.hashCode ^ alias.hashCode ^ aliasInduk.hashCode ^ saldo.hashCode ^ updated.hashCode;
}
