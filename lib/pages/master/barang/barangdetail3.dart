import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/master/barang/editbarang3.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/template_paginate_table.dart';

import 'detailcontroller.dart';

class DetailBarangPage3 extends StatelessWidget {
  final BARANG data;
  const DetailBarangPage3(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(BarangDetailController(context: context, data: data));

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(skala)),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Detail Barang3'),
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(() => EditBarangPage3(data));
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
            bottomNavigationBar: _bottomButton(c),
            // floatingActionButton: floatbutton(),
            body: Obx(() => (c.firstLoading.value)
                ? showloading()
                : (c.cI.value == 0)
                    ? _detailbody(c)
                    : (c.cI.value == 1)
                        ? _detailgambar(c)
                        : (c.cI.value == 2)
                            ? _detailmutasi(c)
                            : const Text(''))));
  }

  _detailbody(BarangDetailController c) {
    double k1 = 100;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(c.newdata.value.nama, style: tstebal)),
                  Obx(() => Text("#${c.newdata.value.id}", style: tstebal)),
                  const Divider(),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [SizedBox(width: k1, child: const Text("Kode")), const Text(": "), Obx(() => Text(c.newdata.value.kode ?? ''))]),
                      Row(children: [SizedBox(width: k1, child: const Text("Merk")), const Text(": "), Obx(() => Text(c.newdata.value.merk))]),
                      Row(children: [
                        SizedBox(width: k1, child: const Text("Kategori")),
                        const Text(": "),
                        Obx(() => Text(c.newdata.value.kategori ?? '')),
                      ]),
                      Row(children: [
                        SizedBox(width: k1, child: const Text("Golongan")),
                        const Text(": "),
                        Obx(() => Text(c.newdata.value.golongan ?? '')),
                      ]),
                      Row(children: [SizedBox(width: k1, child: const Text("Jenis")), const Text(": "), Obx(() => Text(c.newdata.value.jenis ?? ''))]),
                      Row(children: [SizedBox(width: k1, child: const Text("Kelompok")), const Text(": "), Obx(() => Text(c.newdata.value.kelompok ?? ''))]),
                      Row(children: [SizedBox(width: k1, child: const Text("Eceran")), const Text(": "), Obx(() => Text(formatangka(c.newdata.value.jual5.toString())))]),
                      Row(children: [SizedBox(width: k1, child: const Text("Partai")), const Text(": "), Obx(() => Text(formatangka(c.newdata.value.jual2.toString())))]),
                      Row(children: [SizedBox(width: k1, child: const Text("Spesial")), const Text(": "), Obx(() => Text(formatangka(c.newdata.value.jual4.toString())))]),
                      Row(children: [SizedBox(width: k1, child: const Text("Qty Dos")), const Text(": "), Obx(() => Text(formatangka(c.newdata.value.qtydos.toString())))]),
                      Row(children: [
                        SizedBox(width: k1, child: const Text("Stok", style: TextStyle(color: maroon, fontWeight: FontWeight.bold))),
                        const Text(": "),
                        Obx(() => Text(formatangka(c.newdata.value.stok.toString()), style: tstebalmerah)),
                        Obx(() => Text(" ${c.newdata.value.satuan}")),
                      ]),
                    ]),
                    //QrImage(data: _datax.kode, size: 130, version: QrVersions.auto, padding: const EdgeInsets.all(0)),
                  ]),
                  const Divider(),
                  if (c.wstok.isNotEmpty) Column(children: c.wstok),
                  const Divider(),
                  const Text('Peletakan (RAK): ', style: tstebal),
                  if (c.wpeletakan.isNotEmpty) Column(children: c.wpeletakan),
                  tombol4(const Text('  Rak Lain', style: tstebal), const Icon(Icons.home), () => c.onPindah()),
                  const Divider(),
                  //Text(c.newdata.value.fileGambar ?? ''),
                  Obx(() => c.gambar.value),
                ],
              )),
        ],
      ),
    );
  }

  _detailgambar(BarangDetailController c) {
    return RefreshIndicator(
        onRefresh: () async => c.onInit(),
        child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Obx(() => FlutterCarousel(
                    items: c.imageSliders2,
                    options: FlutterCarouselOptions(enlargeCenterPage: false, height: 200, aspectRatio: 12, autoPlay: true),
                    //carouselController: c.controller.value,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(onPressed: () => c.imgDlg(), child: const Text('Tambah', style: tstebal)),
                  //ElevatedButton(onPressed: () => openBottomSheetModal(context), child: Text('Zoom', style: tstebal)),
                ],
              ),
            ])));
  }

  _detailmutasi(BarangDetailController c) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TablePaginate(
          itemBuilder: (context, item, index) {
            final TRANSAKSI transaksi = TRANSAKSI.fromMap(item);
            final lbr = (Get.width) - 20 - 50 - 60 - 30 - 30 - 50;
            return Card(
                margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(width: 20, child: Text("${transaksi.kdtrans}")),
                  Container(alignment: const Alignment(-1, 0), child: SizedBox(width: 50, child: Text("${transaksi.nobukti}"))),
                  SizedBox(width: 60, child: Text(formattanggal(transaksi.kdtrans == 'PB' ? """${transaksi.pengirimantgl}""" : "${transaksi.tanggal}"))),
                  SizedBox(width: lbr, child: Text((transaksi.idlokasi2 == getidLokasi()) ? transaksi.lokasi.toString() : transaksi.kontak ?? '')),
                  Container(alignment: const Alignment(1, 0), child: SizedBox(width: 30, child: AutoSizeText(formatangka(transaksi.qty), textAlign: TextAlign.right, style: ((transaksi.qty ?? 0) < 0) ? tstebalmerah : tstebalbiru))),
                  Container(alignment: const Alignment(1, 0), child: SizedBox(width: 30, child: AutoSizeText(formatangka(transaksi.saldo.toString()), textAlign: TextAlign.right))),
                ]));
          },
          sql: '''
      select x.*, sum(qty) over (order by tanggal) as saldo from
 (select t.tanggal, t.id, kdtrans, t.nobukti, t.kontak, t.idlokasi, t.idlokasi2, t.lokasi, t.lokasi2,
 if(t.idlokasi = ${getidLokasi()},mutasi,-mutasi) qty from transaksi t inner join detail d on d.idtrans = t.id 
 where d.mutasi <> 0 and idbarang = ${data.id} and (t.idlokasi = ${getidLokasi()} or t.idlokasi2 = ${getidLokasi()})
 order by tanggal) x
 order by tanggal desc
       '''),
    );
  }

  Widget _bottomButton(BarangDetailController c) {
    return BottomNavigationBar(
      backgroundColor: Colors.deepOrange,
      currentIndex: c.cI.value,
      onTap: c.setCurrentIndex,
      elevation: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(backgroundColor: Colors.yellow, icon: Icon(Icons.list, color: Colors.white), activeIcon: Icon(Icons.list, color: Colors.yellow), label: "Detail"),
        BottomNavigationBarItem(backgroundColor: Colors.yellow, icon: Icon(Icons.collections, color: Colors.white), activeIcon: Icon(Icons.collections, color: Colors.yellow), label: "Gambar"),
        BottomNavigationBarItem(backgroundColor: Colors.yellow, icon: Icon(Icons.iso, color: Colors.white), activeIcon: Icon(Icons.iso, color: Colors.yellow), label: "Mutasi"),
        //   BubbleBottomBarItem(backgroundColor: Colors.yellow, icon: Icon(Icons.app_registration, color: Colors.white), activeIcon: Icon(Icons.app_registration, color: Colors.yellow), title: Text("Rak")),
      ],
    );
  }
}
