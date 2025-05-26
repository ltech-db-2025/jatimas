import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/provider/models/harga.dart';
import 'package:ljm/provider/models/kategori.dart';
import 'package:ljm/provider/models/lokasi.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

BarangMemberController getBarangMemberController() {
  if (Get.isRegistered<BarangMemberController>()) {
    return Get.find<BarangMemberController>();
  } else {
    return Get.put(BarangMemberController());
  }
}

class BarangMemberController extends GetxController {
  BarangMemberController();
  final searchController = TextEditingController();
  var scrollController = ScrollController().obs;
  var isSearching = false.obs;
  var pageSize = 10;
  late final PagingController<int, BARANG> pagingController = PagingController<int, BARANG>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);
  var harga = 'JUAL5'.obs;
  var idlokasi = 1.obs;
  var semuastok = true.obs;
  RxInt selectedJenis = (-6).obs;
  var total = 0.0.obs;
  var subtotal = 0.0.obs;
  var jml = 0.obs;
  var trigger = 0.obs;
  var kategoriCap = "Semua Kategori".obs;
  var brgKategori = <BARANGKATEGORI>[].obs;
  var listlokasi = <LOKASI>[];
  var listharga = <HARGA>[];
  var pesanan = TRANSAKSI(detail: <DETAIL>[]).obs;
  final List<String> selectedColumns = ['Kode', 'Nama', 'Merk', 'Harga', 'Stok', 'Satuan'];
  final List<String> availableColumns = [
    'Kode',
    'Nama',
    'Merk',
    'Harga',
    'Stok',
    'Satuan',
  ];

  onInit() {
    super.onInit();
    /* pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    }); */
    initFirst();
  }

  initFirst() async {
    // loading.value = true;
    final results = await executeSql('select * from brgkategori order by kategori');

    brgKategori.value = results.map((row) {
      return BARANGKATEGORI.fromMap(row);
    }).toList();

    // loading.value = false;
    update();
  }

  Future<List<BARANG>> fetchPage(int pageKey) async {
    var sql = '';
    if (idlokasi.value > 0) {
      sql = """select b.id, b.kode, b.nama, b.merk, b.kategori, s.stok, b.${harga.value} harga, b.satuan, b.gambar 
        from barang b 
        left join s on s.idlokasi = ${idlokasi.value} and s.idbarang = b.id
        """;
      if (!semuastok.value) sql += ' where s.stok > 0';
    } else {
      sql = """select b.id, b.kode, b.nama, b.merk, b.kategori, stok, b.${harga.value} harga, b.satuan, b.gambar 
        from barang b 
        """;
      if (!semuastok.value) sql += ' where stok > 0';
    }

    //try {
    //conn = await getConnection();
    // await conn.connect();
    if (selectedJenis.value > -1) {
      sql = addWhere(sql, " idkategori = ${selectedJenis.value} ");
    }
    if (isSearching.value && searchController.text.isNotEmpty) {
      sql = addWhere(sql, createWhere(searchController.text, ['b.kode', 'b.nama', 'b.merk']));
    }
    sql += " ORDER BY nama LIMIT $pageSize OFFSET $pageKey";
    final results = await executeSql(sql);
    final List<BARANG> items = results.map((row) {
      return BARANG.fromMap(row);
    }).toList();

    return items; /* 
    final isLastPage = items.length < pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(items);
    } else {
      final nextPageKey = pageKey + items.length;
      pagingController.appendPage(items, nextPageKey);
    }

    update();
    /* } catch (error) {
      dp(sql);
      dp(error.toString());

       pagingController.error = error;
    }*/ */
  }

  setPengaturan() {
    dp('setpengaturan');

    harga.value = defharga.kode ?? 'JUAL2';
    idlokasi.value = deflokasi.id ?? 1;
    semuastok.value = stokPenjualan;
    trigger++;
    pagingController.refresh();
    update();
  }

  kategoriChange(int i) {
    if (i == -6) {
      kategoriCap.value = "Semua Kategori";
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

  Future<DETAIL?> tambah(BARANG data) async {
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
      if ((data.stok ?? 0) <= newdata.proses) _lanjut = await konfirmasi("Stok tidak mencukup!!\nStok: ${formatangka(data.stok)}\nPesanan: ${formatangka(newdata.proses)}") ?? false;
      if (_lanjut == true) {
        await simpan(newdata);
        if (pesanan.value.detail == null) pesanan.value.detail = [];
        pesanan.value.detail!.add(newdata);
        await hitung();
        trigger++;
        update();
        return newdata;
      } else {
        return null;
      }
    } else {
      if ((data.stok ?? 0) <= x.proses) _lanjut = _lanjut = await konfirmasi("Stok tidak mencukup!!\nStok: ${formatangka(data.stok)}\nPesanan: ${formatangka(x.proses + 1)}") ?? false;
      if (_lanjut) {
        x.proses = (double.tryParse(x.proses.toString()) ?? 0) + 1;
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

  hitung() async {
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

  simpan(DETAIL d) async {}
}
