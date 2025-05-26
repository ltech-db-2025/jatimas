import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

class SumPenjualan {
  int nota;
  int notatempo;
  double piutang;
  double jtempo;
  int jmlpelanggan;
  int jmlpelangganjt;

  SumPenjualan({
    this.nota = 0,
    this.notatempo = 0,
    this.piutang = 0,
    this.jtempo = 0,
    this.jmlpelanggan = 0,
    this.jmlpelangganjt = 0,
  });

  @override
  String toString() {
    return 'SumPenjualan(nota: $nota, notatempo: $notatempo, piutang: $piutang, jtempo: $jtempo, jmlpelanggan: $jmlpelanggan, jmlpelangganjt: $jmlpelangganjt)';
  }

  factory SumPenjualan.fromMap(Map<String, dynamic> data) {
    return SumPenjualan(
      nota: makeInt(data['nota']) ?? 0,
      notatempo: makeInt(data['notatempo']) ?? 0,
      piutang: makeDouble(data['piutang']) ?? 0,
      jtempo: makeDouble(data['jtempo']) ?? 0,
      jmlpelanggan: makeInt(data['jmlpelanggan']) ?? 0,
      jmlpelangganjt: makeInt(data['jmlpelangganjt']) ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'nota': nota,
        'notatempo': notatempo,
        'piutang': piutang,
        'jtempo': jtempo,
        'jmlpelanggan': jmlpelanggan,
        'jmlpelangganjt': jmlpelangganjt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SumPenjualan].
  factory SumPenjualan.fromJson(String data) {
    return SumPenjualan.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SumPenjualan] to a JSON string.
  String toJson() => json.encode(toMap());

  SumPenjualan copyWith({
    int? nota,
    int? notatempo,
    double? piutang,
    double? jtempo,
    int? jmlpelanggan,
    int? jmlpelangganjt,
  }) {
    return SumPenjualan(
      nota: nota ?? this.nota,
      notatempo: notatempo ?? this.notatempo,
      piutang: piutang ?? this.piutang,
      jtempo: jtempo ?? this.jtempo,
      jmlpelanggan: jmlpelanggan ?? this.jmlpelanggan,
      jmlpelangganjt: jmlpelangganjt ?? this.jmlpelangganjt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SumPenjualan) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      nota.hashCode ^
      notatempo.hashCode ^
      piutang.hashCode ^
      jtempo.hashCode ^
      jmlpelanggan.hashCode ^
      jmlpelangganjt.hashCode;
}
