import 'dart:convert';

import 'package:ljm/provider/connection.dart';
import 'package:ljm/tools/env.dart';

class BARANGJENIS {
  int? id;
  String? jenis;
  String? gambar;
  String? deskripsi;
  int? aktif;
  String? updated;

  BARANGJENIS({
    this.id,
    this.jenis,
    this.gambar,
    this.deskripsi,
    this.aktif,
    this.updated,
  });

  @override
  String toString() {
    return 'BARANGJENIS(id: $id, jenis: $jenis, gambar: $gambar, deskripsi: $deskripsi, aktif: $aktif, updated: $updated)';
  }

  factory BARANGJENIS.fromMap(Map<String, dynamic> data) => BARANGJENIS(
        id: makeInt(data['id']),
        jenis: makeStr(data['jenis']),
        gambar: makeStr(data['gambar']),
        deskripsi: makeStr(data['deskripsi']),
        aktif: makeInt(data['aktif']),
        updated: makeStr(data['updated']),
      );

  Map<String, String?> toMap() => {
        'id': id.toString(),
        'jenis': jenis,
        'gambar': gambar,
        'deskripsi': deskripsi,
        'aktif': aktif.toString(),
        'updated': updated,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BARANGJENIS].
  factory BARANGJENIS.fromJson(String data) {
    return BARANGJENIS.fromMap(json.decode(data) as Map<String, String?>);
  }

  /// `dart:convert`
  ///
  /// Converts [BARANGJENIS] to a JSON string.
  String toJson() => json.encode(toMap());

  BARANGJENIS copyWith({
    int? id,
    String? jenis,
    String? gambar,
    String? deskripsi,
    int? aktif,
    String? updated,
  }) {
    return BARANGJENIS(
      id: id ?? this.id,
      jenis: jenis ?? this.jenis,
      gambar: gambar ?? this.gambar,
      deskripsi: deskripsi ?? this.deskripsi,
      aktif: aktif ?? this.aktif,
      updated: updated ?? this.updated,
    );
  }

  Future<BARANGJENIS?> simpan() async {
    var res = await updateData(toJson(), '/barang/jenis/update');
    if (res != null) {
      return BARANGJENIS.fromMap(res.first);
    }
    return null;
  }
}
