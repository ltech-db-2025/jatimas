import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/tools/env.dart';

String _urlGambar = "";

class BARANGKATEGORI {
  int? id;
  String? kategori;
  String? gambar;
  String? updated;
  String? deskripsi;
  String? fileGambar;
  String? fileThumb;
  int? aktif;

  BARANGKATEGORI({
    this.id,
    this.kategori,
    this.gambar,
    this.updated,
    this.deskripsi,
    this.fileGambar,
    this.fileThumb,
    this.aktif,
  });

  @override
  String toString() {
    return 'BARANGKATEGORI (id: $id, kategori: $kategori, gambar: $gambar, fileGambar: $fileGambar, fileThumb: $fileThumb, updated: $updated, deskripsi: $deskripsi, aktif: $aktif)';
  }

  factory BARANGKATEGORI.fromMap(Map<String, dynamic> data) => BARANGKATEGORI(
        id: makeInt(data['id']),
        kategori: makeStr(data['kategori']),
        gambar: makeStr(data['gambar']),
        updated: makeStr(data['updated']),
        deskripsi: makeStr(data['deskripsi']),
        fileGambar: (data['gambar'] == null || data['gambar'] == "null") ? null : "$homepageimg$_urlGambar${data['gambar']}",
        fileThumb: (data['gambar'] == null || data['gambar'] == "null") ? null : "$homepageimg$_urlGambar${imagetoThumbs(data['gambar'])}",
        aktif: makeInt(data['aktif']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'kategori': kategori,
        'gambar': gambar,
        'updated': updated,
        'deskripsi': deskripsi,
        'fileGambar': fileGambar,
        'fileThumb': fileThumb,
        'aktif': aktif,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BARANGKATEGORI ].
  factory BARANGKATEGORI.fromJson(String data) {
    return BARANGKATEGORI.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BARANGKATEGORI ] to a JSON string.
  String toJson() => json.encode(toMap());

  BARANGKATEGORI copyWith({
    int? id,
    String? kategori,
    String? gambar,
    String? updated,
    String? deskripsi,
    String? fileGambar,
    String? fileThumb,
    int? aktif,
  }) {
    return BARANGKATEGORI(
      id: id ?? this.id,
      kategori: kategori ?? this.kategori,
      gambar: gambar ?? this.gambar,
      updated: updated ?? this.updated,
      deskripsi: deskripsi ?? this.deskripsi,
      fileGambar: fileGambar ?? this.fileGambar,
      fileThumb: fileThumb ?? this.fileThumb,
      aktif: aktif ?? this.aktif,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BARANGKATEGORI) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ kategori.hashCode ^ gambar.hashCode ^ updated.hashCode ^ deskripsi.hashCode ^ aktif.hashCode;

  Future<BARANGKATEGORI?> simpan() async {
    var res = await updateData(toJson(), '/barang/kategori/update');
    if (res != null) {
      return BARANGKATEGORI.fromMap(res.first);
    }
    return null;
  }
}
