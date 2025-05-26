import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/kategori.dart';
import 'package:ljm/tools/env.dart';

BrgKategoriController getKategoriBarangController() {
  if (Get.isRegistered<BrgKategoriController>()) {
    return Get.find<BrgKategoriController>();
  } else {
    return Get.put(BrgKategoriController());
  }
}

class BrgKategoriController extends GetxController {
  final searchController = TextEditingController();
  var isSearching = false.obs;
  var data = BARANGKATEGORI().obs;
  var loading = false.obs;
  var pageSize = 10;
  late final pagingController = PagingController<int, BARANGKATEGORI>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);
  @override
  onInit() {
    super.onInit();
  }

  Future<List<BARANGKATEGORI>> fetchPage(int pageKey) async {
    var sql = "select * from brgkategori";

    if (isSearching.value && searchController.text.isNotEmpty) {
      if (sql.contains('where')) {
        sql += " AND ";
      } else {
        sql += " where ";
      }

      sql += createWhere(searchController.text, ['kategori', 'deskripsi']);
    }
    sql += " ORDER BY kategori LIMIT $pageSize OFFSET $pageKey";
    final results = await executeSql(sql);
    final List<BARANGKATEGORI> items = results.map((row) {
      return BARANGKATEGORI.fromMap(row);
    }).toList();

    return items;
  }

  setLoading([value = true]) {
    loading.value = value;
    update();
  }

  Future<BARANGKATEGORI?> updateBrgKategori(BARANGKATEGORI value) async {
    if (pagingController.items == null) return null;
    pagingController.items!.indexWhere((element) => element.id == value.id);
    var res = await value.simpan();
    if (res != null) {
      pagingController.refresh();
      update();
      return res;
    }
    dp('updateBrgKategori not ok');
    return null;
  }

  Future<bool> hapus(BARANGKATEGORI value) async {
    if (pagingController.items == null) return false;
    var i = pagingController.items!.indexWhere((element) => element.id == value.id);
    var res = await hapusData(value.toJson(), '/barang/kategori/delete');
    if (res) {
      if (i >= 0) {
        pagingController.items!.removeAt(i);
        pagingController.items!.insert(i, value);
      }
      return res;
    }
    return false;
  }
}
