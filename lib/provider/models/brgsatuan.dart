import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

class BrgSatuan {
  int? id;
  int? idsatuan;
  double? isi;
  double? beli;
  double? jual;
  double? jual1;
  double? jual2;
  double? jual3;
  double? jual4;
  double? jual5;
  String? markupbeli;
  String? markup1;
  String? markup2;
  String? markup3;
  String? markup4;
  String? markup5;
  String? poin;
  int? aktif;
  String? barcode;
  String? updated;
  String? satuan;

  BrgSatuan({
    this.id,
    this.idsatuan,
    this.isi,
    this.beli,
    this.jual,
    this.jual1,
    this.jual2,
    this.jual3,
    this.jual4,
    this.jual5,
    this.markupbeli,
    this.markup1,
    this.markup2,
    this.markup3,
    this.markup4,
    this.markup5,
    this.poin,
    this.aktif,
    this.barcode,
    this.updated,
    this.satuan,
  });

  @override
  String toString() {
    return 'BrgSatuan(id: $id, idsatuan: $idsatuan, isi: $isi, beli: $beli, jual: $jual, jual1: $jual1, jual2: $jual2, jual3: $jual3, jual4: $jual4, jual5: $jual5, markupbeli: $markupbeli, markup1: $markup1, markup2: $markup2, markup3: $markup3, markup4: $markup4, markup5: $markup5, poin: $poin, aktif: $aktif, barcode: $barcode, updated: $updated, satuan: $satuan)';
  }

  factory BrgSatuan.fromMap(Map<String, dynamic> data) => BrgSatuan(
        id: makeInt(data['id']),
        idsatuan: makeInt(data['idsatuan']),
        isi: makeDouble(data['isi']),
        beli: makeDouble(data['beli']),
        jual: makeDouble(data['jual']),
        jual1: makeDouble(data['jual1']),
        jual2: makeDouble(data['jual2']),
        jual3: makeDouble(data['jual3']),
        jual4: makeDouble(data['jual4']),
        jual5: makeDouble(data['jual5']),
        markupbeli: makeStr(data['markupbeli']),
        markup1: makeStr(data['markup1']),
        markup2: makeStr(data['markup2']),
        markup3: makeStr(data['markup3']),
        markup4: makeStr(data['markup4']),
        markup5: makeStr(data['markup5']),
        poin: makeStr(data['poin']),
        aktif: makeInt(data['aktif']),
        barcode: makeStr(data['barcode']),
        updated: makeStr(data['updated']),
        satuan: makeStr(data['satuan']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'idsatuan': idsatuan,
        'isi': isi,
        'beli': beli,
        'jual': jual,
        'jual1': jual1,
        'jual2': jual2,
        'jual3': jual3,
        'jual4': jual4,
        'jual5': jual5,
        'markupbeli': markupbeli,
        'markup1': markup1,
        'markup2': markup2,
        'markup3': markup3,
        'markup4': markup4,
        'markup5': markup5,
        'poin': poin,
        'aktif': aktif,
        'barcode': barcode,
        'updated': updated,
        'satuan': satuan,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BrgSatuan].
  factory BrgSatuan.fromJson(String data) {
    return BrgSatuan.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BrgSatuan] to a JSON string.
  String toJson() => json.encode(toMap());

  BrgSatuan copyWith({
    int? id,
    int? idsatuan,
    double? isi,
    double? beli,
    double? jual,
    double? jual1,
    double? jual2,
    double? jual3,
    double? jual4,
    double? jual5,
    String? markupbeli,
    String? markup1,
    String? markup2,
    String? markup3,
    String? markup4,
    String? markup5,
    String? poin,
    int? aktif,
    String? barcode,
    String? updated,
    String? satuan,
  }) {
    return BrgSatuan(
      id: id ?? this.id,
      idsatuan: idsatuan ?? this.idsatuan,
      isi: isi ?? this.isi,
      beli: beli ?? this.beli,
      jual: jual ?? this.jual,
      jual1: jual1 ?? this.jual1,
      jual2: jual2 ?? this.jual2,
      jual3: jual3 ?? this.jual3,
      jual4: jual4 ?? this.jual4,
      jual5: jual5 ?? this.jual5,
      markupbeli: markupbeli ?? this.markupbeli,
      markup1: markup1 ?? this.markup1,
      markup2: markup2 ?? this.markup2,
      markup3: markup3 ?? this.markup3,
      markup4: markup4 ?? this.markup4,
      markup5: markup5 ?? this.markup5,
      poin: poin ?? this.poin,
      aktif: aktif ?? this.aktif,
      barcode: barcode ?? this.barcode,
      updated: updated ?? this.updated,
      satuan: satuan ?? this.satuan,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BrgSatuan) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      idsatuan.hashCode ^
      isi.hashCode ^
      beli.hashCode ^
      jual.hashCode ^
      jual1.hashCode ^
      jual2.hashCode ^
      jual3.hashCode ^
      jual4.hashCode ^
      jual5.hashCode ^
      markupbeli.hashCode ^
      markup1.hashCode ^
      markup2.hashCode ^
      markup3.hashCode ^
      markup4.hashCode ^
      markup5.hashCode ^
      poin.hashCode ^
      aktif.hashCode ^
      barcode.hashCode ^
      updated.hashCode ^
      satuan.hashCode;
}
