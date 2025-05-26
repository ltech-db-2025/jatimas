part of 'page.dart';

void _onTapDrawer(int id) {
  switch (id) {
    case 0:
      // showpageaktifcart(context);
      break;
    case 2:
      judul = 'Dashboard';
      break;
    case 3:
      Get.toNamed('/barang');

      break;
    case 4:
      Get.toNamed("/kontak");
      break;
    case 7: // pelunasan
      Get.toNamed("/blank");
      break;
    case 8:
      Get.toNamed("/setting");
      break;
    case 16:
      Get.toNamed("/penjualan");
      break;

    case 10:
      // showpagecoba(context);
      Get.toNamed("/piutang");

      break;
    case 12:
      Get.toNamed("/blank");
      break;
    case 13:
      // Get.toNamed("/orderbaru");
      Get.toNamed('/penjualan');
      break;
    case 14:
      Get.toNamed("/permintaanmutasi");
      //showpagemutasi(context);
      break;
    case 15: // mutaso
      Get.toNamed("/mutasi");
      break;
    case 110: // mutaso
      // showpagemutasibaru(context);
      Get.toNamed("/kas");
      break;
    default:
      Get.toNamed("/blank");
      break;
    /* setState(() {
          _showpage = _pageChooser(id);
        }); */
  }
}

void _menuGridClick(int id) async {
  switch (id) {
    case 0:
      Get.toNamed("/barang");
      break;
    case 1:
      Get.toNamed("/kontak");
      break;
    case 2:
      Get.toNamed("/lokasi");
      break;
    case 3:
      Get.toNamed("/permintaanmutasi");
      break;
    case 4:
      repo.setsocketConnected(!repo.socketconnected.value);
      dp("repo.socketConnected: ${repo.socketconnected.value})");
      dp("repo.setsocketConnected(${!repo.socketconnected.value})");

      break;

    default:
      Get.toNamed("/blank");
      break;
  }
}
