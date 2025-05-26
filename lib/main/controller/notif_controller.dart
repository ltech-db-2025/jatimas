import 'dart:async';

import 'package:get/get.dart';

NotifController getNotifController() {
  if (Get.isRegistered<NotifController>()) {
    return Get.find<NotifController>();
  } else {
    Get.lazyPut(fenix: true, () => NotifController());
    return Get.find<NotifController>();
  }
}

class NotifController extends GetxController {
  final now = DateTime.now().obs;
  var jmlnotif = 0.obs;
  var notifMutasi = 0.obs;
  var notifPenjualan = 0.obs;
  @override
  void onReady() {
    super.onReady();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        now.value = DateTime.now();
      },
    );
  }

  void update2() {
   /*  jmlnotif.value = dbc.mNotifikasi.where((element) => element.status == 1).length;
    notifMutasi.value = listPermintaan.where((element) => element.status == 1 && element.data == 'nota').length;
    notifPenjualan.value = dbc.mPenjualan.where((element) => element.status == 1 && element.data == 'nota').length;
     */update();
  }
}
