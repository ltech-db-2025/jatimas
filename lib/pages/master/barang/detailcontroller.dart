// ignore_for_file: unused_local_variable, duplicate_ignore, unused_element

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/provider/models/peletakan.dart';
import 'package:ljm/provider/models/stok.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/provider/models/rak.dart';
import 'package:ljm/tools/env.dart';
import 'package:photo_view/photo_view.dart';

class BarangDetailController extends GetxController {
  final BuildContext context;
  BARANG data;
  BarangDetailController({required this.context, required this.data});

  Rx<Widget> gambar = Rx<Widget>(SizedBox(height: 200, child: Center(child: Image.asset('assets/tas.png'))));
  var firstLoading = true.obs;
  var newdata = BARANG().obs;
  var wstok = <Widget>[].obs;
  var wpeletakan = <Widget>[].obs;
  var selectedRak = Rak().obs;
  var imageSliders2 = <Widget>[].obs;
  var isFirstGambar = true.obs;
  var isFirstMutasi = true.obs;
  var listdetail = <TRANSAKSI>[].obs;
  var imageLoading = false.obs;
  var cI = 0.obs;
  //var controller = CarouselController().obs;
  var gantiGambar = false.obs;
  dynamic dataimg;
  String? imagePath;
  String? imagePathOri;
  @override
  onInit() {
    _init();
    super.onInit();
  }

  _init() async {
    _ambildata();
    await _initialstok();
    firstLoading.value = false;
    await _initGambar();
    update();
  }

  _initGambar([bool replaceImage = false]) async {
    if (newdata.value.fileGambar != null) {
      if (newdata.value.fileGambar.toString() != '' && newdata.value.fileGambar.toString() != 'null') {
        imagePath = await loadCacheDownload(newdata.value.fileGambar!, newdata.value.gambar!, 'barang', replaceImage);
        imagePathOri = imagePath;
      }
    }
    setGambar();
  }

  setGambar() {
    gambar.value = InkWell(
        onTap: () {
          imgDlg();
        },
        /* onTap: () async {
          final ImagePicker picker = ImagePicker();
          var res = await picker.pickImage(source: ImageSource.gallery);
          if (res != null) {
            setimage(File(res.path));
          }
        }, */
        child: Center(
            child: (imagePath != null)
                ? Image.file(File(imagePath!), fit: BoxFit.cover)
                : imageLoading.value
                    ? const CircularProgressIndicator()
                    : Image.asset('assets/tas.png', height: 200, width: 200)));
    update();
  }

  setimage(File? filenya) async {
    if (filenya != null) {
      imagePath = filenya.path;
      gantiGambar.value = true;
      /* var xres = await list.value.simpanGambar(File(imagePath!.toString()));
      if (xres == true) {
        var filedir = 'barang/uploads/thumbs';
        var thumbFile = "$pathExtData$filedir/${list.value.id.toString()}.jpg";
        var file = File(thumbFile);
        if (file.existsSync()) {
          file.deleteSync();
        }
        await deleteCachedImage(thumbFile, 'barang');
        ImageProvider imageProvider = FileImage(File(thumbFile));
        deleteImageFromCache(imageProvider);
      } else {
        Get.snackbar('Penyimpanan Gambar', "Gagal Menyimpan Gambar");
        final newFile = File("${pathExtData}barang/${list.value.gambar}");
        final oldFile = File(imagePath!);
        final contents = oldFile.readAsBytesSync();
        newFile.writeAsBytesSync(contents);
        return;
      } */
      setGambar();
    }
  }

  _deleteImage() async {
    if (data.fileThumb != null) deleteThumb(data.fileThumb!, 'barang', data.id.toString());
    if (data.fileGambar != null) deleteImage(data.fileGambar!, 'barang', data.id.toString());
    if (imagePathOri != null) {
      ImageProvider imageProvider = FileImage(File(imagePathOri!));
      deleteImageFromCache(imageProvider);
    }
    if (newdata.value.fileGambar != null) {
      ImageProvider imageProvider = FileImage(File(newdata.value.fileGambar!));
      deleteImageFromCache(imageProvider);
    }
    if (newdata.value.fileThumb != null) {
      ImageProvider imageProvider = FileImage(File(newdata.value.fileThumb!));
      deleteImageFromCache(imageProvider);
    }
  }

  setCurrentIndex(int i) {
    cI.value = i;
    if (i == 2 && isFirstMutasi.value) getmutasi();
    update();
  }

  Future<void> _ambildata() async {
    var res = await executeSql('select * from baranglengkap where id = ${data.id}');
    newdata.value = BARANG.fromMap(res.first);
    _initGambar();
    await _initialstok();
  }

  _initialstok() async {
    if (newdata.value.liststok.isNotEmpty) {
      wstok.value = newdata.value.liststok
          .map<Widget>(
            (item) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                SizedBox(width: 150, child: Text(item.lokasi ?? '')),
                const SizedBox(width: 10, child: Text(" : ")),
                Text(formatangka(item.stok), textAlign: TextAlign.right),
              ]),
              (item.idlokasi == getidLokasi()) ? ElevatedButton(onPressed: () => _onOpname(item), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Icon(Icons.ac_unit), Text(' Permintaan Opname')])) : const Text(''),
            ]),
          )
          .toList();
    } else {
      dp("newdata.value.liststok.length: ${newdata.value.liststok.length}");
      wstok.value = [const Text('')];
    }

    if (data.listpeletakan != null) {
      wpeletakan.value = data.listpeletakan!
          .map((item) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(item.kode ?? ''),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  tombol3(const Text(' Pindah'), const Icon(Icons.move_to_inbox), () => onPindah(data: item)),
                  tombol3(const Text(''), const Icon(Icons.delete), () => _onHapusRak(item)),
                ]),
              ]))
          .toList();
    } else {
      wpeletakan.value = [const Text('')];
    }
  }

  _onTambahRak(Rak raknya) async {
    var res = await postResponse(urlTambahpeletakan, {"id": raknya.id.toString(), "idbarang": data.id});
    if (res != null) {
      if (res.body == "New record created successfully") {
        newdata.value.listpeletakan!.add(PELETAKAN(id: raknya.id, idlokasi: data.id));
        // await pt.simpanLocal();
        Get.back(result: true);
        await _ambildata();
      }
    }
  }

  _onHapusRak(PELETAKAN data) async {
    dp('hapusrak $urlHapuspeletakan');
    try {
      /* var res = await postResponse(urlHapuspeletakan,
          {"id": data.id.toString(), "idbarang": data.idbarang.toString()});

      if (res != null) {
        if (res.body == "record deleted successfully") {
          if (await data.hapusLocal() == true) {
            await _ambildata();
          }
        }
      } */
    } catch (e) {
      dp("error: $e");
    }
  }

  void _onOpname(STOK st) {
    double selisih = 0;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Permintaan Opname'),
              Text("${data.nama} - ${data.merk}"),
              // Text(getlabellokasi(getidLokasi())),
              Text('Stok :${formatangka(data.stok)}'),
              Text(formattanggal(DateTime.now().toString())),
              const Text('Selisih: '),
            ]),
            content: SpinBox(
              // direction: Axis.vertical,
              textStyle: const TextStyle(fontSize: 48),
              incrementIcon: const Icon(Icons.add, size: 64),
              decrementIcon: const Icon(Icons.remove, size: 64),
              max: 1000000000,
              min: -1000000000,
              value: 0,
              onChanged: (val) {
                selisih = val;
              },
              autofocus: qtyautofocus,
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  TextButton(
                    child: const Text("Batal"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        _simpanopname(selisih);
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"))
                ],
              ),
            ],
          );
        });
  }

  void _simpanopname(double val) async {
    var idlokasi = getidLokasi();
    var idkontak = getidKontak();

    var res = await postResponse(
      urlOpname,
      {"idbarang": data.id.toString(), "idlokasi": idlokasi, "idkontak": idkontak, "opr": "NET", "selisih": val.toString()},
    );
    if (res == null) return;
    // await db.updateStok(idlokasi, data.id, val);
    await _ambildata();
  }

  onPindah({PELETAKAN? data}) {
    if (data != null) {
      /*  selectedRak.value = dbc.mRak.firstWhere(
          (x) => x.id.toString() == data.id.toString(),
          orElse: () => Rak()); */
    }
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          height: 200,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
/*           DropdownSearch<Rak>(
              items: dbc.mRak,
              selectedItem: selectedRak.value,
              popupProps: const PopupProps.dialog(),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(labelText: "Pilih Rak"),
              ),
             // asyncItems: (String filter) => getrak(filter),
              itemAsString: (Rak u) => u.toString(),
              onChanged: (Rak? data) => selectedRak.value = data), */
            /*  DropdownSearch<Rak>(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Pilih Rak",
                //contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                // border: OutlineInputBorder(),
              ),
              // onFind: (String? filter) => {},

              compareFn: (item, selectedItem) => item?.id == selectedItem?.id,
              itemAsString: (Rak? u) => u!.toString(),
              // items: dbc.mRak,
              showSearchBox: true,
              maxHeight: 400,
              onChanged: (Rak? a) {
                selectedRak.value = a ?? Rak();
              },
              selectedItem: selectedRak.value,
            ),
*/
            /* SearchableDropdown.single(
              // value: selectedRak.value.id.toString(),
              items: dbc.mRak!.map((item) {
                return DropdownMenuItem<String>(child: Text(item.kode!), value: item.id.toString());
              }).toList(),
              hint: caption,
              searchHint: caption,
              onChanged: (value) {
                selectedRak.value = dbc.mRak!.firstWhere((element) => element.id == value);
              },
              isExpanded: true,
            ), */
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton(onPressed: () => _onTambahRak(selectedRak.value), child: const Text('Tambah Rak', style: tstebal)),
              ElevatedButton(onPressed: () => _onPindahRak(selectedRak.value, pltk: data!), child: const Text('Pindahkan', style: tstebalhijau)),
              //ElevatedButton(onPressed: () => onHapusRak(selectedRak.value, data: data), child: Text('Pindahkan', style: tstebalhijau)),
            ])
          ])),
    );
  }

  _onPindahRak(Rak raknya, {PELETAKAN? pltk}) async {
    if (pltk != null) {
      var res = await postResponse(urlPindahpeletakan, {"idlama": pltk.id?.toString(), "id": raknya.id.toString(), "idbarang": data.id.toString()});
      if (res == null) return;
      if (res.body == "New record updated successfully") {
        // ignore: unused_local_variable
        String oldid = pltk.id!;
        pltk.id = raknya.id;
        // await db.ubahPeletakan(pltk, oldid);

        // if (!state.mounted) return;
        Get.back(result: true);
        pesanSukses('Peletakan berhasil diubah');
        await _ambildata();
      }
    }
  }

  // ignore: unused_element
  _openBottomSheetModal2() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PhotoViewGestureDetectorScope(
          axis: Axis.vertical,
          child: PhotoView(
            // backgroundDecoration: BoxDecoration(color: Colors.black.withAlpha(240)),
            enableRotation: true,
            // tightMode: true,
            imageProvider: NetworkImage("$urlBase/barang/bigimage.php?id=${data.id}"),
            loadingBuilder: (context, event) {
              if (event == null) {
                return showloading();
              }
              final value = (event.expectedTotalBytes != null) ? (event.cumulativeBytesLoaded / event.expectedTotalBytes!) : event.cumulativeBytesLoaded;
              return Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.yellow,
                    width: 32,
                    height: 32,
                    child: const CircularProgressIndicator(strokeWidth: 3),
                  )),
                  const Text(""),
                  Text(formatangka(value)),
                ],
              );
            },
            heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
          ),
        );
      },
    );
  }

  void imgDlg() async {
    /* final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImageDetail(list.value)),
    );
    if (result != null) {
      _deleteImage();
      imagePath = result;
      await list.value.simpanGambar(File(imagePath!));
      var i = cBrg.filteredbarang
          .indexWhere((element) => element.id == list.value.id);
      if (i > -1)
        cBrg.filteredbarang[i] = list.value.toBarangView(
            stok: cBrg.filteredbarang[i].stok,
            stoklokasi: cBrg.filteredbarang[i].stoklokasi);
      i = cBrg.barangawal.indexWhere((element) => element.id == list.value.id);
      if (i > -1)
        cBrg.barangawal[i] = list.value.toBarangView(
            stok: cBrg.barangawal[i].stok,
            stoklokasi: cBrg.barangawal[i].stoklokasi);
      i = dbc.mBarang.indexWhere((element) => element.id == list.value.id);
      if (i > -1)
        dbc.mBarang[i] = list.value.copyWith(
            stok: dbc.mBarang[i].stok, stoklokasi: dbc.mBarang[i].stoklokasi);

      if (Get.isRegistered<GambarController>(
          tag: "barang${list.value.id.toString()}")) {
        var c2 = Get.find<GambarController>(
            tag: "barang${list.value.id.toString()}");
        c2.initGambar(list.value.fileThumb, true);
      } else {
        dp("GambarController not registered");
      }
      cBrg.update();
      setGambar();
      update();
    } */
  }

  Future<void> getmutasi() async {
    /* int perpage = 50;
    int hal = 0;
    pesan = "Mendownload data";
    var url = '$urlBase/barang/lapmutasi.php';
    var xx = {
      "idbarang": data.id.toString(),
      "idlokasi": cBrg.lokasi.value.id.toString(),
      "limit": perpage.toString(),
      "offset": hal.toString()
    };
    await getResponse(url, xx).then((res) {
      if (res != null) {
        pesan = "inisialisasi data";

        final parsed = res.body.cast<Map<String, dynamic>>();
        listdetail.value =
            parsed.map<Transaksi>((json) => Transaksi.fromMap(json)).toList();
      }
    });

    isFirstMutasi.value = false;
    update(); */
  }
}
