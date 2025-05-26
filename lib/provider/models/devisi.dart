import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

class DEVISI {
  int? id;
  String? nama;
  String? uraian;
  String? bidang;
  String? alamat;
  int? aktif;

  DEVISI({
    this.id,
    this.nama,
    this.uraian,
    this.bidang,
    this.alamat,
    this.aktif,
  });

  @override
  String toString() {
    return 'DEVISI(id: $id, nama: $nama, uraian: $uraian, bidang: $bidang, alamat: $alamat, aktif: $aktif)';
  }

  factory DEVISI.fromMap(Map<String, dynamic> data) => DEVISI(
        id: makeInt(data['id']),
        nama: makeStr(data['nama']),
        uraian: makeStr(data['uraian']),
        bidang: makeStr(data['bidang']),
        alamat: makeStr(data['alamat']),
        aktif: makeInt(data['aktif']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama': nama,
        'uraian': uraian,
        'bidang': bidang,
        'alamat': alamat,
        'aktif': aktif,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DEVISI].
  factory DEVISI.fromJson(String data) {
    return DEVISI.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DEVISI] to a JSON string.
  String toJson() => json.encode(toMap());

  DEVISI copyWith({
    int? id,
    String? nama,
    String? uraian,
    String? bidang,
    String? alamat,
    int? aktif,
  }) {
    return DEVISI(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      uraian: uraian ?? this.uraian,
      bidang: bidang ?? this.bidang,
      alamat: alamat ?? this.alamat,
      aktif: aktif ?? this.aktif,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DEVISI) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ nama.hashCode ^ uraian.hashCode ^ bidang.hashCode ^ alamat.hashCode ^ aktif.hashCode;
}
