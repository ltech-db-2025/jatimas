import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ljm/pages/homepage/main/controller.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/provider/models/kategori.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

ListBarangController cBarang(TRANSAKSI data) {
  if (Get.isRegistered<ListBarangController>(tag: data.id.toString())) {
    return Get.find<ListBarangController>(tag: data.id.toString());
  } else {
    return Get.put(ListBarangController(data), tag: data.id.toString());
  }
}

class ListBarangController extends GetxController {
  final TRANSAKSI data;
  ListBarangController(this.data);
  var list = <BARANG>[].obs;
  var brgKategori = <BARANGKATEGORI>[].obs;
  var loading = false.obs;
  var searchController = TextEditingController();
  static const pageSize = 10;
  var isSearching = false.obs;
  var semuaStokini = false.obs;
  var kategoriCap = "Semua".obs;
  var cek = 'OK'.obs;
  var trigger = 0.obs;
  var scrollController = ScrollController().obs;
  var pesanan = TRANSAKSI(detail: <DETAIL>[]).obs;
  RxInt selectedJenis = (-6).obs;
  var total = 0.0.obs;
  var subtotal = 0.0.obs;
  var jml = 0.obs;
  var jenisCap = "Semua".obs;
  var nUrut = Urut.az.obs;
  var ptGambar = ptGambarPenjualan.obs;
  final List<String> selectedColumns = ['Kode', 'Nama', 'Merk', 'Harga', 'Stok', 'Satuan'];
  final List<String> availableColumns = [
    'Kode',
    'Nama',
    'Merk',
    'Harga',
    'Stok',
    'Satuan',
  ];
  late final pagingController = PagingController<int, BARANG>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);

  @override
  onInit() {
    pesanan.value = data;
    super.onInit();

    initFirst();
  }

  setTransaksi(TRANSAKSI data) {
    pesanan.value = data;
    pagingController.refresh();
    hitung();
  }

  initFirst() async {
    loading.value = true;
    final results = await executeSql('select * from brgkategori order by kategori');

    brgKategori.value = results.map((row) {
      return BARANGKATEGORI.fromMap(row);
    }).toList();

    final respermintaan = await executeSql("""
          select p.*, pk.nama namakontak, r.alias akunkas,
            concat('[',
              ( SELECT GROUP_CONCAT(
                CONCAT(
                  '{"idtrans": "', d.idtrans,
                  '", "urut": "', coalesce(d.urut,0),  
                  '", "idbarang": "', coalesce(d.idbarang,''),
                  '", "kode": "', coalesce(d.kode,''),
                  '", "nama": "', coalesce(d.nama,''),
                  '", "merk": "', coalesce(d.merk,''),
                  '", "idsatuan": "', coalesce(d.idsatuan,''),
                  '", "satuan": "', coalesce(d.satuan,''),
                  '", "proses": "', coalesce(d.proses,0),
                  '", "isi": "', coalesce(d.isi,1), 
                  '", "harga": "', coalesce(d.harga,0), 
                  '", "jumlah": "', coalesce(d.jumlah,0), 
                  '", "status": "', coalesce(d.status,0),
                  '"}')
                  ORDER BY d.urut
                  SEPARATOR ','
                ) from detail_draft d       
                  where d.idtrans = p.id
              ),
            ']') AS detail   
          from transaksi_draft p 
          left join kontak pg on pg.id = p.idpegawai
          left join kontak pk on pk.id = p.idkontak
          left join rekening r on r.kode = p.rek_kas
          where p.id = ${data.id}
        """);
    if (respermintaan.isNotEmpty) {
      pesanan.value = TRANSAKSI.fromMap(respermintaan.first);
      // dp("pesanan.detal: ${pesanan.value.detail!.length}");
      hitung();
    } else {
      var sql = """
        insert into permintaan (id,  kdtrans, nobukti, idpegawai, idlokasi)
        values (0, 'PJ', 0, ${user.idkontak}, ${user.idlokasi});
        """;
      await executeSql(sql);
    }
    await setPengaturan();
    loading.value = false;

    update();
  }

  setPengaturan() async {
    semuaStokini.value = stokPenjualan;
    trigger++;
    await reLoad();
    update();
  }

  reLoad() async {
    pagingController.refresh();
  }

  Future<List<BARANG>> fetchPage(int pageKey) async {
    var sql = '';
    if (pesanan.value.idlokasi != null) {
      sql = """select b.id, b.kode, b.nama, b.merk, s.stok, b.${pesanan.value.jharga} harga, b.defsatuan idsatuan, b.satuan, b.gambar 
        from barang b 
        left join s on s.idlokasi = ${pesanan.value.idlokasi} and s.idbarang = b.id
        """;
      if (!stokPenjualan) sql += ' where s.stok > 0';
    } else {
      sql = """select b.id, b.kode, b.nama, b.merk, stok, b.${pesanan.value.jharga} harga, b.defsatuan idsatuan, b.satuan, b.gambar 
        from barang b 
        """;
      if (!stokPenjualan) sql += ' where stok > 0';
    }

    if (selectedJenis.value > -1) {
      sql = addWhere(sql, " idkategori = ${selectedJenis.value} ");
    }
    if (isSearching.value && searchController.text.isNotEmpty) {
      sql = addWhere(sql, createWhere(searchController.text, ['b.kode', 'b.nama', 'b.merk']));
    }
    sql += " order by b.nama";
    sql += " LIMIT $pageSize OFFSET $pageKey";
    final results = await executeSql(sql);
    final List<BARANG> items = results.map((row) {
      return BARANG.fromMap(row);
    }).toList();
    return items;
  }

  kategoriChange(int i) {
    cek.value = i.toString();
    if (i == -6) {
      kategoriCap.value = "Semua";
      selectedJenis.value = -6;
    } else {
      selectedJenis.value = i;
      kategoriCap.value = brgKategori.firstWhere((element) => element.id == i, orElse: () => BARANGKATEGORI(id: 0, kategori: '')).kategori ?? '';
    }
    trigger.value++;
    dp('katagori change: $i');
    pagingController.refresh();
    update();
    // filter(searchController.text);
  }

  tambah(BARANG data) async {
    var _lanjut = true;
    DETAIL? x;
    if (pesanan.value.detail != null) {
      x = pesanan.value.detail!.firstWhereOrNull((p0) => p0.idbarang == data.id);
    }

    if (x == null) {
      var newdata = DETAIL(
        idtrans: pesanan.value.id,
        // urut: await JualD.getLastNomor(0),
        idbarang: data.id,
        kode: data.kode,
        nama: data.nama,
        merk: data.merk,
        proses: 1,
        idsatuan: data.idsatuan,
        satuan: data.satuan,
        isi: data.isi ?? 1,
        harga: data.harga ?? 0,
        jumlah: data.harga ?? 0,
      );
      if ((data.stok ?? 0) < newdata.proses) _lanjut = await konfirmasi("Stok tidak mencukup!!\nStok: ${formatangka(data.stok)}\nPesanan: ${formatangka(newdata.proses)}") ?? false;
      if (_lanjut == true) {
        // newdata.qty = ((data.stok ?? 0) < newdata.proses) ? data.stok ?? 0 : newdata.proses;
        await simpan(newdata);
        if (pesanan.value.detail == null) pesanan.value.detail = [];
        pesanan.value.detail!.add(newdata);
        await hitung();
        trigger++;
        update();
      } else {
        return null;
      }
    } else {
      if ((data.stok ?? 0) < x.proses) _lanjut = _lanjut = await konfirmasi("Stok tidak mencukup!!\nStok: ${formatangka(data.stok)}\nPesanan: ${formatangka(x.proses + 1)}") ?? false;
      if (_lanjut) {
        x.proses = (double.tryParse(x.proses.toString()) ?? 0) + 1;
        // x.qty = ((data.stok ?? 0) < x.proses) ? data.stok ?? 0 : x.proses;
        x.jumlah = x.harga * (x.proses);
        var i = pesanan.value.detail?.indexWhere((x) => x.idbarang == data.id);
        pesanan.value.detail?.removeWhere((x) => x.idbarang == data.id);
        pesanan.value.detail?.insert(i ?? 0, x);
        await simpan(x);
        trigger++;
        await hitung();
        update();
        return x;
      } else {
        return null;
      }
    }
  }

  kurang(BARANG data) async {
    DETAIL? x;
    if (pesanan.value.detail != null) {
      x = pesanan.value.detail!.firstWhereOrNull((p0) => p0.idbarang == data.id);
    }

    if (x != null) {
      x.proses = (double.tryParse(x.proses.toString()) ?? 0) - 1;
      x.jumlah = x.harga * (x.proses);
      var i = pesanan.value.detail?.indexWhere((x) => x.idbarang == data.id);
      pesanan.value.detail?.removeWhere((x) => x.idbarang == data.id);
      pesanan.value.detail?.insert(i ?? 0, x);
      await simpan(x);
      trigger++;
      await hitung();
      update();
      return x;
    }
  }

  hitung() {
    // subtotal.value = await JualD.getSubTotal();
    subtotal.value = 0;
    double qty = 0;
    if (pesanan.value.detail != null) {
      for (var d in pesanan.value.detail!) {
        subtotal.value += (d.jumlah);
        qty += (d.qty);
      }
      jml.value = pesanan.value.detail!.length;
    }

    total.value = subtotal.value;
    trigger++;
    // nTotal++;
    pesanan.value.qty = qty;
    pesanan.value.nilai = subtotal.value;
    pesanan.value.nilaitotal = total.value;
    update();
  }

  simpan(DETAIL data) async {
    if (pesanan.value.id == -1) {
    } else {
      var sql = """
        INSERT INTO d_draft (idtrans, idbarang,  proses, harga, idsatuan, cek)
        VALUES (${pesanan.value.id}, ${data.idbarang}, ${data.proses}, ${data.harga}, ${data.idsatuan}, 6)
        ON DUPLICATE KEY UPDATE proses = ${data.proses}, cek = 6;
      """;

      await executeSql(sql);
    }
  }

  delete(DETAIL data) async {
    if (pesanan.value.id == -1) {
    } else {
      var sql = "delete from d_draft where idbarang = ${data.idbarang} and idtrans = ${data.idtrans} ";
      await executeSql(sql);
      sql = "update t_draft set nilai = (select sum(total) from d_draft where idtrans = ${data.idtrans}) where id = ${data.id}";
      await executeSql(sql);
    }
    await hitung();
  }

  deleteall() async {
    pesanan.value.detail = [];
    if ((pesanan.value.id ?? 0) > 0) {
      var sql = "delete from d_draft where idtrans = ${pesanan.value.id} ";
      await executeSql(sql);
      sql = "update t_draft set nilai = (select sum(total) from d_draft where idtrans = ${pesanan.value.id}) where id = ${data.id}";
      await executeSql(sql);
    }
    await hitung();
  }

  simpanTransaksi(TRANSAKSI newTrans) async {
    var sql = """ update t_draft set 
                              idkontak = ${newTrans.idkontak},                              
                              idpegawai = ${newTrans.idpegawai},
                              tanggal = '${newTrans.tanggal}',                              
                          """;
    if (newTrans.termin != null) sql += "termin = '${newTrans.termin}',";
    if (newTrans.jharga != null) sql += "jharga = '${newTrans.jharga}',";
    if (newTrans.tempo != null) sql += "tempo = '${newTrans.tempo}',";

    if (newTrans.catatan != null) sql += "catatan = '${newTrans.catatan}',";

    sql += "idlokasi = ${newTrans.idlokasi} where id = ${newTrans.id}";
    await executeSql(sql);
    return newTrans;
  }
}
