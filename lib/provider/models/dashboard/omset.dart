import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

class Omset {
  String? periode;
  int tipe;
  int tahun;
  int bulan;
  double total;
  double totalasli;

  Omset({
    this.periode,
    this.tipe = 0,
    this.tahun = 0,
    this.bulan = 0,
    this.total = 0,
    this.totalasli = 0,
  });

  @override
  String toString() {
    return 'Omset(periode: $periode, tipe: $tipe, tahun: $tahun, bulan: $bulan, total: $total, totalasli: $totalasli)';
  }

  Omset clone() => Omset(periode: periode, tahun: tahun, bulan: bulan, total: total);
  factory Omset.fromMap(Map<String, dynamic> data) => Omset(
        periode: makeStr(data['periode']),
        tipe: makeInt(data['tipe'])??0,
        tahun: makeInt(data['tahun'])??0,
        bulan: makeInt(data['bulan'])??0,
        total: makeDouble(data['total'])??0,
        totalasli: makeDouble(data['totalasli'])??0,
      );

  Map<String, dynamic> toMap() => {
        'periode': periode,
        'tipe': tipe,
        'tahun': tahun,
        'bulan': bulan,
        'total': total,
        'totalasli': totalasli,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Omset].
  factory Omset.fromJson(String data) {
    return Omset.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Omset] to a JSON string.
  String toJson() => json.encode(toMap());

  Omset copyWith({
    String? periode,
    int? tipe,
    int? tahun,
    int? bulan,
    double? total,
    double? totalasli,
  }) {
    return Omset(
      periode: periode ?? this.periode,
      tipe: tipe ?? this.tipe,
      tahun: tahun ?? this.tahun,
      bulan: bulan ?? this.bulan,
      total: total ?? this.total,
      totalasli: totalasli ?? this.totalasli,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Omset) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => periode.hashCode ^ tipe.hashCode ^ tahun.hashCode ^ bulan.hashCode ^ total.hashCode ^ totalasli.hashCode;
}
