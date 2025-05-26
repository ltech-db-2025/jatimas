import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';
import '../kontak.dart';
import '../termin.dart';
import 'detail.dart';
import 'kas.dart';

class TRANSAKSI {
  int? id;
  String? notrans;
  String? kdpc;
  String? kdtrans;
  int? iddevisi;
  String? devisi;
  int? nobukti;
  String? tanggal;
  int? idkontak;
  String? kontak;
  String? namakontak;
  String? tipe;
  double? nilai;
  double? norek;
  String? operator;
  String? keterangan;
  int? idpegawai;
  String? pegawai;
  int? idsales;
  String? sales;
  String? pdiskon;
  double? diskon;
  double? biaya;
  double? nilaitotal;
  double? rekkas;
  String? akunkas;
  double? bayar;
  double? pembulatan;
  double? rekkredit;
  String? akunkredit;
  double? kredit;
  double? potongnota;
  double? pembayaran;
  double? saldo;
  String? tempo;
  String? termin;
  double? qty;
  double? proses;
  double? gagal;
  double? terpakai;
  double? sisa;
  int? idlokasi;
  String? lokasi;
  int? idlokasi2;
  String? lokasi2;
  int? idharga;
  String? jharga;
  int? iddiskon;
  String? namadiskon;
  int? idpengirim;
  String? pengirim;
  String? pengirimantgl;
  double? hpp;
  double? hasil;
  double? selesai;
  String? referensi;
  int? debit;
  String? created;
  int? tutup;
  String? dibuat;
  String? aksesakhir;
  String? catatan;
  int? notasales;
  double? poin;
  String? pointempo;
  double? pointerbayar;
  int? idpenjualan;
  int? cek;
  int? status;
  String? namastatus;
  String? data;
  String alamat_kirim;
  List<DETAIL>? detail;
  List<KAS>? detailkas;
  KONTAK? datakontak;
  TERMIN? datatermin;
  TRANSAKSI({
    this.id,
    this.notrans,
    this.kdpc,
    this.kdtrans,
    this.iddevisi,
    this.devisi,
    this.nobukti,
    this.tanggal,
    this.idkontak,
    this.kontak,
    this.namakontak,
    this.tipe,
    this.nilai,
    this.norek,
    this.operator,
    this.keterangan,
    this.idpegawai,
    this.pegawai,
    this.idsales,
    this.sales,
    this.pdiskon,
    this.diskon,
    this.biaya,
    this.nilaitotal,
    this.rekkas,
    this.akunkas,
    this.bayar,
    this.pembulatan,
    this.rekkredit,
    this.akunkredit,
    this.kredit,
    this.potongnota,
    this.pembayaran,
    this.saldo,
    this.tempo,
    this.termin,
    this.qty,
    this.proses,
    this.gagal,
    this.terpakai,
    this.sisa,
    this.idlokasi,
    this.lokasi,
    this.idlokasi2,
    this.lokasi2,
    this.idharga,
    this.jharga,
    this.iddiskon,
    this.namadiskon,
    this.idpengirim,
    this.pengirim,
    this.pengirimantgl,
    this.hpp,
    this.hasil,
    this.selesai,
    this.referensi,
    this.debit,
    this.created,
    this.tutup,
    this.dibuat,
    this.aksesakhir,
    this.catatan,
    this.notasales,
    this.poin,
    this.pointempo,
    this.pointerbayar,
    this.idpenjualan,
    this.cek,
    this.status,
    this.namastatus,
    this.detail,
    this.detailkas,
    this.datakontak,
    this.data,
    this.alamat_kirim = '',
    this.datatermin,
  });

  @override
  String toString() {
    return 'TRANSAKSI(id: $id, notrans: $notrans, kdpc: $kdpc, kdtrans: $kdtrans, iddevisi: $iddevisi, devisi: $devisi, nobukti: $nobukti, tanggal: $tanggal, idkontak: $idkontak, kontak: $kontak, tipe: $tipe, nilai: $nilai, norek: $norek, operator: $operator, keterangan: $keterangan, idpegawai: $idpegawai, pegawai: $pegawai,idsales: : $idsales, sales: $sales, pdiskon: $pdiskon, diskon: $diskon, biaya: $biaya, nilaitotal: $nilaitotal, rekkas: $rekkas, bayar: $bayar, pembulatan: $pembulatan, rekkredit: $rekkredit, kredit: $kredit, potongnota: $potongnota, pembayaran: $pembayaran, saldo: $saldo, tempo: $tempo, termin: $termin, qty: $qty, proses: $proses, gagal: $gagal, terpakai: $terpakai, sisa: $sisa, idlokasi: $idlokasi, lokasi: $lokasi, idlokasi2: $idlokasi2, lokasi2: $lokasi2, idharga: $idharga, iddiskon: $iddiskon, namadiskon: $namadiskon, idpengirim: $idpengirim, pengirim: $pengirim, pengirimantgl: $pengirimantgl, hpp: $hpp, hasil: $hasil, selesai: $selesai, referensi: $referensi, debit: $debit, created: $created, tutup: $tutup, dibuat: $dibuat, aksesakhir: $aksesakhir, catatan: $catatan, notasales: $notasales, poin: $poin, pointempo: $pointempo, pointerbayar: $pointerbayar,  idpenjualan: $idpenjualan, cek: $cek, status: $status, idharga: $idharga, jharga: $jharga, namastatus: $namastatus, detail: $detail, detailkas: $detailkas, datakontak: $datakontak, data: $data, termin: $datatermin)';
  }

  factory TRANSAKSI.fromMap(Map<String, dynamic> data) => TRANSAKSI(
        id: makeInt(data['id']),
        notrans: makeStr(data['notrans']),
        kdpc: makeStr(data['kdpc']),
        kdtrans: makeStr(data['kdtrans']),
        iddevisi: makeInt(data['iddevisi']),
        devisi: makeStr(data['devisi']),
        nobukti: makeInt(data['nobukti']),
        tanggal: makeStr(data['tanggal']),
        idkontak: makeInt(data['idkontak']),
        kontak: makeStr(data['kontak']),
        namakontak: makeStr(data['namakontak']),
        tipe: makeStr(data['tipe']),
        nilai: makeDouble(data['nilai']),
        norek: makeDouble(data['norek']),
        operator: makeStr(data['operator']),
        keterangan: makeStr(data['keterangan']),
        idpegawai: makeInt(data['idpegawai']),
        pegawai: makeStr(data['pegawai']),
        idsales: makeInt(data['idsales']),
        sales: makeStr(data['sales']),
        pdiskon: makeStr(data['pdiskon']),
        diskon: makeDouble(data['diskon']),
        biaya: makeDouble(data['biaya']),
        nilaitotal: makeDouble(data['nilaitotal']),
        rekkas: makeDouble(data['rekkas'] ?? data['rek_kas']),
        akunkas: makeStr(data['akunkas']),
        bayar: makeDouble(data['bayar']),
        pembulatan: makeDouble(data['pembulatan']),
        rekkredit: makeDouble(data['rekkredit'] ?? data['rek_kredit']),
        akunkredit: makeStr(data['akunkredit']),
        kredit: makeDouble(data['kredit']),
        potongnota: makeDouble(data['potongnota']),
        pembayaran: makeDouble(data['pembayaran']),
        saldo: makeDouble(data['saldo']),
        tempo: makeStr(data['tempo']),
        termin: makeStr(data['termin']),
        qty: makeDouble(data['qty']),
        proses: makeDouble(data['proses']),
        gagal: makeDouble(data['gagal']),
        terpakai: makeDouble(data['terpakai']),
        sisa: makeDouble(data['sisa']),
        idlokasi: makeInt(data['idlokasi']),
        lokasi: makeStr(data['lokasi']),
        idlokasi2: makeInt(data['idlokasi2']),
        lokasi2: makeStr(data['lokasi2']),
        idharga: makeInt(data['idharga']),
        jharga: makeStr(data['jharga']),
        iddiskon: makeInt(data['iddiskon']),
        namadiskon: makeStr(data['namadiskon']),
        idpengirim: makeInt(data['idpengirim']),
        pengirim: makeStr(data['pengirim']),
        pengirimantgl: makeStr(data['pengirimantgl']),
        hpp: makeDouble(data['hpp']),
        hasil: makeDouble(data['hasil']),
        selesai: makeDouble(data['selesai']),
        referensi: makeStr(data['referensi']),
        debit: makeInt(data['debit']),
        created: makeStr(data['created']),
        tutup: makeInt(data['tutup']),
        dibuat: makeStr(data['dibuat']),
        aksesakhir: makeStr(data['aksesakhir']),
        catatan: makeStr(data['catatan']),
        notasales: makeInt(data['notasales']),
        poin: makeDouble(data['poin']),
        pointempo: makeStr(data['pointempo']),
        pointerbayar: makeDouble(data['pointerbayar']),
        idpenjualan: makeInt(data['idpenjualan']),
        cek: makeInt(data['cek']),
        status: makeInt(data['status']),
        namastatus: makeStr(data['namastatus']),
        data: makeStr(data['data']),
        alamat_kirim: makeStr(data['alamat_kirim']) ?? '',
        detail: (data['detail'] == null) ? null : (jsonDecode(data['detail']) as List<dynamic>?)?.map((e) => DETAIL.fromMap(e as Map<String, dynamic>)).toList(),
        detailkas: (data['detailkas'] == null) ? null : (jsonDecode(data['detailkas']) as List<dynamic>?)?.map((e) => KAS.fromMap(e as Map<String, dynamic>)).toList(),
        datakontak: (data['datakontak'] == null) ? null : KONTAK.fromMap(data['datakontak'] as Map<String, dynamic>),
        datatermin: (data['datatermin'] == null) ? null : TERMIN.fromMap(data['datatermin'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'notrans': notrans,
        'kdpc': kdpc,
        'kdtrans': kdtrans,
        'iddevisi': iddevisi,
        'devisi': devisi,
        'nobukti': nobukti,
        'tanggal': tanggal,
        'idkontak': idkontak,
        'kontak': namakontak,
        'namakontak': kontak,
        'tipe': tipe,
        'nilai': nilai,
        'norek': norek,
        'operator': operator,
        'keterangan': keterangan,
        'idpegawai': idpegawai,
        'pegawai': pegawai,
        'idsales': idsales,
        'sales': sales,
        'pdiskon': pdiskon,
        'diskon': diskon,
        'biaya': biaya,
        'nilaitotal': nilaitotal,
        'rekkas': rekkas,
        'bayar': bayar,
        'pembulatan': pembulatan,
        'rekkredit': rekkredit,
        'kredit': kredit,
        'potongnota': potongnota,
        'pembayaran': pembayaran,
        'saldo': saldo,
        'tempo': tempo,
        'termin': termin,
        'qty': qty,
        'proses': proses,
        'gagal': gagal,
        'terpakai': terpakai,
        'sisa': sisa,
        'idlokasi': idlokasi,
        'lokasi': lokasi,
        'idlokasi2': idlokasi2,
        'lokasi2': lokasi2,
        'idharga': idharga,
        'jharga': jharga,
        'iddiskon': iddiskon,
        'namadiskon': namadiskon,
        'idpengirim': idpengirim,
        'pengirim': pengirim,
        'pengirimantgl': pengirimantgl,
        'hpp': hpp,
        'hasil': hasil,
        'selesai': selesai,
        'referensi': referensi,
        'debit': debit,
        'created': created,
        'tutup': tutup,
        'dibuat': dibuat,
        'aksesakhir': aksesakhir,
        'catatan': catatan,
        'notasales': notasales,
        'poin': poin,
        'pointempo': pointempo,
        'pointerbayar': pointerbayar,
        'cek': cek,
        'idpenjualan': idpenjualan,
        'status': status,
        'namastatus': namastatus,
        'data': data,
        'alamat_kirim': alamat_kirim,
        'detail': detail?.map((e) => e.toMap()).toList(),
        'datakontak': datakontak?.toMap(),
        'datatermin': datatermin?.toMap(),
      };
  String toJson() => json.encode(toMap());

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TRANSAKSI].
  factory TRANSAKSI.fromJson(String data) {
    return TRANSAKSI.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  static Future<List<TRANSAKSI>> get([Map<String, dynamic>? where]) async {
    List<TRANSAKSI> result = <TRANSAKSI>[];

    return result;
  }

  static Future<TRANSAKSI> byID(int? id, [String? data]) async {
    return TRANSAKSI();
  }

  /// `dart:convert`
  ///
  /// Converts [TRANSAKSI] to a JSON string.

  String updateDraftSql() {
    var sql = """
        update t_draft set 
          idkontak = ${idkontak},                              
          idpegawai = ${idpegawai},
          tanggal = '${tanggal}',                              
          idlokasi = ${idlokasi},
          rek_kas = ${rekkas},
          jharga = '${jharga}',
        """;
    if (termin != null) sql += "termin = '${termin}',";
    if (bayar != null) sql += "bayar = ${bayar},";
    if (proses != null) sql += "proses = ${proses},";
    if (sisa != null) sql += "sisa = ${sisa},";
    if (tempo != null) sql += "tempo = '${tempo}',";
    if (catatan != null) sql += "catatan = '${catatan}',";
    if (rekkas != null) sql += "rek_kas = ${rekkas},";

    sql += "cek = 66 where id = ${id}";
    return sql;
  }

  TRANSAKSI copyWith({
    int? id,
    String? notrans,
    String? kdpc,
    String? kdtrans,
    int? iddevisi,
    String? devisi,
    int? nobukti,
    String? tanggal,
    int? idkontak,
    String? kontak,
    String? namakontak,
    String? tipe,
    double? nilai,
    double? norek,
    String? operator,
    String? keterangan,
    int? idpegawai,
    String? pegawai,
    int? idsales,
    String? sales,
    String? pdiskon,
    double? diskon,
    double? biaya,
    double? nilaitotal,
    double? rekkas,
    double? bayar,
    double? pembulatan,
    double? rekkredit,
    double? kredit,
    double? potongnota,
    double? pembayaran,
    double? saldo,
    String? tempo,
    String? termin,
    double? qty,
    double? proses,
    double? gagal,
    double? terpakai,
    double? sisa,
    int? idlokasi,
    String? lokasi,
    int? idlokasi2,
    String? lokasi2,
    int? idharga,
    String? jharga,
    int? iddiskon,
    String? namadiskon,
    int? idpengirim,
    String? pengirim,
    String? pengirimantgl,
    double? hpp,
    double? hasil,
    double? selesai,
    String? referensi,
    int? debit,
    String? created,
    int? tutup,
    String? dibuat,
    String? aksesakhir,
    String? catatan,
    int? notasales,
    double? poin,
    String? pointempo,
    double? pointerbayar,
    int? idpenjualan,
    int? cek,
    int? status,
    String? namastatus,
    String? data,
    String? alamat_kirim,
    KONTAK? datakontak,
    List<DETAIL>? detail,
    List<KAS>? detailkas,
    TERMIN? datatermin,
  }) {
    return TRANSAKSI(
      id: id ?? this.id,
      notrans: notrans ?? this.notrans,
      kdpc: kdpc ?? this.kdpc,
      kdtrans: kdtrans ?? this.kdtrans,
      iddevisi: iddevisi ?? this.iddevisi,
      devisi: devisi ?? this.devisi,
      nobukti: nobukti ?? this.nobukti,
      tanggal: tanggal ?? this.tanggal,
      idkontak: idkontak ?? this.idkontak,
      kontak: kontak ?? this.kontak,
      namakontak: namakontak ?? this.namakontak,
      tipe: tipe ?? this.tipe,
      nilai: nilai ?? this.nilai,
      norek: norek ?? this.norek,
      operator: operator ?? this.operator,
      keterangan: keterangan ?? this.keterangan,
      idpegawai: idpegawai ?? this.idpegawai,
      pegawai: pegawai ?? this.pegawai,
      idsales: idsales ?? this.idsales,
      sales: sales ?? this.sales,
      pdiskon: pdiskon ?? this.pdiskon,
      diskon: diskon ?? this.diskon,
      biaya: biaya ?? this.biaya,
      nilaitotal: nilaitotal ?? this.nilaitotal,
      rekkas: rekkas ?? this.rekkas,
      bayar: bayar ?? this.bayar,
      pembulatan: pembulatan ?? this.pembulatan,
      rekkredit: rekkredit ?? this.rekkredit,
      kredit: kredit ?? this.kredit,
      potongnota: potongnota ?? this.potongnota,
      pembayaran: pembayaran ?? this.pembayaran,
      saldo: saldo ?? this.saldo,
      tempo: tempo ?? this.tempo,
      termin: termin ?? this.termin,
      qty: qty ?? this.qty,
      proses: proses ?? this.proses,
      gagal: gagal ?? this.gagal,
      terpakai: terpakai ?? this.terpakai,
      sisa: sisa ?? this.sisa,
      idlokasi: idlokasi ?? this.idlokasi,
      lokasi: lokasi ?? this.lokasi,
      idlokasi2: idlokasi2 ?? this.idlokasi2,
      lokasi2: lokasi2 ?? this.lokasi2,
      idharga: idharga ?? this.idharga,
      jharga: jharga ?? this.jharga,
      iddiskon: iddiskon ?? this.iddiskon,
      namadiskon: namadiskon ?? this.namadiskon,
      idpengirim: idpengirim ?? this.idpengirim,
      pengirim: pengirim ?? this.pengirim,
      pengirimantgl: pengirimantgl ?? this.pengirimantgl,
      hpp: hpp ?? this.hpp,
      hasil: hasil ?? this.hasil,
      selesai: selesai ?? this.selesai,
      referensi: referensi ?? this.referensi,
      debit: debit ?? this.debit,
      created: created ?? this.created,
      tutup: tutup ?? this.tutup,
      dibuat: dibuat ?? this.dibuat,
      aksesakhir: aksesakhir ?? this.aksesakhir,
      catatan: catatan ?? this.catatan,
      notasales: notasales ?? this.notasales,
      poin: poin ?? this.poin,
      pointempo: pointempo ?? this.pointempo,
      pointerbayar: pointerbayar ?? this.pointerbayar,
      idpenjualan: idpenjualan ?? this.idpenjualan,
      cek: cek ?? this.cek,
      status: status ?? this.status,
      namastatus: namastatus ?? this.namastatus,
      data: data ?? this.data,
      alamat_kirim: alamat_kirim ?? this.alamat_kirim,
      datakontak: datakontak ?? datakontak,
      detail: detail ?? this.detail,
      detailkas: detailkas ?? this.detailkas,
      datatermin: datatermin ?? this.datatermin,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! TRANSAKSI) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      notrans.hashCode ^
      kdpc.hashCode ^
      kdtrans.hashCode ^
      iddevisi.hashCode ^
      nobukti.hashCode ^
      tanggal.hashCode ^
      idkontak.hashCode ^
      kontak.hashCode ^
      tipe.hashCode ^
      nilai.hashCode ^
      norek.hashCode ^
      operator.hashCode ^
      keterangan.hashCode ^
      idpegawai.hashCode ^
      pegawai.hashCode ^
      idsales.hashCode ^
      sales.hashCode ^
      pdiskon.hashCode ^
      diskon.hashCode ^
      biaya.hashCode ^
      nilaitotal.hashCode ^
      rekkas.hashCode ^
      bayar.hashCode ^
      pembulatan.hashCode ^
      rekkredit.hashCode ^
      kredit.hashCode ^
      potongnota.hashCode ^
      pembayaran.hashCode ^
      saldo.hashCode ^
      tempo.hashCode ^
      termin.hashCode ^
      qty.hashCode ^
      proses.hashCode ^
      gagal.hashCode ^
      terpakai.hashCode ^
      sisa.hashCode ^
      idlokasi.hashCode ^
      lokasi.hashCode ^
      idlokasi2.hashCode ^
      lokasi2.hashCode ^
      idharga.hashCode ^
      jharga.hashCode ^
      iddiskon.hashCode ^
      namadiskon.hashCode ^
      idpengirim.hashCode ^
      pengirim.hashCode ^
      pengirimantgl.hashCode ^
      hpp.hashCode ^
      hasil.hashCode ^
      selesai.hashCode ^
      referensi.hashCode ^
      debit.hashCode ^
      created.hashCode ^
      tutup.hashCode ^
      dibuat.hashCode ^
      aksesakhir.hashCode ^
      catatan.hashCode ^
      notasales.hashCode ^
      poin.hashCode ^
      pointempo.hashCode ^
      pointerbayar.hashCode ^
      idpenjualan.hashCode ^
      cek.hashCode ^
      status.hashCode ^
      namastatus.hashCode ^
      data.hashCode ^
      detail.hashCode;

  Map<String, dynamic> toPost() => {
        'id': id.toString(),
        'notrans': notrans.toString(),
        'kdpc': kdpc.toString(),
        'kdtrans': kdtrans.toString(),
        'iddevisi': iddevisi.toString(),
        'nobukti': nobukti.toString(),
        'tanggal': tanggal.toString(),
        'idkontak': idkontak.toString(),
        'kontak': kontak.toString(),
        'tipe': tipe.toString(),
        'nilai': nilai.toString(),
        'norek': norek.toString(),
        'operator': operator.toString(),
        'keterangan': keterangan.toString(),
        'idpegawai': idpegawai.toString(),
        'pegawai': pegawai.toString(),
        'pdiskon': pdiskon.toString(),
        'diskon': diskon.toString(),
        'biaya': biaya.toString(),
        'nilaitotal': nilaitotal.toString(),
        'rekkas': rekkas.toString(),
        'bayar': bayar.toString(),
        'pembulatan': pembulatan.toString(),
        'rekkredit': rekkredit.toString(),
        'akunkredit': akunkredit.toString(),
        'kredit': kredit.toString(),
        'potongnota': potongnota.toString(),
        'pembayaran': pembayaran.toString(),
        'saldo': saldo.toString(),
        'tempo': tempo.toString(),
        'termin': termin.toString(),
        'qty': qty.toString(),
        'proses': proses.toString(),
        'gagal': gagal.toString(),
        'terpakai': terpakai.toString(),
        'sisa': sisa.toString(),
        'idlokasi': idlokasi.toString(),
        'lokasi': lokasi.toString(),
        'idlokasi2': idlokasi2.toString(),
        'lokasi2': lokasi2.toString(),
        'idharga': idharga.toString(),
        'iddiskon': iddiskon.toString(),
        'namadiskon': namadiskon.toString(),
        'idpengirim': idpengirim.toString(),
        'pengirim': pengirim.toString(),
        'pengirimantgl': pengirimantgl.toString(),
        'hpp': hpp.toString(),
        'hasil': hasil.toString(),
        'selesai': selesai.toString(),
        'referensi': referensi.toString(),
        'debit': debit.toString(),
        'created': created.toString(),
        'tutup': tutup.toString(),
        'dibuat': dibuat.toString(),
        'aksesakhir': aksesakhir.toString(),
        'catatan': catatan.toString(),
        'notasales': notasales.toString(),
        'poin': poin.toString(),
        'pointempo': pointempo.toString(),
        'pointerbayar': pointerbayar.toString(),
        'cek': cek.toString(),
        'status': status.toString(),
        'namastatus': namastatus.toString(),
        'data': data.toString(),
      };
}

class MasterDetail {
  TRANSAKSI? master;
  DETAIL? detail;
  KAS? kas;
  MasterDetail({this.master, this.detail, this.kas});
}
