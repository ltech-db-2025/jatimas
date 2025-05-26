import 'dart:convert';

import 'package:collection/collection.dart';

import '../devisi.dart';
import '../kontak.dart';
import '../lokasi.dart';
import 'aplikasi.dart';

class INETAPP {
  String? email;
  int? idapp;
  int? idkontak;
  int? idtipe;
  int? semualokasi;
  int? semuadevisi;
  int? deflokasi;
  int? defdevisi;
  int? aktif;
  APLIKASI? aplikasi;
  KONTAK? kontak;
  List<DEVISI>? devisi;
  List<LOKASI>? lokasi;

  INETAPP({
    this.email,
    this.idapp,
    this.idkontak,
    this.idtipe,
    this.semualokasi,
    this.semuadevisi,
    this.deflokasi,
    this.defdevisi,
    this.aktif,
    this.aplikasi,
    this.kontak,
    this.devisi,
    this.lokasi,
  });

  @override
  String toString() {
    return 'INETAPP(email: $email, idapp: $idapp, idkontak: $idkontak, idtipe: $idtipe, semualokasi: $semualokasi, semuadevisi: $semuadevisi, deflokasi: $deflokasi, defdevisi: $defdevisi, aktif: $aktif, aplikasi: $aplikasi, kontak: $kontak, devisi: $devisi, lokasi: $lokasi)';
  }

  factory INETAPP.fromMap(Map<String, dynamic> data) => INETAPP(
        email: data['email'] as String?,
        idapp: data['idapp'] as int?,
        idkontak: data['idkontak'] as int?,
        idtipe: data['idtipe'] as int?,
        semualokasi: data['semualokasi'] as int?,
        semuadevisi: data['semuadevisi'] as int?,
        deflokasi: data['deflokasi'] as int?,
        defdevisi: data['defdevisi'] as int?,
        aktif: data['aktif'] as int?,
        aplikasi: data['APLIKASI'] == null
            ? null
            : APLIKASI.fromMap(data['APLIKASI'] as Map<String, dynamic>),
        kontak: data['KONTAK'] == null
            ? null
            : KONTAK.fromMap(data['KONTAK'] as Map<String, dynamic>),
        devisi: (data['DEVISI'] as List<dynamic>?)
            ?.map((e) => DEVISI.fromMap(e as Map<String, dynamic>))
            .toList(),
        lokasi: (data['LOKASI'] as List<dynamic>?)
            ?.map((e) => LOKASI.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'idapp': idapp,
        'idkontak': idkontak,
        'idtipe': idtipe,
        'semualokasi': semualokasi,
        'semuadevisi': semuadevisi,
        'deflokasi': deflokasi,
        'defdevisi': defdevisi,
        'aktif': aktif,
        'APLIKASI': aplikasi?.toMap(),
        'DEVISI': devisi?.map((e) => e.toMap()).toList(),
        'LOKASI': lokasi?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [INETAPP].
  factory INETAPP.fromJson(String data) {
    return INETAPP.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [INETAPP] to a JSON string.
  String toJson() => json.encode(toMap());

  INETAPP copyWith({
    String? email,
    int? idapp,
    int? idkontak,
    int? idtipe,
    int? semualokasi,
    int? semuadevisi,
    int? deflokasi,
    int? defdevisi,
    int? aktif,
    APLIKASI? aplikasi,
    List<DEVISI>? devisi,
    List<LOKASI>? lokasi,
  }) {
    return INETAPP(
      email: email ?? this.email,
      idapp: idapp ?? this.idapp,
      idkontak: idkontak ?? this.idkontak,
      idtipe: idtipe ?? this.idtipe,
      semualokasi: semualokasi ?? this.semualokasi,
      semuadevisi: semuadevisi ?? this.semuadevisi,
      deflokasi: deflokasi ?? this.deflokasi,
      defdevisi: defdevisi ?? this.defdevisi,
      aktif: aktif ?? this.aktif,
      aplikasi: aplikasi ?? this.aplikasi,
      devisi: devisi ?? this.devisi,
      lokasi: lokasi ?? this.lokasi,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! INETAPP) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      email.hashCode ^
      idapp.hashCode ^
      idkontak.hashCode ^
      idtipe.hashCode ^
      semualokasi.hashCode ^
      semuadevisi.hashCode ^
      deflokasi.hashCode ^
      defdevisi.hashCode ^
      aktif.hashCode ^
      aplikasi.hashCode ^
      devisi.hashCode ^
      lokasi.hashCode;
}
