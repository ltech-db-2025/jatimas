import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

class AksesLokasi {
  String? email;
  int? idlokasi;
  String? kode;
  String? nama;

  AksesLokasi({this.email, this.idlokasi, this.kode, this.nama});

  @override
  String toString() {
    return 'AksesLokasi(email: $email, idlokasi: $idlokasi, kode: $kode, nama: $nama)';
  }

  factory AksesLokasi.fromMap(Map<String, dynamic> data) => AksesLokasi(
        email: makeStr(data['email']),
        idlokasi: makeInt(data['idlokasi']),
        kode: makeStr(data['kode']),
        nama: makeStr(data['nama']),
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'idlokasi': idlokasi,
        'kode': kode,
        'nama': nama,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AksesLokasi].
  factory AksesLokasi.fromJson(String data) {
    return AksesLokasi.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AksesLokasi] to a JSON string.
  String toJson() => json.encode(toMap());

  AksesLokasi copyWith({
    String? email,
    int? idlokasi,
    String? kode,
    String? nama,
  }) {
    return AksesLokasi(
      email: email ?? this.email,
      idlokasi: idlokasi ?? this.idlokasi,
      kode: kode ?? this.kode,
      nama: nama ?? this.nama,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AksesLokasi) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => email.hashCode ^ idlokasi.hashCode ^ kode.hashCode ^ nama.hashCode;
}
