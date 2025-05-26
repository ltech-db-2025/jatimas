import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ljm/pages/transaksi/penjualan/controller.dart';
import 'package:ljm/provider/database/query.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/lokasi.dart';
import 'package:ljm/provider/models/termin.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/widgets/customtextfield.dart';
import 'package:ljm/widgets/editor/editing_angka.dart';
import 'package:ljm/widgets/lookup/kontak.dart';
import 'package:ljm/widgets/lookup/lokasi.dart';
import 'package:ljm/widgets/lookup/termin.dart';

import 'listbarangbarangcontroller.dart';

class RincianDraftPenjualan2 extends StatefulWidget {
  final ListBarangController c;

  const RincianDraftPenjualan2(this.c, {super.key});

  @override
  State<RincianDraftPenjualan2> createState() => _RincianDraftPenjualan2State();
}

class _RincianDraftPenjualan2State extends State<RincianDraftPenjualan2> {
  var catatanController = TextEditingController();
  var alamatController = TextEditingController();
  var _terminController = TextEditingController();
  var _tempoController = TextEditingController();
  bool wessiap = false;

  @override
  void initState() {
    catatanController.text = widget.c.pesanan.value.catatan ?? '';
    _tempoController.text = 'Jatuh Tempo';
    if (widget.c.pesanan.value.tempo != null) _tempoController.text = formattanggal(widget.c.pesanan.value.tempo, 'dd/MM/yyyy');
    _terminController.text = 'CASH';
    if (widget.c.pesanan.value.termin != null) _terminController.text = widget.c.pesanan.value.termin ?? 'CASH';
    alamatController.text = widget.c.pesanan.value.alamat_kirim;
    wessiap = true;
    iniData();
    super.initState();
  }

  iniData() async {
    if (widget.c.pesanan.value.alamat_kirim == '') {
      widget.c.pesanan.value..datakontak = await getKontakByID(widget.c.pesanan.value.idkontak);
      widget.c.pesanan.value..alamat_kirim = widget.c.pesanan.value.datakontak?.alamatkirim ?? '';
      alamatController.text = widget.c.pesanan.value.alamat_kirim;
      setState(() {});
    }
  }

  bool _cekkelengkapan() {
    return (widget.c.pesanan.value.idkontak != null && widget.c.pesanan.value.idlokasi != null && widget.c.pesanan.value.jharga != null && widget.c.pesanan.value.rekkas != null);
  }

  @override
  void dispose() {
    catatanController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  String selectedDate = '';
  // @override
  // void initState() {
  //   widget.c.pesanan.value = widget.item;
  //   selectedDate = formattanggal2(widget.c.pesanan.value.tanggal);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Keranjang',
          // style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          GestureDetector(
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
                            text: 'Lainnya',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.print),
                        title: const Text('Cetak'),
                        onTap: () {
                          // Implementasi untuk mencetak
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.chat),
                        title: const Text('WhatsApp'),
                        onTap: () {
                          // Implementasi untuk berbagi ke WhatsApp
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.share),
                        title: const Text('Bagikan'),
                        onTap: () {
                          // Implementasi untuk berbagi
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Ubah'),
                        onTap: () {
                          // Implementasi untuk mengubah
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Hapus'),
                        onTap: () {
                          // Implementasi untuk menghapus
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headlineTransaksi(),
            if (wessiap && widget.c.pesanan.value.detail != null) _detailTransaksi(),
            _diskon(),
            _ongkosKirim(),
            _totalTransaksi(),
            _inputDataPelanggan(),
            const Divider(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 8, // Menambahkan padding sesuai dengan tinggi keyboard
            left: 8,
            right: 8),
        child: _bottomBar(),
      ),
    );
  }

  Widget _inputDataPelanggan() {
    dp("_inputDataPelanggan");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PilihPelanggan(
                    initial: KONTAK(id: widget.c.pesanan.value.idkontak, kode: widget.c.pesanan.value.kontak, nama: widget.c.pesanan.value.namakontak),
                    onPilih: (selectedPelanggan) async {
                      if (selectedPelanggan != null) {
                        widget.c.pesanan.value.termin = selectedPelanggan.termin;
                        if (selectedPelanggan.termin != null) {
                          if (widget.c.pesanan.value.termin != widget.c.pesanan.value.datatermin?.kode) {
                            widget.c.pesanan.value.datatermin = await getTerminByID(selectedPelanggan.termin);
                          }

                          _tempoController.text = (widget.c.pesanan.value.tempo != null) ? formattanggal(widget.c.pesanan.value.tempo, 'dd/MM/yyyy') : 'Jatuh Tempo';
                        } else {
                          widget.c.pesanan.value.termin = 'CASH';
                          widget.c.pesanan.value.datatermin = TERMIN(kode: 'CASH', nama: 'Cash', hari: 0);
                        }
                        widget.c.pesanan.value.tempo = ((DateTime.tryParse(widget.c.pesanan.value.tanggal ?? '') ?? DateTime.now()).add(Duration(days: widget.c.pesanan.value.datatermin?.hari ?? 0))).toString();
                        _terminController.text = widget.c.pesanan.value.termin ?? 'Pilih Termin';
                        _tempoController.text = (widget.c.pesanan.value.tempo != null) ? formattanggal(widget.c.pesanan.value.tempo, 'dd/MM/yyyy') : 'Jatuh Tempo';
                      }

                      setState(() {
                        dp("TERMIN2 :${widget.c.pesanan.value.datatermin}");
                        if (selectedPelanggan != null) {
                          widget.c.pesanan.value.idkontak = selectedPelanggan.id;
                          widget.c.pesanan.value.kontak = selectedPelanggan.kode;
                          alamatController.text = selectedPelanggan.alamat ?? '';

                          widget.c.pesanan.value.termin = selectedPelanggan.termin;

                          if (selectedPelanggan.desa != null) alamatController.text += "\n${selectedPelanggan.desa}";
                          if (selectedPelanggan.kecamatan != null) alamatController.text += ' - ${selectedPelanggan.kecamatan}';
                          if (selectedPelanggan.kabupaten != null) alamatController.text += '\n${selectedPelanggan.kabupaten}';
                          if (selectedPelanggan.provinsi != null) alamatController.text += ' - ${selectedPelanggan.provinsi}';
                          if (selectedPelanggan.kodepos != null) alamatController.text += '\n${selectedPelanggan.kodepos}';
                          if (selectedPelanggan.telp != null) alamatController.text += '\n${selectedPelanggan.telp}';
                          widget.c.pesanan.value.alamat_kirim = alamatController.text;
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
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: PilihLokasi(
                    initial: LOKASI(id: widget.c.pesanan.value.idlokasi, kode: widget.c.pesanan.value.lokasi),
                    onPilih: (p0) {
                      if (p0 != null) {
                        widget.c.pesanan.value.idlokasi = p0.id;
                        widget.c.pesanan.value.lokasi = p0.kode;
                      }
                    }),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PilihTermin(
                  controller: _terminController,
                  initial: widget.c.pesanan.value.datatermin ?? TERMIN(kode: widget.c.pesanan.value.termin),
                  onPilih: (p0) {
                    setState(() {
                      if (p0 != null) {
                        widget.c.pesanan.value.datatermin = p0;
                        widget.c.pesanan.value.termin = p0.kode;
                        widget.c.pesanan.value.tempo = ((DateTime.tryParse(widget.c.pesanan.value.tanggal ?? '') ?? DateTime.now()).add(Duration(days: p0.hari ?? 0))).toString();
                        _tempoController.text = (widget.c.pesanan.value.tempo != null) ? formattanggal(widget.c.pesanan.value.tempo, 'dd/MM/yyyy') : 'Jatuh Tempo';
                      }
                    });
                  },
                ),
              )
            ],
          ),
          // const SizedBox(height: 5),
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
          // const SizedBox(height: 5),
          Row(
            children: [
              /* Expanded(
                child: PilihHarga(
                  enabled: false,
                  initial: HARGA(kode: widget.c.pesanan.value.jharga),
                  onPilih: (p0) {
                    setState(() {
                      if (p0 != null) {
                        widget.c.pesanan.value.jharga = p0.kode;
                      }
                    });
                  },
                ),
              ), */

              Expanded(
                  child: InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.tryParse(widget.c.pesanan.value.tanggal.toString()) ?? DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Tema().background,
                            colorScheme: ColorScheme.light(primary: Tema().background),
                            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Button color
                          ),
                          child: child!,
                        );
                      });

                  final TimeOfDay? pickedtime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.tryParse(widget.c.pesanan.value.tanggal!) ?? DateTime.now()),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Tema().background,
                            colorScheme: ColorScheme.light(primary: Tema().background),
                            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Button color
                          ),
                          child: child!,
                        );
                      });

                  setState(() {
                    if (pickedtime != null) {
                      DateTime combinedDateTime = DateTime(
                        picked!.year,
                        picked.month,
                        picked.day,
                        pickedtime.hour,
                        pickedtime.minute,
                      );
                      widget.c.pesanan.value.tanggal = combinedDateTime.toString();
                    }
                  });
                },
                child: IgnorePointer(
                  child: CustomTextField(
                    readOnly: true,
                    enabled: true,
                    controller: TextEditingController(text: formattanggal2(widget.c.pesanan.value.tanggal)),
                    label: 'Tanggal Transaksi',
                    suffixIcon: Icons.calendar_month,
                  ),
                ),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.tryParse(widget.c.pesanan.value.tanggal.toString()) ?? DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: Tema().background,
                            colorScheme: ColorScheme.light(primary: Tema().background),
                            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Button color
                          ),
                          child: child!,
                        );
                      });

                  setState(() {
                    if (picked != null) {
                      widget.c.pesanan.value.tempo = picked.toString();
                    }
                  });
                },
                child: IgnorePointer(
                  child: CustomTextField(
                    readOnly: true,
                    enabled: true,
                    controller: _tempoController,
                    label: 'Jatuh Tempo',
                    suffixIcon: Icons.calendar_month,
                  ),
                ),
              )),
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
    );
  }

  Widget _headlineTransaksi() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Produk', style: Theme.of(context).textTheme.bodyMedium),
              Text('Sub Total', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _detailTransaksi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.c.pesanan.value.detail!.length,
            // itemCount: widget.c.pesanan.value.detail?.length ?? 0,
            itemBuilder: (context, index) {
              var item = widget.c.pesanan.value.detail![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 1,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    dense: true,
                    title: CustomTextStandard(
                      text: item.nama,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      maxlines: 2,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextStandard(
                                  text: item.kode ?? '',
                                  color: Colors.grey.shade600,
                                  fontSize: 10,
                                ),
                                CustomTextStandard(
                                  text: '@ ${formatuang(item.harga)} / ${item.satuan}',
                                  color: Colors.grey.shade600,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 30,
                            child: Column(
                              children: [
                                NumberInput2(
                                  initial: '${formatangka(item.proses)}',
                                  onChanged: (p0) async {
                                    item.proses = makeDouble(p0) ?? 0;
                                    item.jumlah = item.harga * (item.proses);
                                    var i = widget.c.pesanan.value.detail?.indexWhere((x) => x.idbarang == item.idbarang);
                                    widget.c.pesanan.value.detail?.removeWhere((x) => x.idbarang == item.idbarang);
                                    widget.c.pesanan.value.detail?.insert(i ?? 0, item);

                                    await widget.c.hitung();
                                    await widget.c.simpan(item);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                              // color: Colors.red,
                              height: 30,
                              width: 80,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomTextStandard(
                                    text: formatuang(item.jumlah),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const Divider(
            indent: 8.0,
            endIndent: 8.0,
          ),
        ],
      ),
    );
  }

  Widget _diskon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Diskon', style: Theme.of(context).textTheme.bodySmall),
              Text(
                formatuang(widget.c.pesanan.value.diskon),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _ongkosKirim() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                formatuang(widget.c.pesanan.value.diskon),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pajak',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'Rp. 0',
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ongkos Kirim',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'Rp. 0',
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _totalTransaksi() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sub Total',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                formatuang(widget.c.pesanan.value.nilai),
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                formatuang(widget.c.pesanan.value.nilaitotal),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Divider(
          thickness: 5,
        ),
      ],
    );
  }

  Widget _bottomBar() {
    // ignore: unused_element
    Future<TRANSAKSI?> _simpan() async {
      widget.c.pesanan.value.kredit = (widget.c.pesanan.value.nilaitotal ?? 0) - (widget.c.pesanan.value.bayar ?? 0);
      TRANSAKSI? res;
      if ((widget.c.pesanan.value.id ?? 0) < 1) {
        res = await getPenjualanController().simpanNewDraft(widget.c.pesanan.value);
      } else {
        res = widget.c.pesanan.value;
      }
      if (res is TRANSAKSI) {
        var ares = await getPenjualanController().simpanDrafttoNota(res);
        if (ares != null) {
          widget.c.pesanan.value = ares;
          return ares;
        }
      }
      return null;
    }

    return Row(
      children: [
        if (_cekkelengkapan())
          IconButton(
            onPressed: () async {
              widget.c.pesanan.value.catatan = catatanController.text;
              dynamic res;
              if ((widget.c.pesanan.value.id ?? 0) < 1) {
                res = await getPenjualanController().simpanNewDraft(widget.c.pesanan.value);
              } else {
                res = await getPenjualanController().updateDraft(widget.c.pesanan.value);
              }
              if (res is TRANSAKSI) {
                Get.offNamedUntil('/penjualan', ModalRoute.withName('/'));
              } else {
                pesanError("Kesalahan dalam menyimpan");
              }
            },
            icon: Icon(Icons.save),
          ),
        SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              /* if ((widget.c.pesanan.value.bayar ?? 0) == 0)
                Expanded(
                    child: ElevatedButton(
                  onPressed: _cekkelengkapan()
                      ? () async {
                          var res = await _simpan();
                          if (res is TRANSAKSI) {
                            Get.offNamedUntil('/penjualan/pembayaran/cetaknotapenjualan', (route) => route.settings.name == '/penjualan', arguments: widget.c.pesanan.value);
                          } else {
                            pesanError("Kesalahan dalam menyimpan");
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Mengatur warna latar belakang tombol
                    foregroundColor: Colors.black, // Mengatur warna teks
                    side: BorderSide(color: Color(0xFF00b3b0)), // Mengatur warna border
                  ),
                  child: Text('Belum Bayar'),
                )),
              SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: () {
                      dp("TRANS: ${widget.c.pesanan.value}");
                    },
                    child: Icon(Icons.abc)),
              ), */
              Expanded(
                child: ElevatedButton(
                  onPressed: _cekkelengkapan()
                      ? () async {
                          var res = await _simpan();
                          if (res is TRANSAKSI) {
                            /* if (iSales()) {
                              var res2 = await getSalesController().resetTransaksi();
                              cBarang(res2).setTransaksi(res2);
                            } */
                            dp("res:$res");
                            dp("transaksi:${widget.c.pesanan.value}");
                            Get.offNamedUntil('/penjualan/pembayaran1', (route) => route.settings.name == '/penjualan', arguments: widget.c.pesanan.value);
                          } else {
                            pesanError("Kesalahan dalam menyimpan");
                          }
                          // Get.toNamed('/penjualan/pembayaran', arguments: widget.c.pesanan.value);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00b3b0),
                  ),
                  child: const CustomTextStandard(
                    text: 'Bayar',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
