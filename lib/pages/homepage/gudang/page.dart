// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/homepage/gudang/contoller.dart';
import 'package:ljm/pages/users/login2/login.dart';
import 'package:ljm/main.dart';
import 'package:ljm/provider/models/user.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/tools/notifications.dart';

class DBGudang extends GetView<DBGudangController> {
  final User auser;
  const DBGudang(this.auser, {super.key});

  @override
  Widget build(BuildContext context) {
    //var controller = Get.find<NotifController>();
    dp('Dashboard Gudang');
    setUkuranLayar(context);
    return Obx(
      () => PopScope(
        onPopInvoked: (b) => showExitPopup(context),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(skala)),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: Scaffold(
              body: CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverAppBar(
                    title: const Text("Lucky Jaya Motorindo | Gudang"),
                    actions: [
                      GestureDetector(
                        onTap: () async {
                          dp('w');
                          if (await googleSignIn.isSignedIn()) {
                            await googleSignIn.signOut();
                          }
                          dp('ww');
                          prefs.clear();
                          user = User();
                          Get.offAll(() => const wellcome());
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(Icons.logout),
                        ),
                      )
                    ],
                  ),
                  if (controller.isLoadingBackground.value) sliverLoading(),
                  controller.isLoading.value
                      ? SliverFillRemaining(
                          child: Center(
                              child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            showLoading3(),
                            Obx(() => Text("dbc.prosesText.value")),
                          ],
                        )))
                      : _body2(controller)
                  //SliverList(delegate: SliverChildListDelegate([showLoading3(), Obx(() => Text(dbc.prosesText.value))])))) : _body2(ctrl)
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    kirimpesan('s111c', 1208, "Mutasi", payload: {"idpengirim": 1309.toString(), "idlokasi": 6.toString(), "jenis": "request"});
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

_body2(DBGudangController c) {
  return SliverList(
      delegate: SliverChildListDelegate([
    _temp1('mutasi', 'assets/mutasi.png', 'Mutasi'),
    _temp1('penjualan', 'assets/penjualan.png', 'Penjualan'),
    _temp1('rak', 'assets/penawaran.png', 'Daftar Rak'),
    _temp1('peletakan', 'assets/penawaran.png', 'Peletakan Barang'),
    _temp1('lokasi', 'assets/lokasi.png', 'Lokasi'),
    _temp1('barang', 'assets/barang.png', 'Daftar Barang'),
    _temp1('kontak', 'assets/pelanggan.png', 'Pelanggan'),
    _temp1('opname', 'assets/opname.png', 'Opname'),
  ]));
}

_temp1(String route, String aset, String label) {
  return Card(
    child: ListTile(
      onTap: () => Get.toNamed("/$route"),
      leading: Image.asset(aset, width: 40),
      title: Text(label, textScaler: const TextScaler.linear(1.2)),
      trailing: const Icon(Icons.navigate_next),
    ),
  );
}
