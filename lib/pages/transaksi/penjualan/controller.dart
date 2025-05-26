import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/pages/homepage/sales/controller.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/provider/models/transaksi/sumpenjualan.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

import 'baru/listbarangbarangcontroller.dart';

PenjualanController getPenjualanController() {
  if (Get.isRegistered<PenjualanController>()) {
    return Get.find<PenjualanController>();
  } else {
    return Get.put(PenjualanController());
  }
}

class PenjualanController extends GetxController {
  PenjualanController();
  var sales = <KONTAK>[].obs;
  var rekap = SumPenjualan().obs;

  var sqlpenjualanHarian = ''.obs;
  late final pagingController = PagingController<int, dynamic>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);
  late final pagingDraftController = PagingController<int, dynamic>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPageDraft);

  var ready = false.obs;
  final _searchController = TextEditingController();
  var pageSize = 10;
  var jmldraft = 0.0.obs;
  onInit() {
    super.onInit();
    initDataSales();
    initRekapData();
  }

  Future<List<dynamic>> fetchPage(int pageKey) async {
    var sql = sqlpenjualanHarian.value;

    if (_searchController.text.isNotEmpty) {
      sql = addWhere(sql, createWhere(_searchController.text, ['notrans', 'kontak', 'namakontak']));
    }

    sql += " LIMIT $pageSize OFFSET $pageKey";

    final newItems = await executeSql(sql);
    return newItems;
  }

  Future<List<dynamic>> fetchPageDraft(int pageKey) async {
    var sql = """
      select t.* 
      from transaksi_draft t 
      where coalesce(status,0) = 0
    """;
    if (salesAktif != null) {
      sql += " and idpegawai = ${salesAktif!.id}";
    }

    sql += " LIMIT $pageSize OFFSET $pageKey";

    final newItems = await executeSql(sql);
    return newItems;
  }

  initRekapData() async {
    ready.value = false;
    update();
    var idpegawai = (salesAktif == null) ? '' : "and idpegawai = ${salesAktif!.id ?? '0'}";
    String sql = """
      SELECT 
        COUNT(id) AS nota,
        COUNT(CASE WHEN tempo <= CURRENT_DATE THEN id END) AS notatempo,
        SUM(saldo) AS piutang,
        SUM(CASE WHEN tempo < CURRENT_DATE THEN saldo END) AS jtempo,
        COUNT(DISTINCT CASE WHEN tempo < CURRENT_DATE THEN idkontak END) AS jmlpelangganjt,
        COUNT(DISTINCT idkontak) AS jmlpelanggan
      FROM transaksi 
      WHERE saldo > 0 and kdtrans = 'PJ' $idpegawai
    """;
    var result = await executeSql(sql);
    if (result.isNotEmpty) {
      rekap.value = SumPenjualan.fromMap(result.first);
      sqlpenjualanHarian.value = """
      select cast(tanggal as date) tanggal, sum(kredit) kredit, count(*) qty, sum(nilaitotal) nilaitotal, sum(saldo) saldo
      from transaksi 
      where kdtrans = 'PJ' $idpegawai 
      group by date(tanggal) 
      order by tanggal desc
    """;
      ready.value = true;
      update();
    } else {
      // Get.back();
    }
  }

  initDataSales() async {
    String sql = "select * from kontak where p = 1 and aktif = 1 and jabatan = 'SALES' ";
    var result = await executeSql(sql);
    if (result.isEmpty) return;
    sales.value = result.map((e) => KONTAK.fromMap(e)).toList();
    initRekapData();
  }

  Future<bool> deleteDraft(TRANSAKSI data) async {
    try {
      await executeSql('delete from t_draft where id = ${data.id}');
      return true;
    } catch (e) {
      showErrorDlg(e.toString());
      return false;
    }
  }

  Future<TRANSAKSI?> simpanNewDraft(TRANSAKSI newTrans) async {
    try {
      TRANSAKSI? newres = await draftBaru();
      if (newres != null) {
        newTrans.id = newres.id;
        newTrans.nobukti = newres.nobukti;
        newTrans.notrans = newres.notrans;
        for (var i = 0; i < newTrans.detail!.length; i++) {
          newTrans.detail![i] = newTrans.detail![i].copyWith(idtrans: newTrans.id);
        }
        await updateDraft(newTrans);

        var sql2 = DETAIL.generateInsertSQL(newTrans.detail!);
        await executeSql(sql2);

        cBarang(TRANSAKSI(id: -1)).pesanan.value = getSalesController().resetTransaksi();
        cBarang(TRANSAKSI(id: -1)).pagingController.refresh();
        return newTrans;
      } else {
        pesanError('Draft Gagal diBuat');
      }
    } catch (e, stackTrace) {
      dp("error (simpanNewDraft) : $e");
      dp("stackTrace (simpanNewDraft) : $stackTrace");
      return null;
    }
    return null;
  }

  Future<TRANSAKSI?> updateDraft(TRANSAKSI newTrans) async {
    var sql = newTrans.updateDraftSql();
    try {
      await executeSql(sql);
      //  getPenjualanController().pagingDraftController.refresh();
      getPenjualanController().update();
      return newTrans;
    } catch (e, stackTrace) {
      dp("error (updateDraft) : $e");
      dp("stackTrace (updateDraft) : $stackTrace");
      return null;
    }
  }

  Future<TRANSAKSI?> simpanDrafttoNota(TRANSAKSI newTrans) async {
    try {
      if (newTrans.id != null) {
        var res = await draftToTrans(newTrans.id!);
        if (res != null) {
          newTrans = res.copyWith(datakontak: newTrans.datakontak);
          pagingController.refresh();
          pagingDraftController.refresh();
          await initRekapData();
          return newTrans;
        }
      } else {
        pesanError('ID transaksi tidak dikenal');
      }
      return null;
    } catch (e, stackTrace) {
      dp("error (simpanDrafttoNota) :\n $e");
      dp("stackTrace (simpanDrafttoNota) :\n $stackTrace");
      pesanError('Kesalana Penyimpanan Draft');
      return null;
    }
  }
}
