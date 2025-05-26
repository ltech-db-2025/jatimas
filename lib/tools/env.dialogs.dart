part of 'env.dart';

scn(String s) => Get.snackbar('Pemberitahuan', s);
Widget showLoading3() => const ColorLoader3(radius: 10, dotRadius: 5);
Widget showloading({Function()? onPressed}) {
  return Material(
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ColorLoader3(radius: 20, dotRadius: 5),
          const SizedBox(height: 5),
          // Obx(() =>
          Text(
            " dbc.prosesText.value",
            style: const TextStyle(color: Colors.black),
            //   )
          ),
          (onPressed != null)
              ? SizedBox(
                  height: 20,
                  child: ElevatedButton(onPressed: onPressed, child: const Text("batal")),
                )
              : Container(),
        ],
      ),
    ),
  );
}

doError(String kesalahan) {
  // pesanError1(kesalahan);
  dp('kesalahan : $kesalahan');
}

Future<ScanResult?> scanBarcode() async {
  try {
    return await BarcodeScanner.scan(
      options: const ScanOptions(strings: {'cancel': 'Batal'}),
    );
  } on PlatformException catch (e) {
    return ScanResult(
      type: ResultType.Error,
      rawContent: e.code == BarcodeScanner.cameraAccessDenied ? 'The user did not grant the camera permission!' : 'Unknown error: $e',
    );
  }
}

sliverBodyLoading() => SliverFillRemaining(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        showLoading3(),
        Obx(() => Text("dbc.prosesText.value")),
      ],
    )));
sliverBodyKosong() => const SliverFillRemaining(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Tidak Ada Data')],
    )));
sliverLoading() => const SliverAppBar(
      title: LinearProgressIndicator(),
      automaticallyImplyLeading: false,
      elevation: 0,
      pinned: true,
      primary: false,
      toolbarHeight: 5,
    );
Widget showloading2({Function()? onPressed}) {
  return Material(
      child: Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: contentBox(onPressed: onPressed),
    ),
  ));
}

showErrorDlg(String? isi, [String judul = 'Kesalahan']) {
  dp('dlgError: $isi');
  Get.defaultDialog(
    titleStyle: const TextStyle(color: Colors.red),
    //backgroundColor: Colors.red.withValues(alpha:.5),
    title: judul,
    middleText: isi ?? '',
    textConfirm: 'Tutup',
    onConfirm: () => Get.back(),
  );
}

contentBox({String title = 'Sedang Proses...', Function()? onPressed}) {
  const wt = Colors.black;
  const bt = Colors.white;
  return Stack(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.only(left: 20, top: 45 + 20, right: 20, bottom: 20),
        margin: const EdgeInsets.only(top: 45),
        decoration: BoxDecoration(shape: BoxShape.rectangle, color: Colors.transparent, borderRadius: BorderRadius.circular(20), boxShadow: const [
          //BoxShadow(color: Colors.yellow, offset: Offset(0, 10), blurRadius: 10),
        ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: wt)),
            const SizedBox(height: 15),
            Obx(() => Text("dbc.inProses.value", style: const TextStyle(fontSize: 14, color: wt), textAlign: TextAlign.center)),
            const SizedBox(height: 22),
            (onPressed == null) ? Container() : Align(alignment: Alignment.bottomRight, child: ElevatedButton(onPressed: () => Get.back(), child: const Text("Tutup", style: TextStyle(fontSize: 18, color: bt)))),
          ],
        ),
      ),
      const Positioned(
        left: 20,
        right: 20,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 45,
          child: ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(45), topLeft: Radius.circular(45)), child: ColorLoader3(radius: 20, dotRadius: 5)), //Image.asset('assets/l1.png')),
        ),
      ),
    ],
  );
}

Widget showloadingblank() {
  return Material(
    child: Center(
      child: Image.asset('assets/LJM.png', width: Get.width - 60),
    ),
  );
}

void pesanError0(String pesan) {
  dp(pesan);
  Get.defaultDialog(
    barrierDismissible: false,
    titleStyle: TextStyle(color: Colors.red[600]),
    title: 'Kesalahan',
    content: Text(pesan, style: const TextStyle(color: Colors.red)),
    actions: <Widget>[
      ElevatedButton(
        child: const Text('Ok', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Get.back();
        },
      )
    ],
  );
}

Duration messageDuration = const Duration(seconds: 0);
Duration durasiPesan = const Duration(seconds: 5);
bool dialogMessageOpened = false;
String dialogMessageText = '';

void pesanError1(String pesan, {Duration durasi = const Duration(seconds: 5)}) {
  messageDuration = const Duration(seconds: 0);
  durasiPesan = durasi;
  dialogMessageText = pesan;
  if (!dialogMessageOpened) {
    Get.dialog(
      const CustomDialogBox(title: "Kesalahan"),
      barrierDismissible: true,
    );
  }
}

ThemeData tema = temaawal;

pesanSukses1(dynamic pesan, {SnackPosition snackPosition = SnackPosition.BOTTOM}) {
  if (Platform.isAndroid) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'pemberitahuan',
      pesan,
      backgroundColor: Colors.orange[100]!.withValues(alpha: 0.0),
      snackPosition: snackPosition,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
      isDismissible: true,
    );
  } else {
    pesanSukses2(pesan);
  }
}

void pesanSukses2(String? pesan) {
  Get.defaultDialog(
    titlePadding: EdgeInsets.zero,
    backgroundColor: Colors.white,
    title: 'Pemberitahuan',
    content: Text(pesan ?? ''),
    actions: <Widget>[
      TextButton(
        child: const Text('Ok'),
        onPressed: () {
          Get.back();
        },
      )
    ],
  );
}

String _pesanText = '';
bool _pesan = false;
Color _warnaPesan = Colors.white.withValues(alpha: .8);
Color _warnaPesanText = Colors.black;
Duration _duration = const Duration(seconds: 0);
void pesanSukses(String pesan, {Duration durasi = const Duration(seconds: 5)}) {
  _warnaPesan = Colors.white.withValues(alpha: .8);
  _warnaPesanText = Colors.black;
  _pesanText = pesan;
  if (_pesan == true) {
    _duration = const Duration(seconds: 0);
    return;
  } else {
    _duration = const Duration(seconds: 0);
    Function? sheetSetState;
    dp("pesansukes");
    void addTime() {
      if (sheetSetState == null) return;
      sheetSetState!(() {
        final seconds = _duration.inSeconds + 1;
        _duration = Duration(seconds: seconds);
        if (_duration == durasi) Get.back();
      });
    }

    Timer timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    _pesan = true;
    showModalBottomSheet<void>(
        isScrollControlled: true,
        elevation: 0,
        barrierColor: Colors.black.withAlpha(1),
        backgroundColor: Colors.transparent,
        context: Get.context!,
        builder: (BuildContext context) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  sheetSetState = setState;
                  return SizedBox(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          //side: BorderSide(color: Colors.red, width: 5),
                        ),
                        color: _warnaPesan,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton(
                                  child: Text('Tutup ${durasi.inSeconds - _duration.inSeconds}'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    _pesanText,
                                    style: TextStyle(color: _warnaPesanText),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ));
        }).then((value) {
      _pesan = false;
      timer.cancel();
    });
  }
}

void pesanError(String pesan, {Duration durasi = const Duration(seconds: 10)}) {
  dp(pesan);
  Function? sheetSetState;
  void addTime() {
    if (sheetSetState == null) return;

    sheetSetState!(() {
      final seconds = _duration.inSeconds + 1;
      _duration = Duration(seconds: seconds);
      if (_duration == durasi) Get.back();
    });
  }

  _warnaPesanText = Colors.white;
  _warnaPesan = Colors.redAccent[700]!.withValues(alpha: 0.8);
  _pesanText = pesan;
  if (_pesan == true) {
    _duration = const Duration(seconds: 0);
    return;
  } else {
    _duration = const Duration(seconds: 0);

    Timer timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    _pesan = true;
    showModalBottomSheet<void>(
        elevation: 0,
        barrierColor: Colors.black.withAlpha(1),
        backgroundColor: Colors.transparent,
        context: Get.context!,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              sheetSetState = setState;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    //side: BorderSide(color: Colors.red, width: 5),
                  ),
                  color: _warnaPesan,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            child: Text("Tutup ${((durasi.inSeconds - _duration.inSeconds) > 60) ? '' : durasi.inSeconds - _duration.inSeconds}"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 40),
                          child: Text(
                            _pesanText,
                            style: TextStyle(color: _warnaPesanText),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).then((value) {
      _pesan = false;
      timer.cancel();
    });
  }
}

Future<bool?> konfirmasi(String pertanyaan) {
  return Get.dialog(AlertDialog(
    title: const Text('Konfirmasi'),
    content: Text(pertanyaan),
    actions: <Widget>[
      Row(
        children: <Widget>[
          TextButton(
            child: Text("Batal", style: Theme.of(Get.context!).textTheme.bodyLarge),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(onPressed: () => Get.back(result: true), child: Text("OK", style: Theme.of(Get.context!).textTheme.bodyLarge))
        ],
      ),
    ],
  ));
}

Future<bool?> konfirmasi2(String pertanyaan) {
  return Get.dialog(AlertDialog(
    title: const Text('Konfirmasi'),
    content: Text(pertanyaan),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            child: Text("Batal", style: Theme.of(Get.context!).textTheme.bodyLarge),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(onPressed: () => Get.back(result: true), child: Text("OK", style: Theme.of(Get.context!).textTheme.bodyLarge))
        ],
      ),
    ],
  ));
}

Future<bool?> Informasi(String informasi) {
  return Get.dialog(AlertDialog(
    title: const Text('Informasi'),
    content: Text(informasi),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            child: Text("Kembali", style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: Colors.black)),
            onPressed: () => Get.back(result: false),
          ),
        ],
      ),
    ],
  ));
}

Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('LJM'),
          content: const Text('Yakin keluar aplikasi?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Tidak'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Iya'),
            ),
          ],
        ),
      ) ??
      false; //if showDialouge had returned null, then return false
}
