import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';
class LOKASI {
  int? id;
  String? kode;
  String? nama;
  String? alamat;
  String? kota;
  String? pimpinan;
  String? telp;
  String? fax;
  int? aktif;
  String? hp;
  String? wa;
  String? email;
  String? updated;

  LOKASI({
    this.id,
    this.kode,
    this.nama,
    this.alamat,
    this.kota,
    this.pimpinan,
    this.telp,
    this.fax,
    this.aktif,
    this.hp,
    this.wa,
    this.email,
    this.updated,
  });

  @override
  String toString() {
    return 'LOKASI(id: $id, kode: $kode, nama: $nama, alamat: $alamat, kota: $kota, pimpinan: $pimpinan, telp: $telp, fax: $fax, aktif: $aktif, hp: $hp, wa: $wa, email: $email, updated: $updated)';
  }

  factory LOKASI.fromMap(Map<String, dynamic> data) => LOKASI(
        id: makeInt(data['id']),
        kode: makeStr(data['kode']),
        nama: makeStr(data['nama']),
        alamat: makeStr(data['alamat']),
        kota: makeStr(data['kota']),
        pimpinan: makeStr(data['pimpinan']),
        telp: makeStr(data['telp']),
        fax: makeStr(data['fax']),
        aktif: makeInt(data['aktif']),
        hp: makeStr(data['hp']),
        wa: makeStr(data['wa']),
        email: makeStr(data['email']),
        updated: makeStr(data['updated']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'kode': kode,
        'nama': nama,
        'alamat': alamat,
        'kota': kota,
        'pimpinan': pimpinan,
        'telp': telp,
        'fax': fax,
        'aktif': aktif,
        'hp': hp,
        'wa': wa,
        'email': email,
        'updated': updated,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LOKASI].
  factory LOKASI.fromJson(String data) {
    return LOKASI.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LOKASI] to a JSON string.
  String toJson() => json.encode(toMap());

  LOKASI copyWith({
    int? id,
    String? kode,
    String? nama,
    String? alamat,
    String? kota,
    String? pimpinan,
    String? telp,
    String? fax,
    int? aktif,
    String? hp,
    String? wa,
    String? email,
    String? updated,
  }) {
    return LOKASI(
      id: id ?? this.id,
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
      alamat: alamat ?? this.alamat,
      kota: kota ?? this.kota,
      pimpinan: pimpinan ?? this.pimpinan,
      telp: telp ?? this.telp,
      fax: fax ?? this.fax,
      aktif: aktif ?? this.aktif,
      hp: hp ?? this.hp,
      wa: wa ?? this.wa,
      email: email ?? this.email,
      updated: updated ?? this.updated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LOKASI) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      kode.hashCode ^
      nama.hashCode ^
      alamat.hashCode ^
      kota.hashCode ^
      pimpinan.hashCode ^
      telp.hashCode ^
      fax.hashCode ^
      aktif.hashCode ^
      hp.hashCode ^
      wa.hashCode ^
      email.hashCode ^
      updated.hashCode;
}
