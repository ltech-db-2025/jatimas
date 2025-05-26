import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/provider/models/brgsatuan.dart';
import 'package:ljm/tools/env.dart';

import 'stok.dart';
import 'peletakan.dart';

String _urlGambar = "";
const satuankosong = <BrgSatuan>[];
const stokkosong = <STOK>[];

class BARANG {
  String? kode;
  String? barcode;
  int? id;
  String nama;
  int? idkategori;
  String? kategori;
  int? idkelompok;
  String? kelompok;
  int? idjenis;
  String? jenis;
  int? idmerk;
  String merk;
  String satuan;
  double? beli;
  double? jual;
  double? jual1;
  double? jual2;
  double? jual3;
  double? jual4;
  double? jual5;
  double? stok;
  double? stokgd;
  double? stoknr;
  String? poin;
  double? pembagi;
  double? kg;
  double? kd;
  String? gambar;
  String? markup1;
  String? markup2;
  String? markup3;
  String? markup4;
  String? markup5;
  String? markupbeli;
  int? stokminimal;
  double? minimal;
  String? hdasar;
  bool aktif;
  String? supplier;
  double? qtydos;
  double? minorder;
  double? bobot;
  double? grade;
  String? rak;
  String? namaList;
  String? deskripsi;
  int? idgol;
  String? golongan;
  int? idsatuan;
  double? isi;
  int? nostok;
  double? harga;
  String? created;
  String? updated;
  String? fileGambar;
  String? fileThumb;
  int? iddevisi;
  String? devisi;
  List<STOK> liststok;
  List<PELETAKAN>? listpeletakan;
  List<BrgSatuan> listsatuan;
  double stoklokasi;

  BARANG({
    this.kode,
    this.barcode,
    this.id,
    this.nama = "",
    this.idkategori,
    this.kategori,
    this.idkelompok,
    this.kelompok,
    this.idjenis,
    this.jenis,
    this.idmerk,
    this.merk = '',
    this.satuan = '',
    this.beli,
    this.jual,
    this.jual1,
    this.jual2,
    this.jual3,
    this.jual4,
    this.jual5,
    this.stok,
    this.stokgd,
    this.stoknr,
    this.poin,
    this.pembagi,
    this.kg,
    this.kd,
    this.gambar,
    this.markup1,
    this.markup2,
    this.markup3,
    this.markup4,
    this.markup5,
    this.markupbeli,
    this.stokminimal,
    this.minimal,
    this.hdasar,
    this.aktif = false,
    this.supplier,
    this.qtydos,
    this.minorder,
    this.bobot,
    this.grade,
    this.rak,
    this.namaList,
    this.deskripsi,
    this.idgol,
    this.golongan,
    this.idsatuan,
    this.isi,
    this.nostok,
    this.harga,
    this.created,
    this.updated,
    this.fileGambar,
    this.fileThumb,
    this.iddevisi,
    this.devisi,
    this.liststok = stokkosong,
    this.listpeletakan,
    this.listsatuan = satuankosong,
    this.stoklokasi = 0,
  });

  @override
  String toString() {
    return 'BARANG(kode: $kode, barcode: $barcode, id: $id, nama: $nama, idkategori: $idkategori, kategori: $kategori, idkelompok: $idkelompok, kelompok: $kelompok, idjenis: $idjenis, jenis: $jenis, idmerk: $idmerk, merk: $merk, satuan: $satuan, beli: $beli, jual: $jual, jual1: $jual1, jual2: $jual2, jual3: $jual3, jual4: $jual4, jual5: $jual5, stok: $stok, stokgd: $stokgd, stoknr: $stoknr, stoklokasi: $stoklokasi,poin: $poin, pembagi: $pembagi, kg: $kg, kd: $kd, gambar: $gambar, markup1: $markup1, markup2: $markup2, markup3: $markup3, markup4: $markup4, markup5: $markup5, markupbeli: $markupbeli, stokminimal: $stokminimal, minimal: $minimal, hdasar: $hdasar, aktif: $aktif, supplier: $supplier, qtydos: $qtydos, minorder: $minorder, bobot: $bobot, grade: $grade, rak: $rak, namaList: $namaList, deskripsi: $deskripsi, idgol: $idgol, golongan: $golongan, idsatuan: $idsatuan, isi: $isi, nostok: $nostok, harga: $harga, created: $created, updated: $updated, fileGambar: $fileGambar, fileThumb: $fileThumb, iddevisi: $iddevisi, devisi: $devisi,  liststok: $liststok, listpeletakan: $listpeletakan, listsatuan: $listsatuan  )';
  }

  factory BARANG.fromMap(Map<String, dynamic> json) => BARANG(
        kode: makeStr(json['kode']),
        barcode: makeStr(json['barcode']),
        id: makeInt(json['id']),
        nama: makeStr(json['nama']),
        idkategori: makeInt(json['idkategori']),
        kategori: makeStr(json['kategori']),
        idkelompok: makeInt(json['idkelompok']),
        kelompok: makeStr(json['kelompok']),
        idjenis: makeInt(json['idjenis']),
        golongan: makeStr(json['golongan']),
        jenis: makeStr(json['jenis']),
        idmerk: makeInt(json['idmerk']),
        merk: makeStr(json['merk']),
        satuan: makeStr(json['satuan']),
        harga: makeDouble(json['harga'].toString()),
        beli: makeDouble(json['beli'].toString()),
        jual: makeDouble(json['jual'].toString()),
        jual1: makeDouble(json['jual1'].toString()),
        jual2: makeDouble(json['jual2'].toString()),
        jual3: makeDouble(json['jual3'].toString()),
        jual4: makeDouble(json['jual4'].toString()),
        jual5: makeDouble(json['jual5'].toString()),
        stok: makeDouble(json['stok'].toString()),
        stokgd: makeDouble(json['stokgd'].toString()),
        stoknr: makeDouble(json['stoknr'].toString()),
        stoklokasi: makeDouble(json['stoklokasi'].toString()) ?? 0,
        poin: makeStr(json['poin']),
        pembagi: makeDouble(json['pembagi'].toString()),
        kg: makeDouble(json['kg'].toString()),
        kd: makeStr(json['kd']),
        gambar: makeStr(json['gambar']),
        markup1: makeStr(json['markup1']),
        markup2: makeStr(json['markup2']),
        markup3: makeStr(json['markup3']),
        markup4: makeStr(json['markup4']),
        markup5: makeStr(json['markup5']),
        markupbeli: makeStr(json['markupbeli']),
        stokminimal: makeInt(json['stokminimal'].toString()),
        minimal: makeDouble(json['minimal'].toString()),
        hdasar: makeStr(json['hdasar']),
        aktif: makeBool(json['aktif']) ?? false,
        supplier: makeStr(json['supplier']),
        qtydos: makeDouble(json['qtydos'].toString()),
        minorder: makeDouble(json['minorder'].toString()),
        bobot: makeDouble(json['bobot'].toString()),
        grade: makeDouble(json['grade'].toString()),
        rak: makeStr(json['rak']),
        namaList: makeStr(json['nama_list']),
        deskripsi: makeStr(json['deskripsi']),
        idgol: makeInt(json['idgol']),
        idsatuan: makeInt(json['idsatuan']),
        isi: makeDouble(json['isi'].toString()),
        iddevisi: makeInt(json['iddevisi']),
        devisi: makeStr(json['devisi']),
        nostok: makeInt(json['nostok']),
        liststok: (json['liststok'] == null) ? [] : (jsonDecode(json['liststok']) as List<dynamic>?)?.map((e) => STOK.fromMap(e as Map<String, dynamic>)).toList() ?? [],
        listpeletakan: json['listpeletakan'],

        // detail: (data['detail'] == null) ? null : (jsonDecode(data['detail']) as List<dynamic>?)?.map((e) => DETAIL.fromMap(e as Map<String, dynamic>)).toList(),
        listsatuan: (json['listsatuan'] == null) ? [] : (jsonDecode(json['listsatuan']) as List<dynamic>?)?.map((e) => BrgSatuan.fromMap(e as Map<String, dynamic>)).toList() ?? [],
        created: makeStr(json['created']),
        updated: makeStr(json['updated']),
        // fileGambar: (json['gambar'] == null || json['gambar'] == "null") ? null : "https://dbbeoj6wy8nwe.cloudfront.net/$_urlGambar${json['gambar']}",
        fileGambar: (json['gambar'] == null || json['gambar'] == "null") ? null : "$homepageimg$_urlGambar${json['gambar']}",
        fileThumb: (json['gambar'] == null || json['gambar'] == "null") ? null : "$homepageimg$_urlGambar${imagetoThumbs(json['gambar'])}",
      );

  Map<String, dynamic> toMap() => {
        'kode': kode,
        'barcode': barcode,
        'id': id,
        'nama': nama,
        'idkategori': idkategori,
        'kategori': kategori,
        'idkelompok': idkelompok,
        'kelompok': kelompok,
        'idjenis': idjenis,
        'jenis': jenis,
        'idmerk': idmerk,
        'merk': merk,
        'satuan': satuan,
        'beli': beli,
        'jual': jual,
        'jual1': jual1,
        'jual2': jual2,
        'jual3': jual3,
        'jual4': jual4,
        'jual5': jual5,
        'stok': stok,
        'stokgd': stokgd,
        'stoknr': stoknr,
        'stoklokasi': stoklokasi,
        'poin': poin,
        'pembagi': pembagi,
        'kg': kg,
        'kd': kd,
        'gambar': gambar,
        'markup1': markup1,
        'markup2': markup2,
        'markup3': markup3,
        'markup4': markup4,
        'markup5': markup5,
        'markupbeli': markupbeli,
        'stokminimal': stokminimal,
        'minimal': minimal,
        'hdasar': hdasar,
        'aktif': aktif,
        'supplier': supplier,
        'qtydos': qtydos,
        'minorder': minorder,
        'bobot': bobot,
        'grade': grade,
        'rak': rak,
        'nama_list': namaList,
        'deskripsi': deskripsi,
        'idgol': idgol,
        'golongan': golongan,
        'idsatuan': idsatuan,
        'isi': isi,
        'nostok': nostok,
        'harga': harga,
        'iddevisi': iddevisi,
        'devisi': devisi,
        'liststok': liststok,
        'listpeletakan': listpeletakan,
        'created': created,
        'updated': updated,
        'fileGambar': fileGambar,
        'fileThumb': fileThumb,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BARANG].
  factory BARANG.fromJson(String data) {
    return BARANG.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BARANG] to a JSON string.
  String toJson() => json.encode(toMap());

  BARANG copyWith({
    String? kode,
    String? barcode,
    int? id,
    String? nama,
    int? idkategori,
    String? kategori,
    int? idkelompok,
    String? kelompok,
    int? idjenis,
    String? jenis,
    int? idmerk,
    String? merk,
    String? satuan,
    double? beli,
    double? jual,
    double? jual1,
    double? jual2,
    double? jual3,
    double? jual4,
    double? jual5,
    double? stok,
    double? stokgd,
    double? stoknr,
    double? stoklokasi,
    String? poin,
    double? pembagi,
    double? kg,
    double? kd,
    String? gambar,
    String? markup1,
    String? markup2,
    String? markup3,
    String? markup4,
    String? markup5,
    String? markupbeli,
    int? stokminimal,
    double? minimal,
    String? hdasar,
    bool? aktif,
    String? supplier,
    double? qtydos,
    double? minorder,
    double? bobot,
    double? grade,
    String? rak,
    String? namaList,
    String? deskripsi,
    int? idgol,
    String? golongan,
    int? idsatuan,
    double? isi,
    int? nostok,
    double? harga,
    String? created,
    String? updated,
    String? fileGambar,
    String? fileThumb,
    int? iddevisi,
    String? devisi,
    List<STOK>? liststok,
    List<PELETAKAN>? listpeletakan,
    List<BrgSatuan>? listsatuan,
  }) {
    return BARANG(
      kode: kode ?? this.kode,
      barcode: barcode ?? this.barcode,
      id: id ?? this.id,
      nama: nama ?? this.nama,
      idkategori: idkategori ?? this.idkategori,
      kategori: kategori ?? this.kategori,
      idkelompok: idkelompok ?? this.idkelompok,
      kelompok: kelompok ?? this.kelompok,
      idjenis: idjenis ?? this.idjenis,
      jenis: jenis ?? this.jenis,
      idmerk: idmerk ?? this.idmerk,
      merk: merk ?? this.merk,
      satuan: satuan ?? this.satuan,
      beli: beli ?? this.beli,
      jual: jual ?? this.jual,
      jual1: jual1 ?? this.jual1,
      jual2: jual2 ?? this.jual2,
      jual3: jual3 ?? this.jual3,
      jual4: jual4 ?? this.jual4,
      jual5: jual5 ?? this.jual5,
      stok: stok ?? this.stok,
      stokgd: stokgd ?? this.stokgd,
      stoknr: stoknr ?? this.stoknr,
      stoklokasi: stoklokasi ?? this.stoklokasi,
      poin: poin ?? this.poin,
      pembagi: pembagi ?? this.pembagi,
      kg: kg ?? this.kg,
      kd: kd ?? this.kd,
      gambar: gambar ?? this.gambar,
      markup1: markup1 ?? this.markup1,
      markup2: markup2 ?? this.markup2,
      markup3: markup3 ?? this.markup3,
      markup4: markup4 ?? this.markup4,
      markup5: markup5 ?? this.markup5,
      markupbeli: markupbeli ?? this.markupbeli,
      stokminimal: stokminimal ?? this.stokminimal,
      minimal: minimal ?? this.minimal,
      hdasar: hdasar ?? this.hdasar,
      aktif: aktif ?? this.aktif,
      supplier: supplier ?? this.supplier,
      qtydos: qtydos ?? this.qtydos,
      minorder: minorder ?? this.minorder,
      bobot: bobot ?? this.bobot,
      grade: grade ?? this.grade,
      rak: rak ?? this.rak,
      namaList: namaList ?? this.namaList,
      deskripsi: deskripsi ?? this.deskripsi,
      idgol: idgol ?? this.idgol,
      golongan: golongan ?? this.golongan,
      idsatuan: idsatuan ?? this.idsatuan,
      isi: isi ?? this.isi,
      nostok: nostok ?? this.nostok,
      harga: harga ?? this.harga,
      updated: updated ?? this.updated,
      created: created ?? this.created,
      iddevisi: iddevisi ?? this.iddevisi,
      devisi: devisi ?? this.devisi,
      fileGambar: fileGambar ?? this.fileGambar,
      fileThumb: fileThumb ?? this.fileThumb,
      liststok: liststok ?? this.liststok,
      listpeletakan: listpeletakan ?? this.listpeletakan,
      listsatuan: listsatuan ?? this.listsatuan,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! BARANG) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      kode.hashCode ^
      barcode.hashCode ^
      id.hashCode ^
      nama.hashCode ^
      idkategori.hashCode ^
      kategori.hashCode ^
      idkelompok.hashCode ^
      kelompok.hashCode ^
      idjenis.hashCode ^
      jenis.hashCode ^
      idmerk.hashCode ^
      merk.hashCode ^
      satuan.hashCode ^
      beli.hashCode ^
      jual.hashCode ^
      jual1.hashCode ^
      jual2.hashCode ^
      jual3.hashCode ^
      jual4.hashCode ^
      jual5.hashCode ^
      stok.hashCode ^
      stokgd.hashCode ^
      stoknr.hashCode ^
      stoklokasi.hashCode ^
      poin.hashCode ^
      pembagi.hashCode ^
      kg.hashCode ^
      kd.hashCode ^
      gambar.hashCode ^
      markup1.hashCode ^
      markup2.hashCode ^
      markup3.hashCode ^
      markup4.hashCode ^
      markup5.hashCode ^
      markupbeli.hashCode ^
      stokminimal.hashCode ^
      minimal.hashCode ^
      hdasar.hashCode ^
      aktif.hashCode ^
      supplier.hashCode ^
      qtydos.hashCode ^
      minorder.hashCode ^
      bobot.hashCode ^
      grade.hashCode ^
      rak.hashCode ^
      namaList.hashCode ^
      deskripsi.hashCode ^
      idgol.hashCode ^
      golongan.hashCode ^
      idsatuan.hashCode ^
      isi.hashCode ^
      nostok.hashCode ^
      harga.hashCode;
}
