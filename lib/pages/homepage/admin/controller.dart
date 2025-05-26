import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ljm/widgets/charts.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/dashboard/chart.dart';
import 'package:ljm/provider/models/dashboard/dash_b.dart';
import 'package:ljm/provider/models/dashboard/omset.dart';
import 'package:ljm/provider/models/dashboard/top.dart';
import 'package:ljm/tools/env.dart';

class DBAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => DBAdminController());
  }
}

class DBAdminController extends GetxController {
  var isProses = true.obs;
  var isProsesDashboard = false.obs;
  var isLoading = false.obs;
  var isLoadingBackground = false.obs;
  var ddashb = DashB().obs;
  var domsetchart = Chart().obs;
  var dlistTop10 = <Top10>[].obs;
  var dtop10customer = <Top10>[].obs;
  var dtop10item = <Top10>[].obs;
  var dtop10kabupaten = <Top10>[].obs;
  var dtop10Sales = <Top10>[].obs;
  var trigger = 0.obs;
  var dechart = <XBarData2>[].obs;
  Rx<int> tgIndex = (-1).obs;
  var statusx = 'kh'.obs();

  @override
  void onInit() {
    isLoading.value = true;
    statusx = 'memulai';
    /*
    listenMessage();
    getNotifController();
    Barang.setLokasi(getidLokasi());

    _initFirst();
    initPenjualan();
    initPermintaan(); */
    getData();
    super.onInit();
  }

  settouchedGroupIndex(int val) {
    tgIndex.value = val;
    update();
  }

  initData() async {
    _updateIsLoading(false);
  }

  List<XBarData2> getchart() {
    var dx = <XBarData2>[];
    for (var y in domsetchart.value.omset) {
      double pelunasan = 0;
      double tempo = 0;
      if (kIsWeb) {
        pelunasan = domsetchart.value.pelunasan
            .firstWhere((e) => e.tahun == y.tahun && e.bulan == y.bulan,
                orElse: () => Omset(tahun: y.tahun, bulan: y.bulan, total: 0))
            .total;
        tempo = domsetchart.value.tempo
            .firstWhere((e) => e.tahun == y.tahun && e.bulan == y.bulan,
                orElse: () => Omset(tahun: y.tahun, bulan: y.bulan, total: 0))
            .total;
      } else {
        pelunasan = domsetchart.value.pelunasan
            .firstWhere((e) => e.tahun == y.tahun && e.bulan == y.bulan,
                orElse: () => Omset(tahun: y.tahun, bulan: y.bulan, total: 0))
            .total;
        tempo = domsetchart.value.tempo
            .firstWhere((e) => e.tahun == y.tahun && e.bulan == y.bulan,
                orElse: () => Omset(tahun: y.tahun, bulan: y.bulan, total: 0))
            .total;
      }

      dx.add(XBarData2(y.bulan, y.total, pelunasan, tempo));
    }
    return dx;
  }

  Future<void> getData([bool withloading = false]) async {
    _dashboardLoading();

    trigger++;
    if (withloading) _dashboardLoading(true);
    setProses('download data dashboard');
    var res = await executeSql('select * from periodicglobal');
    var alldata = res.map((e) => Omset.fromMap(e)).toList();
    domsetchart.value.omset = alldata.where((e) => e.tipe == 1).toList();
    domsetchart.value.pelunasan = alldata.where((e) => e.tipe == 2).toList();
    domsetchart.value.tempo = alldata.where((e) => e.tipe == 3).toList();

    var resdata = await executeSql3('call omsetglobal');
    if (resdata.isNotEmpty) {
      ddashb.value = DashB.fromMap(resdata.first);
    } else {
      ddashb.value = DashB();
    }

    var restop10 = await executeSql3('call top10_global');
    var allTop10 = restop10.map((e) => Top10.fromMap(e)).toList();
    dtop10customer.value = allTop10.where((e) => e.tipe == 2).toList();
    dtop10item.value = allTop10.where((e) => e.tipe == 1).toList();
    dtop10kabupaten.value = allTop10.where((e) => e.tipe == 3).toList();
    dtop10Sales.value = allTop10.where((e) => e.tipe == 4).toList();
    setProses('inisialisasi dashboard selesai');
    dechart.value = getchart();
    if (withloading || isLoading.value || isProses.value)
      _updateIsLoading(false);
    trigger++;
    statusx = "ok";
    _dashboardLoading(false);
  }

  void _updateIsLoading(bool currentStatus) {
    isProses.value = currentStatus;
    update();
  }

  _dashboardLoading([bool sts = true]) {
    isProsesDashboard.value = sts;
    update();
  }
}
