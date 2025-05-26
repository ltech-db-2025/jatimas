import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/barangjenis.dart';
import 'package:ljm/tools/env.dart';

BrgJenisController getJensiBarangController() {
  if (Get.isRegistered<BrgJenisController>()) {
    return Get.find<BrgJenisController>();
  } else {
    return Get.put(BrgJenisController());
  }
}

class BrgJenisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BrgJenisController());
  }
}

class BrgJenisController extends GetxController {
  final searchController = TextEditingController();
  var isSearching = false.obs;
  var loading = false.obs;
  var pageSize = 10;
  late final pagingController = PagingController<int, BARANGJENIS>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);

  Future<List<BARANGJENIS>> fetchPage(int pageKey) async {
    var sql = "select * from brgjenis";

    if (isSearching.value && searchController.text.isNotEmpty) {
      if (sql.contains('where')) {
        sql += " AND ";
      } else {
        sql += " where ";
      }

      sql += createWhere(searchController.text, ['jenis', 'deskripsi']);
    }
    sql += " ORDER BY jenis LIMIT $pageSize OFFSET $pageKey";
    final results = await executeSql(sql);
    final List<BARANGJENIS> items = results.map((row) {
      return BARANGJENIS.fromMap(row);
    }).toList();
    return items;
  }

  setLoading([value = true]) {
    loading.value = value;
    update();
  }

  updateBrgJenis(BARANGJENIS value) async {
    if (pagingController.items == null) return null;
    pagingController.items!.indexWhere((element) => element.id == value.id);
    var res = await value.simpan();
    if (res != null) {
      pagingController.refresh();
      update();
      return res;
    }
    return null;
  }

  Future<bool> hapus(BARANGJENIS value) async {
    if (pagingController.items == null) return false;
    var i = pagingController.items!.indexWhere((element) => element.id == value.id);
    var res = await hapusData(value.toJson(), '/barang/jenis/delete');
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
