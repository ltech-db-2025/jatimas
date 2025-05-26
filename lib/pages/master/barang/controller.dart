import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/provider/models/harga.dart';
import 'package:ljm/provider/models/kategori.dart';
import 'package:ljm/provider/models/lokasi.dart';
import 'package:ljm/tools/env.dart';

BarangController getBarangController() {
  if (Get.isRegistered<BarangController>()) {
    return Get.find<BarangController>();
  } else {
    return Get.put(BarangController());
  }
}

class BarangController extends GetxController {
  BarangController();
  var scrollController = ScrollController().obs;
  final searchController = TextEditingController();
  var isSearching = false.obs;
  var pageSize = 10;
  late final PagingController<int, BARANG> pagingController = PagingController<int, BARANG>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);
  var harga = 'JUAL2'.obs;
  var idlokasi = 1.obs;
  var semuastok = false.obs;
  RxInt selectedJenis = (-6).obs;
  var trigger = 0.obs;
  var kategoriCap = "Semua".obs;
  var brgKategori = <BARANGKATEGORI>[].obs;
  var listlokasi = <LOKASI>[];
  var listharga = <HARGA>[];
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
    initFirst();
  }

  initFirst() async {
    // loading.value = true;
    final results = await executeSql('select * from brgkategori order by kategori');

    brgKategori.value = results.map((row) {
      return BARANGKATEGORI.fromMap(row);
    }).toList();

    final reslokasi = await executeSql("select * from lokasi where aktif = 1");
    if (reslokasi.isNotEmpty) {
      listlokasi = reslokasi.map((row) {
        return LOKASI.fromMap(row);
      }).toList();
      deflokasi = listlokasi.firstWhere((e) => e.id == user.idlokasi, orElse: () => LOKASI(id: 1, kode: 'GD-A1', nama: 'GUDANG'));
    }
    final resharga = await executeSql("select * from harga where publik = 1");
    if (resharga.isNotEmpty) {
      //if (!Platform.isWindows) {}
      listharga = resharga.map((row) {
        return HARGA.fromMap(row);
      }).toList();
    }

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
      if (sql.contains('where')) {
        sql += " AND ";
      } else {
        sql += " where ";
      }
      sql += " idkategori = ${selectedJenis.value} ";
    }
    if (isSearching.value && searchController.text.isNotEmpty) {
      if (sql.contains('where')) {
        sql += " AND ";
      } else {
        sql += " where ";
      }

      sql += createWhere(searchController.text, ['b.kode', 'b.nama', 'b.merk']);
    }
    sql += " ORDER BY nama LIMIT $pageSize OFFSET $pageKey";
    final results = await executeSql(sql);
    final List<BARANG> items = results.map((row) {
      return BARANG.fromMap(row);
    }).toList();
    return items;
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
}
