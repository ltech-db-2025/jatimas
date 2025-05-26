import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

class TERMIN {
  String? kode;
  String? nama;
  int? hari;
  int? tipePeriode;
  double? nilai;

  TERMIN({this.kode, this.nama, this.hari, this.tipePeriode, this.nilai});

  @override
  String toString() {
    return 'TERMIN(kode: $kode, nama: $nama, hari: $hari, tipePeriode: $tipePeriode, nilai: $nilai)';
  }

  factory TERMIN.fromMap(Map<String, dynamic> data) => TERMIN(
        kode: makeStr(data['kode']),
        nama: makeStr(data['nama']),
        hari: makeInt(data['hari']),
        tipePeriode: makeInt(data['tipe_periode']),
        nilai: makeDouble(data['nilai']),
      );

  Map<String, dynamic> toMap() => {
        'kode': kode,
        'nama': nama,
        'hari': hari,
        'tipe_periode': tipePeriode,
        'nilai': nilai,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TERMIN].
  factory TERMIN.fromJson(String data) {
    return TERMIN.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TERMIN] to a JSON string.
  String toJson() => json.encode(toMap());

  TERMIN copyWith({
    String? kode,
    String? nama,
    int? hari,
    int? tipePeriode,
    dynamic nilai,
  }) {
    return TERMIN(
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
      hari: hari ?? this.hari,
      tipePeriode: tipePeriode ?? this.tipePeriode,
      nilai: nilai ?? this.nilai,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TERMIN) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      kode.hashCode ^
      nama.hashCode ^
      hari.hashCode ^
      tipePeriode.hashCode ^
      nilai.hashCode;
}
