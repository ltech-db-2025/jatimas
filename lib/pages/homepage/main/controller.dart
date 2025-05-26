// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

enum Urut { az, za, terbaru, terlama }

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}

class MainController extends GetxController {
  var list = <BARANG>[].obs;
  var jual = TRANSAKSI().obs;
  var keranjang = <DETAIL>[].obs;
  var loading = false.obs;
  var total = 0.0.obs;
  var subtotal = 0.0.obs;
  var jml = 0.obs;
  RxInt selectedJenis = (-6).obs;
  var cek = 'OK'.obs;
  var jharga = 'JUAL5'.obs;
  var harga = 'JUAL5'.obs;
  var kontak = KONTAK().obs;
  var trigger = 0.obs;
  var nTotal = 0.obs;
  var jenisCap = "Semua".obs;
  var nUrut = Urut.az.obs;
  var scale = 0.2.obs;
  var previousScale = 1.0.obs;
  var scrollController = ScrollController().obs;
  var searchController = TextEditingController().obs;
  var deflokasiini = 6.obs;
  var semuaStokini = true.obs;
  var sql = "";
  @override
  onInit() {
    initData();
    super.onInit();
  }

  initData() async {
    setPengaturan();
    filter(searchController.value.text);
    _reset();
  }

  setPengaturan() async {
    filter(searchController.value.text);

    trigger++;
    update();
  }

  updateScale(double n) {
    scale.value = previousScale.value * n;
    dp("updateScale($n) => ${scale.value}");
    trigger++;
    update();
  }

  setLoading([value = true]) {
    loading.value = value;
    update();
  }

  reLoad() async {
    trigger.value = 0;
    filter(searchController.value.text);
  }

  tambah(BARANG data) async {
    /* if (dbc.mBarang.firstWhereOrNull((p0) => p0.id == data.id) != null) {
      final x = keranjang.firstWhereOrNull((p0) => p0.idbarang == data.id && p0.idtrans == 0);

      if (x == null) {
        var newdata = DETAIL(
          idtrans: 0,
          // urut: await DETAIL.getLastNomor(0),
          idbarang: data.id,
          nama: data.nama,
          proses: 1,
          idsatuan: data.idsatuan,
          satuan: data.satuan,
          isi: data.isi ?? 1,
          harga: data.jual2 ?? 0,
        );
        // await newdata.simpanLocal();
        keranjang.add(newdata);
        await _updatedata();
        trigger++;
        update();
      } else {
        x.proses = (double.tryParse(x.proses.toString()) ?? 0) + 1;
        // x.simpanLocal();
        trigger++;
        await _updatedata();
        update();
      }
    } else {
      dp('barang tidak ada');
    } */
  }

  _updatedata() async {
    // subtotal.value = await DETAIL.getSubTotal();
    jml.value = keranjang.where((p0) => p0.idtrans == 0).length;
    // total.value = subtotal.value - jual.value.diskon;
    nTotal++;
  }

  hitung() async {
    await _updatedata();
    update();
  }

  ubahQty(int index, double qty) async {
    var baru = keranjang[index].copyWith(proses: (keranjang[index].proses) + qty);
    keranjang.removeAt(index);
    keranjang[index] = baru.copyWith();
    // await keranjang[index].simpanLocal();
    _updatedata();
    cek.value = "jml: ${keranjang[index].proses}";
    update();
  }

  jenisChange(int i) {
    cek.value = i.toString();
    if (i == -6) {
      jenisCap.value = "Semua";
      selectedJenis.value = -6;
    } else {
      selectedJenis.value = i;
      //   jenisCap.value = dbc.mBrgJenis.firstWhere((element) => element.id == i, orElse: () => BrgJenis(id: 0, jenis: '')).jenis;
    }
    filter(searchController.value.text);
  }

  void filter(String searchString) {
    /* if (searchString == "") {
      if (selectedJenis.value == -6) {
        if (semuaStokini.value) {
          list.value = dbc.mBarang.where((p0) => p0.aktif == 1).toList();
        } else {
          list.value = dbc.mBarang.where((p0) => p0.aktif == 1 && p0.stoklokasi != 0).toList();
        }
      } else {
        if (semuaStokini.value) {
          list.value = dbc.mBarang.where((p0) => p0.aktif == 1 && p0.idjenis == selectedJenis.value).toList();
        } else {
          list.value = dbc.mBarang.where((p0) => p0.aktif == 1 && p0.idjenis == selectedJenis.value && p0.stoklokasi != 0).toList();
        }
      }
    } else {
      if (selectedJenis.value == -6) {
        if (semuaStokini.value) {
          list.value = dbc.mBarang.where((p0) => p0.aktif == 1 && (p0.nama.toLowerCase().contains(searchString.toLowerCase()) || p0.kode.toLowerCase().contains(searchString.toLowerCase())) || p0.merk.toLowerCase().contains(searchString.toLowerCase())).toList();
        } else {
          list.value = dbc.mBarang.where((p0) => p0.stoklokasi != 0 && p0.aktif == 1 && (p0.nama.toLowerCase().contains(searchString.toLowerCase()) || p0.kode.toLowerCase().contains(searchString.toLowerCase())) || p0.merk.toLowerCase().contains(searchString.toLowerCase())).toList();
        }
      } else {
        if (semuaStokini.value) {
          list.value = dbc.mBarang.where((p0) => p0.aktif == 1 && p0.idjenis == selectedJenis.value && ((p0.nama.toLowerCase().contains(searchString.toLowerCase()) || p0.kode.toLowerCase().contains(searchString.toLowerCase())) || p0.merk.toLowerCase().contains(searchString.toLowerCase()))).toList();
        } else {
          list.value = dbc.mBarang.where((p0) => p0.stoklokasi != 0 && p0.aktif == 1 && p0.idjenis == selectedJenis.value && ((p0.nama.toLowerCase().contains(searchString.toLowerCase()) || p0.kode.toLowerCase().contains(searchString.toLowerCase())) || p0.merk.toLowerCase().contains(searchString.toLowerCase()))).toList();
        }
      }
    } */

    urut();
  }

  urut() {
    switch (nUrut.value) {
      case Urut.za:
        list.sort((b, a) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()));
        break;

      case Urut.terbaru:
        list.sort((a, b) => a.created!.toLowerCase().compareTo(b.created!.toLowerCase()));
        break;

      case Urut.terlama:
        list.sort((b, a) => a.created!.toLowerCase().compareTo(b.created!.toLowerCase()));
        break;

      default:
        list.sort((a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()));
    }

    update();
  }

  hapusData(DETAIL x) async {
/*     if (await x.hapusLocal() == true) {
      keranjang.removeWhere((p0) => p0.idtrans == x.idtrans && p0.idbarang == x.idbarang);
    } */
    await _updatedata();
    update();
  }

  _reset() async {
    // keranjang.value = await DETAIL.getList({"idtrans": 0});
    kontak.value = KONTAK();
    /* final x = await Draft.getList({"id": 0});
    if (x.isEmpty) {
      jual.value = Draft(id: 0);
    } else {
      jual.value = x.first;
    } */
    trigger.value = 0;
    nTotal.value = 0;
    await _updatedata();
  }

  Future<bool> simpan2() async {
    jual.value.id = 0;
    jual.value.tanggal ??= DateTime.now().toString();
    jual.value.tempo ??= DateTime.now().toString();
    jual.value.idlokasi = deflokasiini.value;
    List<Map<String, dynamic>> detail = [];
    for (var d in keranjang) {
      detail.add({
        "urut": d.urut,
        "idbarang": d.idbarang,
        "proses": d.proses,
        "harga": d.harga,
        "idsatuan": d.idsatuan,
        "isi": d.isi,
        "pdiskon": d.diskon2,
        "diskon": d.diskon,
        "catatan": d.keterangan,
      });
    }
    final data2 = [
      {
        "master": {
          "id": jual.value.id,
          "tanggal": jual.value.tanggal,
          "tempo": jual.value.tempo,
          "idlokasi": jual.value.idlokasi,
          "idkontak": jual.value.idkontak,
          "idpegawai": jual.value.idpegawai,
          "pdiskon": jual.value.pdiskon,
          "diskon": jual.value.diskon,
          "catatan": jual.value.catatan,
        },
        "detail": detail,
      }
    ];
    dp("data: $data2");
    /* final res = await GetConnect().post('${homepage}penjualan/new.php', data2);
    if (res.statusCode == 200) {
      if (res.body == null) {
        pesanError("Kesalahan: ${res.statusCode}\n body: ${res.body}");
        return false;
        // } else if (res.body['status'] == 'success') { return false;
      } else if (res.body['status'] == 'berhasil') {
        dp('master: ${res.body['master']}');
        String masterjson = jsonEncode(res.body['master']);
        jual.value = Draft.fromJson(masterjson);
        jual.value.simpanLocal();
        for (var d in res.body['detail']) {
          String masterjson = jsonEncode(d);
          final b = DETAIL.fromJson(masterjson);
          b.simpanLocal();
        }
        jual.value = Draft(id: 0, tanggal: DateTime.now().toString());

        await DETAIL.reset();
        await _reset();
        update();
        return true;
      } else {
        pesanError("Kesalahan: ${res.statusCode}\n body: ${res.body}");
        return false;
      }
    } else {
      pesanError("Kesalahan: ${res.statusCode}\n body: ${res.body}");
      return false;
    } */
    return false;
  }

  _setUrut(Urut nilai) {
    nUrut.value = nilai;
    urut();
    Get.back();
  }

  shuwUrut(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: 160.0,
              child: ListView(
                children: [
                  ListTile(dense: true, onTap: () => _setUrut(Urut.az), title: const Text('Urut A-Z')),
                  ListTile(dense: true, onTap: () => _setUrut(Urut.za), title: const Text('Urut Z-A')),
                  ListTile(dense: true, onTap: () => _setUrut(Urut.terbaru), title: const Text('Urut Item Terbaru')),
                  ListTile(dense: true, onTap: () => _setUrut(Urut.terlama), title: const Text('Urut Item Terlama')),
                ],
              ),
            ),
          );
        });
  }
}

class Master {
  int? id;
  DateTime? tanggal;
  String? catatan;
  List<Detail>? details;

  Master({this.id, this.tanggal, this.catatan, this.details});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tanggal': tanggal?.toIso8601String(),
      'catatan': catatan,
      'details': details?.map((detail) => detail.toMap()).toList(),
    };
  }

  String toJson() => jsonEncode(toMap());
}

class Detail {
  int? id;
  double? jumlah;
  double? nilai;

  Detail({this.id, this.jumlah, this.nilai});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jumlah': jumlah,
      'nilai': nilai,
    };
  }
}
