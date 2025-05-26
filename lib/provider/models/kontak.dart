import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:ljm/tools/env.dart';

import 'termin.dart';

class KONTAK {
  int? id;
  bool? c;
  bool? s;
  bool? p;
  String? kode;
  int? idkategori;
  String? kategori;
  int? idharga;
  String? harga;
  int? iddiskon;
  String? diskon;
  String? nama;
  String? golongan;
  String? jabatan;
  String? perusahaan;
  int? aktif;
  int? defalamat;
  String? alamat;
  String? kota;
  int? idprovinsi;
  String? provinsi;
  int? idkabupaten;
  String? kabupaten;
  int? idkecamatan;
  String? kecamatan;
  int? iddesa;
  String? desa;
  int? tipealamat;
  int? defkontak;
  int? tipekontak;
  String? uraian;
  int? iddevisi;
  String? devisi;
  String? prosentaseSales;
  double? hutang;
  double? piutang;
  double? saldoawal;
  double? saldo;
  double? plafon;
  double? tipe;
  String? termin;
  String? alamatkirim;
  String? wilayah;
  int? kodepos;
  String? email;
  String? wa;
  String? telp;
  String? hp;
  String? fax;
  String? website;
  String? gambar;
  String? updated;
  TERMIN? datatermin;

  KONTAK({
    this.id,
    this.c,
    this.s,
    this.p,
    this.kode,
    this.idkategori,
    this.kategori,
    this.idharga,
    this.harga,
    this.iddiskon,
    this.diskon,
    this.nama,
    this.golongan,
    this.jabatan,
    this.perusahaan,
    this.aktif,
    this.defalamat,
    this.alamat,
    this.kota,
    this.idprovinsi,
    this.provinsi,
    this.idkabupaten,
    this.kabupaten,
    this.idkecamatan,
    this.kecamatan,
    this.iddesa,
    this.desa,
    this.tipealamat,
    this.defkontak,
    this.tipekontak,
    this.uraian,
    this.iddevisi,
    this.devisi,
    this.prosentaseSales,
    this.hutang,
    this.piutang,
    this.saldoawal,
    this.saldo,
    this.plafon,
    this.tipe,
    this.termin,
    this.alamatkirim,
    this.wilayah,
    this.kodepos,
    this.email,
    this.wa,
    this.telp,
    this.hp,
    this.fax,
    this.website,
    this.gambar,
    this.updated,
    this.datatermin,
  });

  @override
  String toString() {
    return 'KONTAK(id: $id, c: $c, s: $s, p: $p, kode: $kode, idkategori: $idkategori, kategori: $kategori, idharga: $idharga, harga: $harga, iddiskon, $iddiskon, diskon: $diskon, nama: $nama, golongan: $golongan, jabatan: $jabatan, perusahaan: $perusahaan, aktif: $aktif, defalamat: $defalamat, alamat: $alamat, kota: $kota, idprovinsi: $idprovinsi, provinsi: $provinsi, idkabupaten: $idkabupaten, kabupaten: $kabupaten, idkecamatan: $idkecamatan, kecamatan: $kecamatan, iddesa: $iddesa, desa: $desa, tipealamat: $tipealamat, defkontak: $defkontak, tipekontak: $tipekontak, uraian: $uraian, iddevisi: $iddevisi, devisi: $devisi, prosentaseSales: $prosentaseSales, hutang: $hutang, piutang: $piutang, saldoawal: $saldoawal, saldo: $saldo, plafon: $plafon, tipe: $tipe, termin: $termin, alamatkirim: $alamatkirim, wilayah: $wilayah, kodepos: $kodepos, email: $email, wa: $wa, telp: $telp, hp: $hp, fax: $fax, website: $website, gambar: $gambar, updated: $updated)';
  }

  factory KONTAK.fromMap(Map<String, dynamic> data) => KONTAK(
        id: makeInt(data['id']),
        c: makeBool(data['c']),
        s: makeBool(data['s']),
        p: makeBool(data['p']),
        kode: makeStr(data['kode']),
        idkategori: makeInt(data['idkategori']),
        kategori: makeStr(data['kategori']),
        idharga: makeInt(data['idharga']),
        harga: makeStr(data['harga']),
        iddiskon: makeInt(data['iddiskon']),
        diskon: makeStr(data['diskon']),
        nama: makeStr(data['nama']),
        golongan: makeStr(data['golongan']),
        jabatan: makeStr(data['jabatan']),
        perusahaan: makeStr(data['perusahaan']),
        aktif: makeInt(data['aktif']),
        defalamat: makeInt(data['defalamat']),
        alamat: makeStr(data['alamat']),
        kota: makeStr(data['kota']),
        idprovinsi: makeInt(data['idprovinsi']),
        provinsi: makeStr(data['provinsi']),
        idkabupaten: makeInt(data['idkabupaten']),
        kabupaten: makeStr(data['kabupaten']),
        idkecamatan: makeInt(data['idkecamatan']),
        kecamatan: makeStr(data['kecamatan']),
        iddesa: makeInt(data['iddesa']),
        desa: makeStr(data['desa']),
        tipealamat: makeInt(data['tipealamat']),
        defkontak: makeInt(data['defkontak']),
        tipekontak: makeInt(data['tipekontak']),
        uraian: makeStr(data['uraian']),
        iddevisi: makeInt(data['iddevisi']),
        devisi: makeStr(data['devisi']),
        prosentaseSales: makeStr(data['prosentase_sales']),
        hutang: makeDouble(data['hutang']),
        piutang: makeDouble(data['piutang']),
        saldoawal: makeDouble(data['saldoawal']),
        saldo: makeDouble(data['saldo']),
        plafon: makeDouble(data['plafon']),
        tipe: makeDouble(data['tipe']),
        termin: makeStr(data['termin']),
        alamatkirim: makeStr(data['alamat_kirim']),
        wilayah: makeStr(data['wilayah']),
        kodepos: makeInt(data['kodepos']),
        email: makeStr(data['email']),
        wa: makeStr(data['wa']),
        telp: makeStr(data['telp']),
        hp: makeStr(data['hp']),
        fax: makeStr(data['fax']),
        website: makeStr(data['website']),
        gambar: makeStr(data['gambar']),
        updated: makeStr(data['updated']),
        datatermin: (data['datatermin'] != null) ? TERMIN.fromMap(data['datatermin']) : null,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'c': c,
        's': s,
        'p': p,
        'kode': kode,
        'idkategori': idkategori,
        'kategori': kategori,
        'idharga': idharga,
        'harga': harga,
        'iddiskon': iddiskon,
        'diskon': diskon,
        'nama': nama,
        'golongan': golongan,
        'jabatan': jabatan,
        'perusahaan': perusahaan,
        'aktif': aktif,
        'defalamat': defalamat,
        'alamat': alamat,
        'kota': kota,
        'idprovinsi': idprovinsi,
        'provinsi': provinsi,
        'idkabupaten': idkabupaten,
        'kabupaten': kabupaten,
        'idkecamatan': idkecamatan,
        'kecamatan': kecamatan,
        'iddesa': iddesa,
        'desa': desa,
        'tipealamat': tipealamat,
        'defkontak': defkontak,
        'tipekontak': tipekontak,
        'uraian': uraian,
        'iddevisi': iddevisi,
        'devisi': devisi,
        'prosentase_sales': prosentaseSales,
        'hutang': hutang,
        'piutang': piutang,
        'saldoawal': saldoawal,
        'saldo': saldo,
        'plafon': plafon,
        'tipe': tipe,
        'termin': termin,
        'alamat_kirim': alamatkirim,
        'wilayah': wilayah,
        'kodepos': kodepos,
        'email': email,
        'wa': wa,
        'telp': telp,
        'hp': hp,
        'fax': fax,
        'website': website,
        'gambar': gambar,
        'updated': updated,
      };

  factory KONTAK.fromJson(String data) {
    return KONTAK.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  KONTAK copyWith({
    int? id,
    bool? c,
    bool? s,
    bool? p,
    String? kode,
    int? idkategori,
    String? kategori,
    int? idharga,
    String? harga,
    int? iddiskon,
    String? diskon,
    String? nama,
    String? golongan,
    String? jabatan,
    String? perusahaan,
    int? aktif,
    int? defalamat,
    String? alamat,
    String? kota,
    int? idprovinsi,
    String? provinsi,
    int? idkabupaten,
    String? kabupaten,
    int? idkecamatan,
    String? kecamatan,
    int? iddesa,
    String? desa,
    int? tipealamat,
    int? defkontak,
    int? tipekontak,
    String? uraian,
    int? iddevisi,
    String? devisi,
    String? prosentaseSales,
    double? hutang,
    double? piutang,
    double? saldoawal,
    double? saldo,
    double? plafon,
    double? tipe,
    String? termin,
    String? alamatkirim,
    String? wilayah,
    int? kodepos,
    String? email,
    String? wa,
    String? telp,
    String? hp,
    String? fax,
    String? website,
    String? gambar,
    String? updated,
  }) {
    return KONTAK(
      id: id ?? this.id,
      c: c ?? this.c,
      s: s ?? this.s,
      p: p ?? this.p,
      kode: kode ?? this.kode,
      idkategori: idkategori ?? this.idkategori,
      kategori: kategori ?? this.kategori,
      idharga: idharga ?? this.idharga,
      harga: harga ?? this.harga,
      iddiskon: iddiskon ?? this.iddiskon,
      diskon: diskon ?? this.diskon,
      nama: nama ?? this.nama,
      golongan: golongan ?? this.golongan,
      jabatan: jabatan ?? this.jabatan,
      perusahaan: perusahaan ?? this.perusahaan,
      aktif: aktif ?? this.aktif,
      defalamat: defalamat ?? this.defalamat,
      alamat: alamat ?? this.alamat,
      kota: kota ?? this.kota,
      idprovinsi: idprovinsi ?? this.idprovinsi,
      provinsi: provinsi ?? this.provinsi,
      idkabupaten: idkabupaten ?? this.idkabupaten,
      kabupaten: kabupaten ?? this.kabupaten,
      idkecamatan: idkecamatan ?? this.idkecamatan,
      kecamatan: kecamatan ?? this.kecamatan,
      iddesa: iddesa ?? this.iddesa,
      desa: desa ?? this.desa,
      tipealamat: tipealamat ?? this.tipealamat,
      defkontak: defkontak ?? this.defkontak,
      tipekontak: tipekontak ?? this.tipekontak,
      uraian: uraian ?? this.uraian,
      iddevisi: iddevisi ?? this.iddevisi,
      devisi: devisi ?? this.devisi,
      prosentaseSales: prosentaseSales ?? this.prosentaseSales,
      hutang: hutang ?? this.hutang,
      piutang: piutang ?? this.piutang,
      saldoawal: saldoawal ?? this.saldoawal,
      saldo: saldo ?? this.saldo,
      plafon: plafon ?? this.plafon,
      tipe: tipe ?? this.tipe,
      termin: termin ?? this.termin,
      alamatkirim: alamatkirim ?? this.alamatkirim,
      wilayah: wilayah ?? this.wilayah,
      kodepos: kodepos ?? this.kodepos,
      email: email ?? this.email,
      wa: wa ?? this.wa,
      telp: telp ?? this.telp,
      hp: hp ?? this.hp,
      fax: fax ?? this.fax,
      website: website ?? this.website,
      gambar: gambar ?? this.gambar,
      updated: updated ?? this.updated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! KONTAK) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      c.hashCode ^
      s.hashCode ^
      p.hashCode ^
      kode.hashCode ^
      idkategori.hashCode ^
      kategori.hashCode ^
      idharga.hashCode ^
      iddiskon.hashCode ^
      nama.hashCode ^
      golongan.hashCode ^
      jabatan.hashCode ^
      perusahaan.hashCode ^
      aktif.hashCode ^
      defalamat.hashCode ^
      alamat.hashCode ^
      kota.hashCode ^
      idprovinsi.hashCode ^
      provinsi.hashCode ^
      idkabupaten.hashCode ^
      kabupaten.hashCode ^
      idkecamatan.hashCode ^
      kecamatan.hashCode ^
      iddesa.hashCode ^
      desa.hashCode ^
      tipealamat.hashCode ^
      defkontak.hashCode ^
      tipekontak.hashCode ^
      uraian.hashCode ^
      iddevisi.hashCode ^
      devisi.hashCode ^
      prosentaseSales.hashCode ^
      hutang.hashCode ^
      piutang.hashCode ^
      saldoawal.hashCode ^
      saldo.hashCode ^
      plafon.hashCode ^
      tipe.hashCode ^
      termin.hashCode ^
      alamatkirim.hashCode ^
      wilayah.hashCode ^
      kodepos.hashCode ^
      email.hashCode ^
      wa.hashCode ^
      telp.hashCode ^
      hp.hashCode ^
      fax.hashCode ^
      website.hashCode ^
      gambar.hashCode ^
      updated.hashCode;
}

// Contoh data kontakList
List<KONTAK> kontakList = [
  KONTAK(
    id: 1,
    c: true,
    s: true,
    p: true,
    kode: 'K001',
    nama: 'John Doe',
    golongan: 'A',
    jabatan: 'Manager',
    perusahaan: 'Company A',
    aktif: 1,
    defalamat: 1,
    alamat: 'Jl. Merdeka No. 1 DKI Jakarta Jakarta Pusat ',
    kota: 'Jakarta',
    idprovinsi: 1,
    provinsi: 'DKI Jakarta',
    idkabupaten: 1,
    kabupaten: 'Jakarta Pusat',
    idkecamatan: 1,
    kecamatan: 'Menteng',
    iddesa: 1,
    desa: 'Gondangdia',
    tipealamat: 1,
    defkontak: 1,
    tipekontak: 1,
    uraian: 'Kontak utama',
    iddevisi: 1,
    devisi: 'Sales',
    prosentaseSales: '50%',
    hutang: 10000.0,
    piutang: 20000.0,
    saldoawal: 5000.0,
    saldo: 15000.0,
    plafon: 30000.0,
    tipe: 1.0,
    termin: '30 hari',
    alamatkirim: 'Jl. Merdeka No. 1',
    wilayah: 'Jakarta',
    kodepos: 10110,
    email: 'johndoe@example.com',
    wa: '081234567890',
    telp: '0211234567',
    hp: '081234567890',
    fax: '0217654321',
    website: 'www.company-a.com',
    gambar: null,
    updated: '2024-06-06',
  ),
  KONTAK(
    id: 2,
    c: false,
    s: true,
    p: true,
    kode: 'K002',
    nama: 'Jane Smith',
    golongan: 'B',
    jabatan: 'Supervisor',
    perusahaan: 'Company B',
    aktif: 1,
    defalamat: 2,
    alamat: 'Jl. Sudirman No. 10',
    kota: 'Bandung',
    idprovinsi: 2,
    provinsi: 'Jawa Barat',
    idkabupaten: 2,
    kabupaten: 'Bandung',
    idkecamatan: 2,
    kecamatan: 'Coblong',
    iddesa: 2,
    desa: 'Dago',
    tipealamat: 2,
    defkontak: 2,
    tipekontak: 2,
    uraian: 'Kontak cadangan',
    iddevisi: 2,
    devisi: 'Marketing',
    prosentaseSales: '30%',
    hutang: 5000,
    piutang: 10000,
    saldoawal: 2000,
    saldo: 8000,
    plafon: 15000,
    tipe: 2,
    termin: '60 hari',
    alamatkirim: 'Jl. Sudirman No. 10',
    wilayah: 'Bandung',
    kodepos: 40132,
    email: 'janesmith@example.com',
    wa: '082345678901',
    telp: '0229876543',
    hp: '082345678901',
    fax: '0221234567',
    website: 'www.company-b.com',
    gambar: 'assets/kobar1.png',
    updated: '2024-06-06',
  ),
];
