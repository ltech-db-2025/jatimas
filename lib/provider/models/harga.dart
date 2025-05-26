import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';


class HARGA  {
  int? id;
  String? kode;
  String? nama;
  double? hargadiskon;
  String? diskon;
  int? publik;
  String? updated;

  HARGA({this.id, this.kode, this.nama, this.hargadiskon, this.diskon, this.publik, this.updated});

  @override
  String toString() {
    return 'HARGA(id: $id, kode: $kode, nama: $nama, hargadiskon: $hargadiskon, diskon: $diskon, publik: $publik, updated: $updated)';
  }

  factory HARGA.fromMap(Map<String, dynamic> data) => HARGA(
        id: makeInt(data['id']),
        kode: makeStr(data['kode']),
        nama: makeStr(data['nama']),
        hargadiskon: makeDouble(data['hargadiskon']),
        diskon: makeStr(data['diskon']),
        publik: makeInt(data['publik']),
        updated: makeStr(data['updated']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'kode': kode,
        'nama': nama,
        'hargadiskon': hargadiskon,
        'diskon': diskon,
        'publik': publik,
        'updated': updated,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HARGA].
  factory HARGA.fromJson(String data) {
    return HARGA.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HARGA] to a JSON string.
  String toJson() => json.encode(toMap());

  HARGA copyWith({
    int? id,
    String? kode,
    String? nama,
    double? hargadiskon,
    String? diskon,
    int? publik,
    String? updated,
  }) {
    return HARGA(
      id: id ?? this.id,
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
      hargadiskon: hargadiskon ?? this.hargadiskon,
      diskon: diskon ?? this.diskon,
      publik: publik ?? this.publik,
      updated: updated ?? this.updated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! HARGA) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ kode.hashCode ^ nama.hashCode ^ hargadiskon.hashCode ^ diskon.hashCode ^ publik.hashCode ^ updated.hashCode;
}
