import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

class DETAIL {
  String? id;
  int? idtrans;
  String? updated;
  int? urut;
  int? idbarang;
  String? kode;
  String? refnotrans;
  String? refid;
  String nama;
  String? merk;
  double qty;
  int? idsatuan;
  String? satuan;
  double harga;
  double? hpp;
  double jumlah;
  double diskon;
  double biaya;
  double total;
  String? keterangan;
  double? terpakai;
  double proses;
  double? sisa;
  double? gagal;
  double? bahan;
  double? mutasi;
  int? idlokasi;
  int? idlokasi2;
  double? debit;
  int? hppbeli;
  double? poin;
  double? qtynota;
  String? waktu;
  double? retur;
  double? isi;
  String? diskon2;
  int? potongNota;
  String? poin2;
  double? diskonnota;
  int? cek;
  int? dicek;
  int? refidtrans;
  double? pesan;
  double? stok;
  String? rak;

  DETAIL({
    this.id,
    this.idtrans,
    this.updated,
    this.urut,
    this.idbarang,
    this.kode = "",
    this.refnotrans,
    this.refid,
    this.nama = "",
    this.merk,
    this.qty = 0,
    this.idsatuan,
    this.satuan,
    this.harga = 0,
    this.hpp,
    this.jumlah = 0,
    this.diskon = 0,
    this.biaya = 0,
    this.total = 0,
    this.keterangan,
    this.terpakai,
    this.proses = 0,
    this.sisa,
    this.gagal,
    this.bahan,
    this.mutasi,
    this.idlokasi,
    this.idlokasi2,
    this.debit,
    this.hppbeli,
    this.poin,
    this.qtynota,
    this.waktu,
    this.retur,
    this.isi,
    this.diskon2,
    this.potongNota,
    this.poin2,
    this.diskonnota,
    this.cek,
    this.dicek,
    this.refidtrans,
    this.pesan,
    this.stok,
    this.rak,
  });

  @override
  String toString() {
    return 'DETAIL(id: $id, idtrans: $idtrans, updated: $updated, urut: $urut, idbarang: $idbarang, kode: $kode, refnotrans: $refnotrans, refid: $refid, nama: $nama, merk: $merk, qty: $qty, idsatuan: $idsatuan, satuan: $satuan, isi: $isi, harga: $harga, hpp: $hpp, jumlah: $jumlah, diskon: $diskon, biaya: $biaya, total: $total, keterangan: $keterangan, terpakai: $terpakai, proses: $proses, sisa: $sisa, gagal: $gagal, bahan: $bahan, mutasi: $mutasi, idlokasi: $idlokasi, idlokasi2: $idlokasi2, debit: $debit, hppbeli: $hppbeli, poin: $poin, qtynota: $qtynota, waktu: $waktu, retur: $retur, isi: $isi, diskon2: $diskon2, potongNota: $potongNota, poin2: $poin2, diskonnota: $diskonnota, cek: $cek, dicek: $dicek, refidtrans: $refidtrans, pesan: $pesan, stok: $stok, rak: $rak)';
  }

  factory DETAIL.fromMap(Map<String, dynamic> data) => DETAIL(
        id: makeStr(data['id']),
        idtrans: makeInt(data['idtrans']),
        updated: makeStr(data['updated']),
        urut: makeInt(data['urut']),
        idbarang: makeInt(data['idbarang']),
        kode: makeStr(data['kode']),
        refnotrans: makeStr(data['refnotrans']),
        refid: makeStr(data['refid']),
        nama: makeStr(data['nama']),
        merk: makeStr(data['merk']),
        qty: makeDouble(data['qty']) ?? 0,
        idsatuan: makeInt(data['idsatuan']),
        satuan: makeStr(data['satuan']),
        harga: makeDouble(data['harga']) ?? 0,
        hpp: makeDouble(data['hpp']),
        jumlah: makeDouble(data['jumlah']) ?? 0,
        diskon: makeDouble(data['diskon']) ?? 0,
        biaya: makeDouble(data['biaya']) ?? 0,
        total: makeDouble(data['total']) ?? 0,
        keterangan: makeStr(data['keterangan']),
        terpakai: makeDouble(data['terpakai']),
        proses: makeDouble(data['proses']) ?? 0,
        sisa: makeDouble(data['sisa']),
        gagal: makeDouble(data['gagal']),
        bahan: makeDouble(data['bahan']),
        mutasi: makeDouble(data['mutasi']),
        idlokasi: makeInt(data['idlokasi']),
        idlokasi2: makeInt(data['idlokasi2']),
        debit: makeDouble(data['debit']),
        hppbeli: makeInt(data['hppbeli']),
        poin: makeDouble(data['poin']),
        qtynota: makeDouble(data['qtynota']),
        waktu: makeStr(data['waktu']),
        retur: makeDouble(data['retur']),
        isi: makeDouble(data['isi']),
        diskon2: makeStr(data['diskon2']),
        potongNota: makeInt(data['potong_nota']),
        poin2: makeStr(data['poin2']),
        diskonnota: makeDouble(data['diskonnota']),
        cek: makeInt(data['cek']),
        dicek: makeInt(data['dicek']),
        refidtrans: makeInt(data['refidtrans']),
        pesan: makeDouble(data['pesan']),
        stok: makeDouble(data['stok']),
        rak: makeStr(data['rak']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'idtrans': idtrans,
        'updated': updated,
        'urut': urut,
        'idbarang': idbarang,
        'kode': kode,
        'refnotrans': refnotrans,
        'refid': refid,
        'nama': nama,
        'merk': merk,
        'qty': qty,
        'idsatuan': idsatuan,
        'satuan': satuan,
        'harga': harga,
        'hpp': hpp,
        'jumlah': jumlah,
        'diskon': diskon,
        'biaya': biaya,
        'total': total,
        'keterangan': keterangan,
        'terpakai': terpakai,
        'proses': proses,
        'sisa': sisa,
        'gagal': gagal,
        'bahan': bahan,
        'mutasi': mutasi,
        'idlokasi': idlokasi,
        'idlokasi2': idlokasi2,
        'debit': debit,
        'hppbeli': hppbeli,
        'poin': poin,
        'qtynota': qtynota,
        'waktu': waktu,
        'retur': retur,
        'isi': isi,
        'diskon2': diskon2,
        'potong_nota': potongNota,
        'poin2': poin2,
        'diskonnota': diskonnota,
        'cek': cek,
        'dicek': dicek,
        'refidtrans': refidtrans,
        'pesan': pesan,
        'stok': stok,
        'rak': rak,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DETAIL].
  factory DETAIL.fromJson(String data) {
    return DETAIL.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  static String generateInsertSQL(List<DETAIL> details) {
    final StringBuffer sql = StringBuffer();
    sql.write('INSERT INTO d_draft (idtrans, idbarang,  proses, harga, idsatuan, cek) VALUES ');

    List<String> values = details.map((detail) {
      return '(${detail.idtrans}, ${detail.idbarang}, ${detail.proses}, ${detail.harga}, ${detail.idsatuan}, 6)';
    }).toList();

    sql.write(values.join(', '));
    sql.write(';'); // Menambahkan titik koma di akhir

    return sql.toString();
  }

  /// `dart:convert`
  ///
  /// Converts [DETAIL] to a JSON string.
  String toJson() => json.encode(toMap());

  DETAIL copyWith({
    String? id,
    int? idtrans,
    String? updated,
    int? urut,
    int? idbarang,
    String? kode,
    String? refnotrans,
    String? refid,
    String? nama,
    String? merk,
    double? qty,
    int? idsatuan,
    String? satuan,
    double? harga,
    double? hpp,
    double? jumlah,
    double? diskon,
    double? biaya,
    double? total,
    String? keterangan,
    double? terpakai,
    double? proses,
    double? sisa,
    double? gagal,
    double? bahan,
    double? mutasi,
    int? idlokasi,
    int? idlokasi2,
    double? debit,
    int? hppbeli,
    double? poin,
    double? qtynota,
    String? waktu,
    double? retur,
    double? isi,
    String? diskon2,
    int? potongNota,
    String? poin2,
    double? diskonnota,
    int? cek,
    int? dicek,
    int? refidtrans,
    double? pesan,
    double? stok,
    String? rak,
  }) {
    return DETAIL(
      id: id ?? this.id,
      idtrans: idtrans ?? this.idtrans,
      updated: updated ?? this.updated,
      urut: urut ?? this.urut,
      idbarang: idbarang ?? this.idbarang,
      kode: kode ?? this.kode,
      refnotrans: refnotrans ?? this.refnotrans,
      refid: refid ?? this.refid,
      nama: nama ?? this.nama,
      merk: merk ?? this.merk,
      qty: qty ?? this.qty,
      idsatuan: idsatuan ?? this.idsatuan,
      satuan: satuan ?? this.satuan,
      harga: harga ?? this.harga,
      hpp: hpp ?? this.hpp,
      jumlah: jumlah ?? this.jumlah,
      diskon: diskon ?? this.diskon,
      biaya: biaya ?? this.biaya,
      total: total ?? this.total,
      keterangan: keterangan ?? this.keterangan,
      terpakai: terpakai ?? this.terpakai,
      proses: proses ?? this.proses,
      sisa: sisa ?? this.sisa,
      gagal: gagal ?? this.gagal,
      bahan: bahan ?? this.bahan,
      mutasi: mutasi ?? this.mutasi,
      idlokasi: idlokasi ?? this.idlokasi,
      idlokasi2: idlokasi2 ?? this.idlokasi2,
      debit: debit ?? this.debit,
      hppbeli: hppbeli ?? this.hppbeli,
      poin: poin ?? this.poin,
      qtynota: qtynota ?? this.qtynota,
      waktu: waktu ?? this.waktu,
      retur: retur ?? this.retur,
      isi: isi ?? this.isi,
      diskon2: diskon2 ?? this.diskon2,
      potongNota: potongNota ?? this.potongNota,
      poin2: poin2 ?? this.poin2,
      diskonnota: diskonnota ?? this.diskonnota,
      cek: cek ?? this.cek,
      dicek: dicek ?? this.dicek,
      refidtrans: refidtrans ?? this.refidtrans,
      pesan: pesan ?? this.pesan,
      stok: stok ?? this.stok,
      rak: rak ?? this.rak,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DETAIL) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      idtrans.hashCode ^
      updated.hashCode ^
      urut.hashCode ^
      idbarang.hashCode ^
      kode.hashCode ^
      refnotrans.hashCode ^
      refid.hashCode ^
      nama.hashCode ^
      merk.hashCode ^
      qty.hashCode ^
      idsatuan.hashCode ^
      satuan.hashCode ^
      harga.hashCode ^
      hpp.hashCode ^
      jumlah.hashCode ^
      diskon.hashCode ^
      biaya.hashCode ^
      total.hashCode ^
      keterangan.hashCode ^
      terpakai.hashCode ^
      proses.hashCode ^
      sisa.hashCode ^
      gagal.hashCode ^
      bahan.hashCode ^
      mutasi.hashCode ^
      idlokasi.hashCode ^
      idlokasi2.hashCode ^
      debit.hashCode ^
      hppbeli.hashCode ^
      poin.hashCode ^
      qtynota.hashCode ^
      waktu.hashCode ^
      retur.hashCode ^
      isi.hashCode ^
      diskon2.hashCode ^
      potongNota.hashCode ^
      poin2.hashCode ^
      diskonnota.hashCode ^
      cek.hashCode ^
      dicek.hashCode ^
      refidtrans.hashCode ^
      pesan.hashCode ^
      stok.hashCode ^
      rak.hashCode;
  Map<String, dynamic> toPost() => {
        'id': id.toString(),
        'idtrans': idtrans.toString(),
        "updated": updated.toString(),
        "urut": urut.toString(),
        "idbarang": idbarang.toString(),
        "kode": kode.toString(),
        "refnotrans": refnotrans.toString(),
        "refid": refid.toString(),
        "nama": nama.toString(),
        "merk": merk.toString(),
        "qty": qty.toString(),
        "idsatuan": idsatuan.toString(),
        "satuan": satuan.toString(),
        "harga": harga.toString(),
        "hpp": hpp.toString(),
        "jumlah": jumlah.toString(),
        "diskon": diskon.toString(),
        "biaya": biaya.toString(),
        "total": total.toString(),
        "keterangan": keterangan.toString(),
        "terpakai": terpakai.toString(),
        "proses": proses.toString(),
        "sisa": sisa.toString(),
        "gagal": gagal.toString(),
        "bahan": bahan.toString(),
        "mutasi": mutasi.toString(),
        "idlokasi": idlokasi.toString(),
        "idlokasi2": idlokasi2.toString(),
        "debit": debit.toString(),
        "hppbeli": hppbeli.toString(),
        "poin": poin.toString(),
        "qtynota": qtynota.toString(),
        "waktu": waktu.toString(),
        "retur": retur.toString(),
        "isi": isi.toString(),
        "diskon2": diskon2.toString(),
        "potong_nota": potongNota.toString(),
        "poin2": poin2.toString(),
        "diskonnota": diskonnota.toString(),
        "cek": cek.toString(),
        "dicek": dicek.toString(),
        "refidtrans": refidtrans.toString(),
        "pesan": pesan.toString(),
        "stok": stok.toString(),
        "rak": rak.toString(),
      };
}
