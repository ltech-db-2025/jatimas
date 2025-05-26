import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

PelunasanPiutangController getPelunasanPiutangController() {
  if (Get.isRegistered<PelunasanPiutangController>()) {
    return Get.find<PelunasanPiutangController>();
  } else {
    return Get.put(PelunasanPiutangController());
  }
}

class PelunasanPiutangController extends GetxController {
  PelunasanPiutangController();
  var totalController = TextEditingController().obs;
  var alamatController = TextEditingController().obs;
  var totalpembayaranbaru = 0.0.obs;
  var sales = <KONTAK>[].obs;
  var total = 0.0.obs;
  var sqlPelunasanPiutangHarian = ''.obs;
  late final pagingController = PagingController<int, TRANSAKSI>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);
  var ready = false.obs;
  var pelunasan = TRANSAKSI().obs;
  var pageSize = 10;
  var jmldraft = 0.0.obs;
  onInit() {
    initData();
    resetTransaksi();
    super.onInit();
  }

  resetTransaksi() {
    pelunasan.value = TRANSAKSI(
      tanggal: DateTime.now().toString(),
      idpegawai: user.idkontak,
      pegawai: (user.kontak != null) ? user.kontak!.kode : null,
      rekkas: (user.akseskas != null) ? user.akseskas!.first.id : null,
      akunkas: user.akseskas?.first.rekening,
      kdtrans: 'PP',
      detailkas: [],
    );
    hitung();
  }

  initData() async {
    var res = await getUrlData('/pelunasan/piutang/sales/${user.idkontak.toString()}/total');
    if (res == null) {
      total.value = 0;
    } else {
      final List<TRANSAKSI> items = res.map((row) {
        return TRANSAKSI.fromMap(row);
      }).toList();
      total.value = items.first.nilaitotal ?? 0;
    }
    hitung();
  }

  refreshData() async {
    await initData();
    pagingController.refresh();
  }

  hitung() {
    totalpembayaranbaru.value = pelunasan.value.detailkas!.fold(0.0, (sum, d) => (sum) + (d.nilai ?? 0));
    pelunasan.value.nilaitotal = totalpembayaranbaru.value;
    pelunasan.value.nilai = pelunasan.value.nilaitotal;
    pelunasan.value.bayar = pelunasan.value.nilaitotal;
    totalController.value = TextEditingController(text: formatuang(pelunasan.value.nilaitotal));

    update();
  }

  Future<List<TRANSAKSI>> fetchPage(int pageKey) async {
    final results = await getUrlData('/pelunasan/piutang/sales/${user.idkontak.toString()}', {'j': pageSize.toString(), 'p': pageKey.toString()});
    if (results == null) {
      dp("result = $results");
      return [];
    }
    final List<TRANSAKSI> items = results.map((row) {
      return TRANSAKSI.fromMap(row);
    }).toList();
    return items;
  }
}
