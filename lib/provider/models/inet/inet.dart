import 'dart:convert';

import 'package:collection/collection.dart';

import '../kontak.dart';
import '../lokasi.dart';
import 'inetapp.dart';

class INET {
  String? email;
  int? idkontak;
  KONTAK? aktifKontak;
  int? idlokasi;
  LOKASI? aktifLokasi;
  int? tipe;
  String? nama;
  String? imageurl;
  int? superuser;
  String? operator;

  List<INETAPP>? inetapp;
  INETAPP? aktifApp;

  INET({
    this.email,
    this.idkontak,
    this.aktifKontak,
    this.idlokasi,
    this.aktifLokasi,
    this.tipe,
    this.nama,
    this.imageurl,
    this.superuser,
    this.operator,
    this.inetapp,
    this.aktifApp,
  });

  @override
  String toString() {
    return 'INET(email: $email, idkontak: $idkontak, idlokasi: $idlokasi, tipe: $tipe, nama: $nama, imageurl: $imageurl, superuser: $superuser, operator: $operator, inetapp: $inetapp)';
  }

  factory INET.fromMap(Map<String, dynamic> data) => INET(
        email: data['email'] as String?,
        idkontak: data['idkontak'] as int?,
        idlokasi: data['idlokasi'] as int?,
        tipe: data['tipe'] as int?,
        nama: data['nama'] as String?,
        imageurl: data['imageurl'] as String?,
        superuser: data['superuser'] as int?,
        operator: data['operator'] as String?,
        inetapp: (data['INETAPP'] as List<dynamic>?)
            ?.map((e) => INETAPP.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'idkontak': idkontak,
        'idlokasi': idlokasi,
        'tipe': tipe,
        'nama': nama,
        'imageurl': imageurl,
        'superuser': superuser,
        'operator': operator,
        'INETAPP': inetapp?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [INET].
  factory INET.fromJson(String data) {
    return INET.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [INET] to a JSON string.
  String toJson() => json.encode(toMap());

  INET copyWith({
    String? email,
    int? idkontak,
    int? idlokasi,
    int? tipe,
    String? nama,
    String? imageurl,
    int? superuser,
    String? operator,
    List<INETAPP>? inetapp,
  }) {
    return INET(
      email: email ?? this.email,
      idkontak: idkontak ?? this.idkontak,
      idlokasi: idlokasi ?? this.idlokasi,
      tipe: tipe ?? this.tipe,
      nama: nama ?? this.nama,
      imageurl: imageurl ?? this.imageurl,
      superuser: superuser ?? this.superuser,
      operator: operator ?? this.operator,
      inetapp: inetapp ?? this.inetapp,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! INET) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      email.hashCode ^
      idkontak.hashCode ^
      idlokasi.hashCode ^
      tipe.hashCode ^
      nama.hashCode ^
      imageurl.hashCode ^
      superuser.hashCode ^
      operator.hashCode ^
      inetapp.hashCode;
}
