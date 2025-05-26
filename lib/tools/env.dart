// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ljm/env/env.dart';
import 'package:ljm/provider/models/user.dart';
import 'package:ljm/provider/const/theme.dart';
import 'package:ljm/provider/models/harga.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/lokasi.dart';
import 'package:ljm/provider/socket_controller.dart';
import 'package:ljm/tools/expect.dart';
import 'package:ljm/widgets/loaders/color_loader_3.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'komponen/dialogs.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
part 'env.repo.dart';
part 'env.dialogs.dart';
part 'env.functions.dart';
part 'env.screen.dart';
part 'env.theme.dart';
part 'env.widgets.dart';
part 'env.api.dart';
part 'env.configuration.dart';

int xi = 0;
bool isFirst = true;
//bool weslogin = false;
// late Login2Controller cLogin;
var repo = Get.put(RepoController());
const TextStyle bkgText = TextStyle(color: Colors.yellow, fontSize: 12);
const TextStyle jumlahStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue);
//---------------------------------------------------

// -------------------------------------------------------------
enum TtsState { playing, stopped, paused, continued }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

late SharedPreferences prefs;
bool autosend = false;
KONTAK? salesAktif;
User user = User();
LOKASI deflokasi = LOKASI(id: 1, kode: 'GD-A1', nama: 'GUDANG');
HARGA defharga = HARGA(kode: 'JUAL2', nama: 'Partai', publik: 1);
int lastLokasiStok = -1;
String defaultLanguage = "in-ID";
Directory? directory;
int iddevisi = 2;

int indexaktifcart = 0;
int indexaktifpiutang = 0;
bool isLoading = true;
bool isOnline = false;

bool isProgramer = true;
bool isUsers = false;
String il = 'IDLOKASI';
String ip = 'IDPEGAWAI';
String jHargaStok = 'JUAL2';

String judul = '';

String kesalahan = '';

String koneksi = 'Tidak diketahui';

enum TipeOperator { none, sales, gudang, admin, direksi, customer, umum }

getTipeOperator() {
  return TipeOperator.values[user.tipe];
}

bool iAdmin() => (getTipeOperator() == TipeOperator.admin || getTipeOperator() == TipeOperator.direksi);
bool iDireksi() => (getTipeOperator() == TipeOperator.direksi);
bool iSales() => (getTipeOperator() == TipeOperator.sales);
bool iGudang() => (getTipeOperator() == TipeOperator.gudang);

bool cekUser([bool errorcek = true]) {
  return true;
}

String getUserName() {
  if (cekUser()) {
    if (user.nama == null) {
      doError("Gagal mendapatkan infromasi user");
      return '';
    }
    return user.nama ?? '';
  }
  return '';
}

bool cekEmail() {
  if (cekUser()) {
    if (user.email == null) {
      doError("Gagal mendapatkan infromasi email");
      return false;
    }
    return true;
  }
  return false;
}

String getEmail() => (cekEmail()) ? user.email ?? '' : '';

bool cekKontak() {
  if (cekUser()) {
    if (user.idkontak == null) {
      return false;
    }
    return true;
  }
  return false;
}

int getidKontak() => (cekKontak()) ? user.idkontak ?? 0 : 0;

bool cekLokasi([bool errorcek = true]) {
  if (cekUser(errorcek)) {
    if (user.idlokasi == null) {
      return false;
    }
    return true;
  }
  return false;
}

bool cekAksesLokasi() {
  if (cekUser()) {
    if (user.akseslokasi == null) {
      return false;
    }
    if (user.akseslokasi == []) return false;
    return true;
  }
  return false;
}

class Debouncer {
  Debouncer({required this.milliseconds});
  final int milliseconds;
  Timer? _timer;
  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

bool cekAksesKas() {
  if (cekUser()) {
    if (user.akseskas == null) {
      return false;
    }
    return true;
  }
  return false;
}

int getidLokasi([bool errorcek = true]) => (cekLokasi(errorcek)) ? user.idlokasi ?? 0 : 0;
int gettipe() => (cekUser()) ? user.tipe : 0;

final ValueNotifier<int> listennotif = ValueNotifier<int>(0);
ValueNotifier<int> listenPermintaan = ValueNotifier<int>(0);
int messageCount = 0;
double nilaiomset = 0;
double nKas = 0;
double nPelunasan = 0;
double nTop = 0;
/* Operator opr = Operator();
Operator opr0 = Operator(); */
String pathData = '';
String pathExtData = '';
String pathTemp = '';
KONTAK? pegawai;
String pesan = '';
//-------------------------------------------------------
String prosestxt = '';
bool qtyautofocus = true;
int tabtrabsaksiindex = 0;

setProses([String? s]) {
  s ??= prosestxt;
}

class Periode {
  DateTime? awal;
  DateTime? akhir;
  Periode({this.awal, this.akhir});
}

Periode periodePenjualan = Periode(awal: DateTime.now(), akhir: DateTime.now());
String? token = '';

// body: {"idtrans":, "idbarang":, "proses":}
// String opr.nama = '';
// List<Lokasi> userLokasi = [];

Future<String> createFolder(String cow) async {
  // final folderName = cow;
  //final path = Directory("storage/emulated/0/$folderName");
  final path = Directory(cow);
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await path.exists())) {
    return path.path;
  } else {
    path.create();
    return path.path;
  }
}

// ----------------------------------------------------

// ----------------------------------------------------------------
String getHarga(String x, data) {
  switch (x) {
    case 'JUAL1':
      return formatangka(data.jual1);
    case 'JUAL2':
      return formatangka(data.jual2);
    case 'JUAL3':
      return formatangka(data.jual3);
    case 'JUAL4':
      return formatangka(data.jual4);
    case 'JUAL5':
      return formatangka(data.jual5);
    default:
      return formatangka(data.jual2);
  }
}

String getHargaLabel(String? x) {
  String res = x ?? 'JUAL2';
  // var h = dbc.mHarga.firstWhereOrNull((element) => element.kode == x);
  // if (h != null) res = h.nama ?? res;
  return res;
}

// ----------------------------------------------------------

TextStyle warnatempo(tgl) {
  if (DateTime.tryParse(tgl.toString()) == null) {
    return const TextStyle(color: Colors.blue);
  } else {
    return DateTime.now().isAfter(DateTime.tryParse(tgl)!) ? const TextStyle(color: Colors.red) : const TextStyle(color: Colors.black);
  }
}

// ---------------------------------------------------------------------------------
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final dynamic tabBar;

  SliverAppBarDelegate(this.tabBar);

  @override
  double get maxExtent => 50; //_tabBar.preferredSize.height;
  @override
  double get minExtent => 50; //_tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(child: tabBar);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
