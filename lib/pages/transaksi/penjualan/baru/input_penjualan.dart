import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ljm/pages/transaksi/penjualan/controller.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/harga.dart';
import 'package:ljm/provider/models/keuangan/rekening.dart';
import 'package:ljm/provider/models/lokasi.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/widgets/customtextfield.dart';
import 'package:ljm/widgets/lookup/harga.dart';
import 'package:ljm/widgets/lookup/kontak.dart';
import 'package:ljm/widgets/lookup/lokasi.dart';
import 'package:ljm/widgets/lookup/rekening.dart';
import 'package:ljm/widgets/lookup/sales.dart';
import 'package:ljm/widgets/lookup/termin.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

class PenjualanBaru extends StatefulWidget {
  const PenjualanBaru({super.key});

  @override
  State<PenjualanBaru> createState() => _PenjualanBaruState();
}

class _PenjualanBaruState extends State<PenjualanBaru> {
  TextEditingController pelangganController = TextEditingController(text: 'Nama Pelanggan');
  TextEditingController tglTransaksiController = TextEditingController(text: 'Hari Ini');
  TextEditingController syaratBayarController = TextEditingController(text: 'Tunai saat Pengantaran (COD)');
  TextEditingController cabangController = TextEditingController(text: 'Kantor Pusat');
  var catatanController = TextEditingController();
  var alamatController = TextEditingController();
  var newTrans = TRANSAKSI(
    tanggal: DateTime.now().toString(),
    jharga: 'JUAL2',
    idlokasi: user.akseslokasi?.firstWhere((e) => e.idlokasi == user.idlokasi).idlokasi,
    lokasi: user.akseslokasi?.firstWhere((e) => e.idlokasi == user.idlokasi).kode,
    rekkas: user.akseskas?.first.id,
    akunkas: user.akseskas?.first.rekening,
    idpegawai: user.idkontak ?? ((salesAktif != null) ? salesAktif!.id : null),
    termin: 'CASH',
  );
  @override
  void initState() {
    tglTransaksiController.text = formattanggal(newTrans.tanggal, 'dd/MM/yyyy HH:mm');
    dp("neTrans: ${newTrans}");
    super.initState();
  }

  @override
  void dispose() {
    pelangganController.dispose();
    tglTransaksiController.dispose();
    syaratBayarController.dispose();
    cabangController.dispose();
    catatanController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  bool cekKelengkapanNotaBaru() {
    return (newTrans.idkontak != null && newTrans.akunkas != null && newTrans.idpegawai != null && newTrans.idlokasi != null && newTrans.jharga != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const CustomTextStandard(
          text: 'Sales Order Baru',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              if (iDireksi())
                Row(
                  children: [
                    Expanded(
                      child: PilihSales(onPilih: (v) {
                        setState(() {
                          if (v != null) {
                            newTrans.idpegawai = v.id;
                            newTrans.pegawai = v.kode;
                          }
                        });
                      }),
                    ),
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner, color: Colors.grey),
                      onPressed: () {
                        // Add functionality for QR code scanning
                      },
                    ),
                    Expanded(
                      child: PilihRekening(
                          initial: (newTrans.rekkas != null) ? REKENING(kode: newTrans.rekkas, akun: newTrans.akunkas) : null,
                          onPilih: (v) {
                            setState(() {
                              if (v != null) {
                                newTrans.rekkas = v.kode;
                                newTrans.akunkas = v.akun;
                              }
                            });
                          }),
                    ),
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner, color: Colors.grey),
                      onPressed: () {
                        // Add functionality for QR code scanning
                      },
                    ),
                  ],
                ),
              Row(
                children: [
                  Expanded(
                    child: PilihPelanggan(onPilih: (selectedPelanggan) {
                      setState(() {
                        if (selectedPelanggan != null) {
                          newTrans.idkontak = selectedPelanggan.id;
                          newTrans.kontak = selectedPelanggan.kode;
                          pelangganController.text = selectedPelanggan.nama ?? '';
                          alamatController.text = selectedPelanggan.alamat ?? '';
                          if (selectedPelanggan.termin != null) newTrans.termin = selectedPelanggan.termin;
                          if (selectedPelanggan.desa != null) alamatController.text += "\n${selectedPelanggan.desa}";
                          if (selectedPelanggan.kecamatan != null) alamatController.text += ' - ${selectedPelanggan.kecamatan}';
                          if (selectedPelanggan.kabupaten != null) alamatController.text += '\n${selectedPelanggan.kabupaten}';
                          if (selectedPelanggan.provinsi != null) alamatController.text += ' - ${selectedPelanggan.provinsi}';
                          if (selectedPelanggan.kodepos != null) alamatController.text += '\n${selectedPelanggan.kodepos}';
                          if (selectedPelanggan.telp != null) alamatController.text += '\n${selectedPelanggan.telp}';
                        }
                      });
                    }),
                  ),
                  IconButton(
                    icon: const Icon(Icons.qr_code_scanner, color: Colors.grey),
                    onPressed: () {
                      // Add functionality for QR code scanning
                    },
                  ),
                ],
              ),
              const Align(alignment: Alignment.centerLeft, child: CustomTextStandard(text: 'Alamat')),
              const SizedBox(height: 10),
              TextField(
                controller: alamatController,
                style: GoogleFonts.poppins(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black),
                maxLines: 5,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.tryParse(newTrans.tanggal.toString()) ?? DateTime.now(),
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != DateTime.tryParse(newTrans.tanggal.toString())) {
                        setState(() {
                          newTrans.tanggal = picked.toString();
                          tglTransaksiController.text = formattanggal(picked.copyWith(hour: DateTime.now().hour, minute: DateTime.now().minute, second: 0, millisecond: 0).toString(), 'dd/MM/yyyy HH:mm');
                        });
                      }
                    },
                    child: IgnorePointer(
                      child: CustomTextField(readOnly: true, enabled: true, controller: tglTransaksiController, label: 'Tanggal Transaksi', suffixIcon: Icons.calendar_month),
                    ),
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PilihTermin(
                      onPilih: (p0) {
                        setState(() {
                          if (p0 != null) {
                            newTrans.termin = p0.kode;
                            newTrans.tempo = ((DateTime.tryParse(newTrans.tanggal ?? '') ?? DateTime.now()).add(Duration(days: p0.hari ?? 0))).toString();
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      showDragHandle: true,
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
                            ListTile(
                              leading: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context); // Fungsi untuk menutup modal
                                },
                                child: const Icon(Icons.cancel),
                              ),
                              title: const CustomTextStandard(
                                text: 'Lampiran',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(),
                            const ListTile(
                              leading: Icon(Icons.camera_alt),
                              title: CustomTextStandard(text: 'Camera'),
                            ),
                            const ListTile(
                              leading: Icon(Icons.image_outlined),
                              title: CustomTextStandard(text: 'Galeri'),
                            ),
                            const ListTile(
                              leading: Icon(Icons.note),
                              title: CustomTextStandard(text: 'Dokumen'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.attachment_outlined),
                      CustomTextStandard(
                        text: ' + Lampiran',
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: PilihHarga(
                      initial: HARGA(kode: newTrans.jharga),
                      enabled: !iSales(),
                      onPilih: (p0) {
                        setState(() {
                          if (p0 != null) {
                            newTrans.jharga = p0.kode;
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: PilihLokasi(
                          initial: LOKASI(id: newTrans.idlokasi, kode: newTrans.lokasi),
                          onPilih: (p0) {
                            if (p0 != null) {
                              newTrans.idlokasi = p0.id;
                              newTrans.lokasi = p0.kode;
                            }
                          }))
                ],
              ),
              const Align(alignment: Alignment.centerLeft, child: CustomTextStandard(text: 'Catatan')),
              const SizedBox(height: 10),
              TextField(
                controller: catatanController,
                style: GoogleFonts.poppins(
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: cekKelengkapanNotaBaru()
                ? () async {
                    var newres = await draftBaru();
                    if (newres != null) {
                      newTrans.id = newres.id;
                      newTrans.nobukti = newres.nobukti;
                      newTrans.notrans = newres.notrans;
                      if (catatanController.text != '') newTrans.catatan = catatanController.text;
                      var sql = newTrans.updateDraftSql();
                      await executeSql(sql);
                      getPenjualanController().pagingDraftController.refresh();
                      Get.offAndToNamed("/penjualan/baru/detail", arguments: newTrans);

                      // PindahPage.navigateTo(context, TerimaPembayaran(x: TRANSAKSI())); // 'Total Penjualan'));
                    }
                  }
                : null,
            child: Container(
              height: 60,
              color: cekKelengkapanNotaBaru() ? mainColor : Colors.grey,
              // decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16.0),
              child: Align(
                alignment: Alignment.center,
                child: const Text(
                  'Proses',
                  style: TextStyle(color: Colors.white), // Text 'Bayar' berwarna putih
                ),
              ),
            ),
          )),
    );
  }
}
