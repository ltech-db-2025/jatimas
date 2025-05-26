import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

class KAS {
  int? id;
  String? tanggal;
  int? idtrans;
  int? refidtrans;
  String? refnotrans;
  double? rek;
  String? akuntansi;
  String? referensi;
  String? uraian;
  double? nilai;
  double? debit;
  double? kredit;

  KAS({this.id, this.tanggal, this.idtrans, this.refidtrans, this.refnotrans, this.rek, this.akuntansi, this.referensi, this.uraian, this.nilai, this.debit, this.kredit});
  @override
  String toString() {
    return 'KAS( id: $id, tanggal: $tanggal, idtrans: $idtrans, refidtrans: $refidtrans, refnotrans: $refnotrans, rek: $rek, akuntansi: $akuntansi, referensi: $referensi, uraian: $uraian, nilai: $nilai, debit: $debit, kredit: $kredit ) ';
  }

  factory KAS.fromMap(Map<String, dynamic> data) => KAS(id: makeInt(data['id']), tanggal: makeStr(data['tanggal']), idtrans: makeInt(data['idtrans']), refidtrans: makeInt(data['refidtrans']), refnotrans: makeStr(data['refnotrans']), rek: makeDouble(data['rek']), akuntansi: data['akuntansi'] ?? '', referensi: data['referensi'] ?? '', uraian: data['uraian'] ?? '', nilai: makeDouble(data['nilai']), debit: makeDouble(data['debit']), kredit: makeDouble(data['kredit']));

  factory KAS.fromJson(String data) {
    return KAS.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  Map<String, dynamic> toMap() => {'id': id, 'tanggal': tanggal, 'idtrans': idtrans, 'refidtrans': refidtrans, 'refnotrans': refnotrans, 'rek': rek, 'akuntansi': akuntansi, 'referensi': referensi, 'uraian': uraian, 'nilai': nilai, 'debit': debit, 'kredit': kredit};
  String toJson() => json.encode(toMap());
  Map<String, dynamic> toPost() => {
        "id": id.toString(),
        "tanggal": tanggal.toString(),
        "refidtrans": refidtrans.toString(),
        "idtrans": idtrans.toString(),
        "rek": rek.toString(),
        "referensi": referensi.toString(),
        "uraian": uraian.toString(),
        "nilai": nilai.toString(),
      };
  KAS copyWith({
    int? id,
    String? tanggal,
    int? idtrans,
    int? refidtrans,
    String? refnotrans,
    double? rek,
    String? akuntansi,
    String? referensi,
    String? uraian,
    double? nilai,
    double? debit,
    double? kredit,
  }) {
    return KAS(
      id: id ?? this.id,
      tanggal: tanggal ?? this.tanggal,
      idtrans: idtrans ?? this.idtrans,
      refidtrans: refidtrans ?? this.refidtrans,
      refnotrans: refnotrans ?? this.refnotrans,
      rek: rek ?? this.rek,
      akuntansi: akuntansi ?? this.akuntansi,
      referensi: referensi ?? this.referensi,
      uraian: uraian ?? this.uraian,
      nilai: nilai ?? this.nilai,
      debit: debit ?? this.debit,
      kredit: kredit ?? this.kredit,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! KAS) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => toMap().hashCode;
}
