import 'package:get/get.dart';

class DBGudangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DBGudangController());
  }
}

class DBGudangController extends GetxController {
  var isLoading = true.obs;
  var isLoadingBackground = false.obs;
  var lastnobukti = 0.obs;

  @override
  onInit() {
   /*  getNotifController();
    listenMessage();
    Barang.setLokasi(getidLokasi());

    _initFirst();

    initPenjualan();
    initPermintaan();
 */
    super.onInit();
  }


}
