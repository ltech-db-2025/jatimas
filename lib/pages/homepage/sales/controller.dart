import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ljm/main/controller/notif_controller.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/dashboard/chart.dart';
import 'package:ljm/provider/models/dashboard/dash_b.dart';
import 'package:ljm/provider/models/dashboard/omset.dart';
import 'package:ljm/provider/models/dashboard/top.dart';
import 'package:ljm/provider/models/keuangan/rekening.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';
// import 'package:ljm/tools/env.tts.dark';
import 'package:ljm/widgets/charts.dart';

class DBSalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DBSalesController());
  }
}

DBSalesController getSalesController() {
  if (Get.isRegistered<DBSalesController>()) return Get.find<DBSalesController>();
  return Get.put(DBSalesController());
}

class DBSalesController extends GetxController {
  var isProses = false.obs;
  var ddashb = DashB().obs;
  var domsetchart = Chart().obs;
  var dlistTop10 = <Top10>[].obs;
  var dtop10customer = <Top10>[].obs;
  var dtop10item = <Top10>[].obs;
  var dtop10kabupaten = <Top10>[].obs;
  var data = 'Menyiapkan';
  var activePage = 0.obs;
  var dechart = <XBarData2>[].obs;
  // var scaffoldKey = GlobalKey<ScaffoldState>();
  // var listBarangDatang = <BarangDatang>[].obs;
  var saldokas = <REKENING>[].obs;
  var loadingBarangBaru = false.obs;
  var loadingTop10 = false.obs;
  var isLoadingBackground = false.obs;
  var isProsesDashboard = false.obs;
  var isLoading = false.obs;
  var transaksi = TRANSAKSI(
    id: -1,
    idpegawai: user.idkontak,
    pegawai: user.kontak?.nama,
    tanggal: DateTime.now().toString(),
    idlokasi: user.idlokasi,
    jharga: 'JUAL2',
    detail: <DETAIL>[],
  ).obs;
  Rx<int> tgIndex = (-1).obs;
  var trigger = 0.obs;

  void onCreate() {}
  @override
  void onInit() {
    if (user.akseskas != null) {
      if (user.akseskas!.isNotEmpty) {
        transaksi.value.rekkas = user.akseskas!.first.id;
        transaksi.value.akunkas = user.akseskas!.first.alias;
      }
    }
    isLoading.value = true;
    getNotifController();
    // listenMessage();
    _initFirst();
/*     Barang.setLokasi(getidLokasi());

   
    initPenjualan();
    initPermintaan(); */

    super.onInit();
  }

  resetTransaksi() {
    transaksi.value = TRANSAKSI(
      id: -1,
      idpegawai: user.idkontak,
      pegawai: user.kontak?.nama,
      tanggal: DateTime.now().toString(),
      idlokasi: user.idlokasi,
      jharga: 'JUAL2',
      detail: <DETAIL>[],
    );
    if (user.akseskas != null) {
      if (user.akseskas!.isNotEmpty) {
        transaksi.value.rekkas = user.akseskas!.first.id;
        transaksi.value.akunkas = user.akseskas!.first.alias;
      }
    }
    update();
    return transaksi.value;
  }

  _initFirst() async {
    isLoading.value = true;

    // if (isAndroid) tts.speak("Selamat datang bos kuuuu");
    isLoading.value = false;
    update();
    _initupdate();
  }

  _initupdate() async {
    // await refreshData();
    getData();
    isLoadingBackground.value = true;

    isLoadingBackground.value = false;
    update();
    // _updateData();
    _updateIsLoading(false);
  }

  List<XBarData2> getchart() {
    var dx = <XBarData2>[];
    for (var y in domsetchart.value.omset) {
      double pelunasan = 0;
      double tempo = 0;
      if (kIsWeb) {
        pelunasan = domsetchart.value.pelunasan.firstWhere((e) => e.tahun == y.tahun && e.bulan == y.bulan, orElse: () => Omset(tahun: y.tahun, bulan: y.bulan, total: 0)).total;
        tempo = domsetchart.value.tempo.firstWhere((e) => e.tahun == y.tahun && e.bulan == y.bulan, orElse: () => Omset(tahun: y.tahun, bulan: y.bulan, total: 0)).total;
      } else {
        pelunasan = domsetchart.value.pelunasan.firstWhere((e) => e.tahun == y.tahun && e.bulan == y.bulan, orElse: () => Omset(tahun: y.tahun, bulan: y.bulan, total: 0)).total;
        tempo = domsetchart.value.tempo.firstWhere((e) => e.tahun == y.tahun && e.bulan == y.bulan, orElse: () => Omset(tahun: y.tahun, bulan: y.bulan, total: 0)).total;
      }

      dx.add(XBarData2(y.bulan, y.total, pelunasan, tempo));
    }
    return dx;
  }

  initData() async {
    //await refreshData();
    await getData();
  }

  void _updateIsLoading(bool currentStatus) {
    isProses.value = currentStatus;
    update();
  }

  _dashboardLoading([bool sts = true]) {
    isProsesDashboard.value = sts;
    update();
  }

  Future<void> getData([bool withloading = false]) async {
    _dashboardLoading();

    trigger++;
    if (withloading) _dashboardLoading(true);
    setProses('download data dashboard');
    var sql = 'call periodicsales(${user.idkontak})';
    var res = await executeSql3(sql);
    var alldata = res.map((e) => Omset.fromMap(e)).toList();
    domsetchart.value.omset = alldata.where((e) => e.tipe == 1).toList();
    domsetchart.value.pelunasan = alldata.where((e) => e.tipe == 2).toList();
    domsetchart.value.tempo = alldata.where((e) => e.tipe == 3).toList();

    var resdata = await executeSql3('call omsetsales(${user.idkontak})');
    if (resdata.isNotEmpty) {
      ddashb.value = DashB.fromMap(resdata.first);
    } else {
      ddashb.value = DashB();
    }

    var restop10 = await executeSql3('call top10_persales(${user.idkontak})');
    var allTop10 = restop10.map((e) => Top10.fromMap(e)).toList();
    dtop10customer.value = allTop10.where((e) => e.tipe == 2).toList();
    dtop10item.value = allTop10.where((e) => e.tipe == 1).toList();
    dtop10kabupaten.value = allTop10.where((e) => e.tipe == 3).toList();
    setProses('inisialisasi dashboard selesai');
    dechart.value = getchart();
    if (withloading || isLoading.value || isProses.value) _updateIsLoading(false);
    trigger++;
    _dashboardLoading(false);
  }

  void setLoading([bool value = true]) {
    isProses.value = value;
    update();
  }

  setLoadingBarangBaru([bool value = true]) {
    loadingBarangBaru.value = value;
  }

  setLoadingtop10([bool value = true]) {
    loadingTop10.value = value;
  }
}
