import 'dart:ui';
// import 'package:photo_view/photo_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/homepage/main/controller.dart';
import 'package:ljm/pages/homepage/main/edit.dart';
import 'package:ljm/pages/users/login2/login.dart';
import 'package:ljm/main.dart';
import 'package:ljm/provider/models/user.dart';
import 'package:ljm/widgets/utils.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/tools/env.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class DashboardMain extends GetView<MainController> {
  const DashboardMain({super.key});

  @override
  Widget build(BuildContext context) {
    var c = controller;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(sf)),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        child: Scaffold(
          drawer: const CustomDrawer(),
          key: _scaffoldKey,
          appBar: AppBar(
            titleSpacing: 7,
            elevation: 0,
            title: Obx(() => TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: c.searchController.value,
                  onChanged: c.filter,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(maxHeight: 45),
                      alignLabelWithHint: true,
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.search, color: Colors.black38),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), gapPadding: 1, borderSide: BorderSide.none),
                      hintText: "MAIN",
                      hintStyle: const TextStyle(color: Colors.black45)),
                )),
            actions: [
              IconButton(
                visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.people_alt),
                onPressed: () async {
                  Get.to(() => const LoginPage());
                },
              ),
              const SizedBox(width: 10.0),
            ],
          ),
          body: Obx(() => Column(
                children: [
                  Text(c.trigger.toString(), style: const TextStyle(color: Colors.white70, fontSize: 2)),
                  Text(c.cek.value, style: const TextStyle(fontSize: 1)),
                  SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          JenisLayanan(
                            c.jenisCap.value,
                            isSelected: true,
                            onTap: () {
                              c.jenisChange(-6);
                            },
                            onLongPress: () {
                              List<PopupMenuEntry> lit = [
                                PopupMenuItem(
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Semua', textScaler: TextScaler.linear(sf)),
                                      if (-6 == c.selectedJenis.value) const Icon(Icons.check, size: 12),
                                    ],
                                  ),
                                  onTap: () {
                                    c.jenisChange(-6);
                                    //  scrollController.animateTo(double.parse(i.toString()) * lebarkolom, duration: Duration(seconds: 1), curve: Curves.ease);
                                  },
                                )
                              ];

                              /* for (int n = 0; n < dbc.mBrgJenis.length; n++) {
                                lit.add(PopupMenuItem(
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(dbc.mBrgJenis[n].jenis, textScaler: const TextScaler.linear(sf)),
                                      if (dbc.mBrgJenis[n].id == c.selectedJenis.value) const Icon(Icons.check, size: 12),
                                    ],
                                  ),
                                  onTap: () {
                                    c.jenisChange(dbc.mBrgJenis[n].id ?? 0);
                                    // scrollController.animateTo(double.parse(n.toString()) * lebarkolom, duration: Duration(seconds: 1), curve: Curves.ease);
                                  },
                                ));
                              } */
                              showMenu(
                                context: context,
                                position: const RelativeRect.fromLTRB(0, 0, 0, 0),
                                items: lit,
                              );
                            },
                          ),
                          /* Expanded(
                              child: ListView.builder(
                                  controller: c.scrollController.value,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: dbc.mBrgJenis.length,
                                  itemBuilder: (context, i) {
                                    return JenisLayanan(
                                      dbc.mBrgJenis[i].jenis.toString(),
                                      isSelected: (dbc.mBrgJenis[i].id == c.selectedJenis.value),
                                      onTap: () {
                                        c.jenisChange(dbc.mBrgJenis[i].id ?? 0);
                                      },
                                    );
                                  })) */
                        ],
                      )),
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: () async {
                      await c.reLoad();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
                      shrinkWrap: true,
                      itemCount: c.list.length,
                      itemBuilder: (context, index) {
                        DETAIL? data = c.keranjang.firstWhereOrNull((element) => element.idtrans == 0 && element.idbarang == c.list[index].id);

                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(height: 50, width: 50, child: GambarWidget(c.list[index], c.list[index].fileThumb ?? '', width: 45, height: 45, key: Key(c.list[index].id.toString()))),
                              const SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
                                  onTap: () => c.tambah(c.list[index]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //  Text(c.list[index].nama.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                      RichText(
                                        textScaler: const TextScaler.linear(sf),
                                        maxLines: 1,
                                        text: TextSpan(
                                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(text: c.list[index].nama),
                                            TextSpan(text: "  [${c.list[index].merk}]", style: TextStyle(color: Colors.blue[900])),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        textScaler: const TextScaler.linear(sf),
                                        maxLines: 1,
                                        text: TextSpan(
                                          style: const TextStyle(color: Colors.black),
                                          children: [
                                            const TextSpan(text: 'Rp. '),
                                            TextSpan(text: formatangka(c.list[index].jual5)),
                                            TextSpan(text: "  / ${c.list[index].satuan}"),
                                          ],
                                        ),
                                      ),
                                      if (c.list[index].nostok != 1)
                                        RichText(
                                            textScaler: const TextScaler.linear(sf),
                                            text: TextSpan(
                                              style: const TextStyle(color: Colors.black),
                                              children: [
                                                const TextSpan(text: "Stok  "),
                                                TextSpan(
                                                  text: formatangka(c.list[index].stoklokasi),
                                                  style: TextStyle(
                                                    color: (c.list[index].stoklokasi > 0) ? Colors.green[900] : Colors.red[900],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )),
                                    ],
                                  ),
                                ),
                              ),
                              if (data != null)
                                TextButton.icon(
                                    onPressed: () async {
                                      /*  String sat = (c.list[index].defsatuan != null) ? '(${c.list[index].satuan})' : '';
                                      await showDoubleDialog(
                                        context,
                                        data.proses,
                                        label: 'Masukkan Qty $sat',
                                        onDelete: () async {
                                         // var res = await data.hapusLocal();
                                          if (res) {
                                            c.keranjang.removeWhere((element) => element.idtrans == 0 && element.idbarang == c.list[index].id);
                                            Get.back();
                                            c.hitung();
                                            Get.snackbar('title', 'Item dihapus dari ranjang', snackPosition: SnackPosition.BOTTOM);
                                          }
                                        },
                                        onSubmit: (p0) {
                                          data.proses = p0;
                                          data.simpanLocal();
                                          Get.back();
                                          c.hitung();
                                        },
                                      ); */
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.black54),
                                    label: Text(formatangka(data.proses.toString()))),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(thickness: 1, height: 2);
                      },
                    ),
                  )),
                  if (c.jml > 0)
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onTap: () async {
                            var res = await Get.to(() => const DetailJualPage());
                            if (res == true) {
                              await c.initData();
                            }
                          },
                          tileColor: Colors.amber,
                          title: Text("${c.jml} item"),
                          trailing: RichText(
                              text: TextSpan(children: [
                            TextSpan(text: "Rp. ${formatangka(c.total)}  "),
                            const WidgetSpan(child: Icon(Icons.arrow_forward_ios, size: 16)),
                          ]))
                          /* TextButton.icon(
                        onPressed: () {},
                        label: const Icon(Icons.arrow_forward_ios, size: 16),
                        icon: Text("Rp. ${formatangka(c.total)}"),
                      ), */
                          ),
                    ),
                ],
              )),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // buildUserHeader(),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Tindakan saat item 1 dipilih
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Tindakan saat item 2 dipilih
            },
          ),
          ListTile(
            title: const Text('KELUAR'),
            onTap: () async {
              dp("handleSignOut");
              if (await googleSignIn.isSignedIn()) {
                await googleSignIn.signOut();
              }
              prefs.clear();
              user = User();
              dp("handleSignOut d");

              Get.offAll(() => const wellcome());
            },
          ),
        ],
      ),
    );
  }
}
