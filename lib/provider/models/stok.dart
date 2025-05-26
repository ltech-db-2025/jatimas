import 'dart:convert';

import 'package:ljm/tools/env.dart';

class STOK {
  int? idbarang;
  int? idlokasi;
  String? kode;
  String? lokasi;
  double? stok;

  STOK({this.idbarang, this.idlokasi, this.kode, this.lokasi, this.stok});

  @override
  String toString() => "STOK(idbarang: $idbarang, idlokasi: $idlokasi, kode: $kode, lokasi: $lokasi, stok: $stok)";
  factory STOK.fromMap(Map<String, dynamic> map) => STOK(
        idbarang: makeInt(map['idbarang']),
        idlokasi: makeInt(map['idlokasi']),
        kode: makeStr(map['kode']),
        lokasi: makeStr(map['lokasi']),
        stok: makeDouble(map['stok']),
      );
  Map<String, dynamic> toMap() => {
        'idbarang': idbarang,
        'idlokasi': idlokasi,
        'kode': kode,
        'lokasi': lokasi,
        'stok': stok,
      };
  factory STOK.fromJson(String data) {
    return STOK.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
  STOK copyWith({
    int? idbarang,
    int? idlokasi,
    String? kode,
    String? lokasi,
    double? stok,
  }) =>
      STOK(
        idbarang: idbarang ?? this.idbarang,
        idlokasi: idlokasi ?? this.idlokasi,
        kode: kode ?? this.kode,
        lokasi: lokasi ?? this.lokasi,
        stok: stok ?? this.stok,
      );
}
