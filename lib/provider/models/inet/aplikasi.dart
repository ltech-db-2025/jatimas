import 'dart:convert';

import 'package:collection/collection.dart';

class APLIKASI {
  int? id;
  String? nama;
  String? bidang;
  String? alamat;
  String? kota;
  int? retail;
  int? iddb;
  int? jasa;
  int? dashboard;
  int? assembly;
  int? apk;
  String? keterangan;
  int? aktif;
  int? lokasiumum;

  APLIKASI({
    this.id,
    this.nama,
    this.bidang,
    this.alamat,
    this.kota,
    this.retail,
    this.iddb,
    this.jasa,
    this.dashboard,
    this.assembly,
    this.apk,
    this.keterangan,
    this.aktif,
    this.lokasiumum,
  });

  @override
  String toString() {
    return 'APLIKASI(id: $id, nama: $nama, bidang: $bidang, alamat: $alamat, kota: $kota, retail: $retail, iddb: $iddb, jasa: $jasa, dashboard: $dashboard, assembly: $assembly, apk: $apk, keterangan: $keterangan, aktif: $aktif, lokasiumum: $lokasiumum)';
  }

  factory APLIKASI.fromMap(Map<String, dynamic> data) => APLIKASI(
        id: data['id'] as int?,
        nama: data['nama'] as String?,
        bidang: data['bidang'] as String?,
        alamat: data['alamat'] as String?,
        kota: data['kota'] as String?,
        retail: data['retail'] as int?,
        iddb: data['iddb'] as int?,
        jasa: data['jasa'] as int?,
        dashboard: data['dashboard'] as int?,
        assembly: data['assembly'] as int?,
        apk: data['apk'] as int?,
        keterangan: data['keterangan'] as String?,
        aktif: data['aktif'] as int?,
        lokasiumum: data['lokasiumum'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama': nama,
        'bidang': bidang,
        'alamat': alamat,
        'kota': kota,
        'retail': retail,
        'iddb': iddb,
        'jasa': jasa,
        'dashboard': dashboard,
        'assembly': assembly,
        'apk': apk,
        'keterangan': keterangan,
        'aktif': aktif,
        'lokasiumum': lokasiumum,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [APLIKASI].
  factory APLIKASI.fromJson(String data) {
    return APLIKASI.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [APLIKASI] to a JSON string.
  String toJson() => json.encode(toMap());

  APLIKASI copyWith({
    int? id,
    String? nama,
    String? bidang,
    String? alamat,
    String? kota,
    int? retail,
    int? iddb,
    int? jasa,
    int? dashboard,
    int? assembly,
    int? apk,
    String? keterangan,
    int? aktif,
    int? lokasiumum,
  }) {
    return APLIKASI(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      bidang: bidang ?? this.bidang,
      alamat: alamat ?? this.alamat,
      kota: kota ?? this.kota,
      retail: retail ?? this.retail,
      iddb: iddb ?? this.iddb,
      jasa: jasa ?? this.jasa,
      dashboard: dashboard ?? this.dashboard,
      assembly: assembly ?? this.assembly,
      apk: apk ?? this.apk,
      keterangan: keterangan ?? this.keterangan,
      aktif: aktif ?? this.aktif,
      lokasiumum: lokasiumum ?? this.lokasiumum,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! APLIKASI) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      nama.hashCode ^
      bidang.hashCode ^
      alamat.hashCode ^
      kota.hashCode ^
      retail.hashCode ^
      iddb.hashCode ^
      jasa.hashCode ^
      dashboard.hashCode ^
      assembly.hashCode ^
      apk.hashCode ^
      keterangan.hashCode ^
      aktif.hashCode ^
      lokasiumum.hashCode;
}
