import 'dart:convert';

import 'package:collection/collection.dart';

class Top10 {
  int? idpegawai;
  int? tipe;
  int? nomor;
  int? tahun;
  int? bulan;
  String? nama;
  double? total;

  Top10({
    this.idpegawai,
    this.tipe,
    this.nomor,
    this.tahun,
    this.bulan,
    this.nama,
    this.total,
  });

  @override
  String toString() {
    return 'Top10(idpegawai: $idpegawai, tipe: $tipe, nomor: $nomor, tahun: $tahun, bulan: $bulan, nama: $nama, total: $total)';
  }

  factory Top10.fromMap(Map<String, dynamic> data) => Top10(
        idpegawai: data['idpegawai'] as int?,
        tipe: data['tipe'] as int?,
        nomor: data['nomor'] as int?,
        tahun: data['tahun'] as int?,
        bulan: data['bulan'] as int?,
        nama: data['nama'] as String?,
        total: (data['total'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'idpegawai': idpegawai,
        'tipe': tipe,
        'nomor': nomor,
        'tahun': tahun,
        'bulan': bulan,
        'nama': nama,
        'total': total,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Top10].
  factory Top10.fromJson(String data) {
    return Top10.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Top10] to a JSON string.
  String toJson() => json.encode(toMap());

  Top10 copyWith({
    int? idpegawai,
    int? tipe,
    int? nomor,
    int? tahun,
    int? bulan,
    String? nama,
    double? total,
  }) {
    return Top10(
      idpegawai: idpegawai ?? this.idpegawai,
      tipe: tipe ?? this.tipe,
      nomor: nomor ?? this.nomor,
      tahun: tahun ?? this.tahun,
      bulan: bulan ?? this.bulan,
      nama: nama ?? this.nama,
      total: total ?? this.total,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Top10) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => idpegawai.hashCode ^ tipe.hashCode ^ nomor.hashCode ^ tahun.hashCode ^ bulan.hashCode ^ nama.hashCode ^ total.hashCode;
}
