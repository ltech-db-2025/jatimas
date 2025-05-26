import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/homepage/sales/controller.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'listbarangbarangcontroller.dart';

class PageCetakNotaPenjualan extends StatefulWidget {
  final TRANSAKSI data;
  const PageCetakNotaPenjualan(this.data, {super.key});

  @override
  State<PageCetakNotaPenjualan> createState() => _PageCetakNotaPenjualanState();
}

class _PageCetakNotaPenjualanState extends State<PageCetakNotaPenjualan> {
  TRANSAKSI newtrans = TRANSAKSI();
  @override
  void initState() {
    newtrans = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Cetak Nota Penjualan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _lingkaran(context),
              ..._kembalian(context),
              _logo(context),
              _barisSatu(context),
              SizedBox(
                height: 10,
              ),
              _detailPenjualan(context),
              _totalDibayar(context),
              _terimaKasih(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _tombolOk(context),
    );
  }

  Widget _lingkaran(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 60.0, // Lebar lingkaran
            height: 60.0, // Tinggi lingkaran
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Membuat lingkaran
              color: Colors.green, // Warna latar belakang lingkaran
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00b3b0), // Warna bayangan
                  blurRadius: 5.0, // Jarak blur bayangan
                  spreadRadius: 1.0, // Seberapa jauh bayangan menyebar
                  offset: Offset(0, 2), // Mengatur posisi bayangan
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.check, // Ikon centang
                color: Colors.white, // Warna ikon
                size: 30.0, // Ukuran ikon
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Berhasil', style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
    );
  }

  List<Widget> _kembalian(BuildContext context) {
    return [
      if ((newtrans.kredit ?? 0) != 0)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Kredit ', style: Theme.of(context).textTheme.bodySmall),
            Text(
              formatuang(newtrans.kredit),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      if ((newtrans.sisa ?? 0) != 0)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Kembalian ', style: Theme.of(context).textTheme.bodySmall),
            Text(
              formatuang(newtrans.sisa),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        )
    ];
  }

  Widget _logo(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/logoleonwarna.png", // Ganti dengan path yang sesuai
        height: 200, // Atur tinggi gambar sesuai kebutuhan
        width: 200, // Atur lebar gambar sesuai kebutuhan
      ),
    );
  }

  Widget _barisSatu(BuildContext context) {
    return Column(
      children: [
        if ((newtrans.bayar ?? 0) > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(formattanggal2(newtrans.tanggal)), Text(newtrans.akunkas ?? '')],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(newtrans.notrans ?? ''), Text((((newtrans.nilaitotal ?? 0) - (newtrans.bayar ?? 0)) == 0) ? 'Lunas' : 'Kredit')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Tgl Pembayaran'), Text(formattanggal(newtrans.tanggal))],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Kepada'), Text(newtrans.namakontak ?? '')],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Sales'), Text(newtrans.pegawai ?? '')],
        )
      ],
    );
  }

  Widget _detailPenjualan(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Produk'), Text('SubTotal')],
        ),
        Divider(),
        Container(
          height: newtrans.detail!.length * 70,
          child: ListView.builder(
              shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              itemCount: newtrans.detail!.length,
              itemBuilder: (context, index) {
                var item = newtrans.detail![index];
                return Card(
                  elevation: 1,
                  child: ListTile(
                    dense: true,
                    title: CustomTextStandard(
                      text: item.nama,
                      fontSize: 10,
                      maxlines: 2,
                    ),
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextStandard(
                                    text: item.kode ?? '',
                                    color: Colors.grey.shade600,
                                    fontSize: 10,
                                  ),
                                  CustomTextStandard(
                                    text: item.merk ?? '',
                                    color: (item.merk == 'OLIKE')
                                        ? Colors.orange.shade300
                                        : (item.merk == 'ORAIMO')
                                            ? const Color.fromARGB(255, 4, 252, 16)
                                            : (item.merk == 'BASEUS')
                                                ? Colors.yellow
                                                : Colors.white,
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                              CustomTextStandard(
                                text: '${formatangka(item.qty)} ${item.satuan} @ ${formatuang(item.harga)}',
                                color: Colors.grey.shade600,
                                fontSize: 10,
                              ),
                            ],
                          ),
                        ),
                        // CustomTextStandard(text: formatuang(item.jumlah), fontSize: 10)
                      ],
                    ),
                    trailing: CustomTextStandard(text: formatuang(item.jumlah), fontSize: 10),
                  ),
                );
              }),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total ${newtrans.detail?.length} ITEMS'),
            Text(formatuang(newtrans.nilaitotal)),
          ],
        ),
      ],
    );
  }

  Widget _totalDibayar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Dibayar'),
        Text(formatuang(newtrans.bayar)),
      ],
    );
  }

  Widget _terimaKasih(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text('Terima Kasih atas Kepercayaan Anda'),
          Text('--- Happy Shopping ---'),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _tombolOk(BuildContext context) {
    return Container(
        height: 100,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Mengatur ukuran kolom agar minimal
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Mengatur jarak antar tombol
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await _printNota();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Warna latar belakang tombol
                          side: BorderSide(color: Color(0xFF00b3b0)), // Warna border
                          // minimumSize: Size(100, 30), // Mengatur lebar dan tinggi tombol
                        ),
                        icon: Icon(
                          Icons.print,
                          size: 18,
                          color: Color(0xFF00b3b0), // Warna ikon
                        ),
                        label: Text(
                          'Print',
                          style: TextStyle(color: Color(0xFF00b3b0)), // Warna teks
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Tambahkan aksi untuk tombol Bagikan
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Warna latar belakang tombol
                          side: BorderSide(color: Color(0xFF00b3b0)), // Warna border
                          minimumSize: Size(100, 40), // Mengatur lebar dan tinggi tombol
                        ),
                        icon: Icon(
                          Icons.share, size: 18,
                          color: Color(0xFF00b3b0), // Warna ikon
                        ),
                        label: Text(
                          'Bagikan',
                          style: TextStyle(color: Color(0xFF00b3b0)), // Warna teks
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8), // Memberikan jarak antara row dan tombol berikutnya
            Container(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (iSales()) {
                    getSalesController().activePage.value = 1;
                    var res = await getSalesController().resetTransaksi();
                    cBarang(res).setTransaksi(res);
                  }
                  Get.offNamedUntil('/home', (route) => route.settings.name == '/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Border radius 0
                  ),
                ),
                child: Text(
                  'Buat Transaksi Baru',
                  style: TextStyle(
                    color: Colors.white, // Warna teks
                    fontSize: 14, // Ukuran font
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> _printNota() async {
    final pdfData = await _generatePdf();
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
  }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Nota Penjualan', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Text('Tanggal: ${formattanggal(newtrans.tanggal)}'),
            pw.Text('Nama Kontak: ${newtrans.namakontak}'),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.SizedBox(width: 300, child: pw.Text('Produk', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10))),
                pw.SizedBox(width: 20, child: pw.Text('Qty', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10))),
                pw.SizedBox(width: 10),
                pw.SizedBox(width: 50, child: pw.Text('Satuan', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10))),
                pw.SizedBox(width: 100, child: pw.Text('Harga', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10), textAlign: pw.TextAlign.right)),
                pw.SizedBox(width: 80, child: pw.Text('Jumlah', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10), textAlign: pw.TextAlign.right)),
                pw.SizedBox(width: 80, child: pw.Text('Pot.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10), textAlign: pw.TextAlign.right)),
                pw.SizedBox(width: 80, child: pw.Text('SubTotal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10), textAlign: pw.TextAlign.right)),
              ],
            ),
            pw.Divider(),
            // Loop through the transaction details
            for (var item in newtrans.detail!) ...[
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.SizedBox(width: 300, child: pw.Text(item.nama, style: pw.TextStyle(fontSize: 10))),
                  pw.SizedBox(
                    width: 20, // Atur lebar untuk qty
                    child: pw.Align(
                      alignment: pw.Alignment.center, // Posisikan teks di tengah
                      child: pw.Text(formatangka(item.qty), style: pw.TextStyle(fontSize: 10)), // Qty
                    ),
                  ),
                  pw.SizedBox(width: 10),
                  pw.SizedBox(
                    width: 50, // Atur lebar untuk qty
                    child: pw.Text(item.satuan ?? 'Satuan', style: pw.TextStyle(fontSize: 10)), // Qty
                  ),
                  pw.SizedBox(width: 100, child: pw.Text(formatuang(item.harga), style: pw.TextStyle(fontSize: 10), textAlign: pw.TextAlign.right)),
                  pw.SizedBox(width: 80, child: pw.Text(formatuang(item.jumlah), style: pw.TextStyle(fontSize: 10), textAlign: pw.TextAlign.right)),
                  pw.SizedBox(width: 80, child: pw.Text('', style: pw.TextStyle(fontSize: 10), textAlign: pw.TextAlign.right)),
                  pw.SizedBox(width: 80, child: pw.Text(formatuang(item.jumlah), style: pw.TextStyle(fontSize: 10), textAlign: pw.TextAlign.right)),
                ],
              ),
              pw.SizedBox(height: 4),
            ],
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total ${newtrans.detail?.length} ITEMS'),
                pw.Text(formatuang(newtrans.nilaitotal), style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Dibayar'),
                pw.Text(formatuang(newtrans.bayar)),
              ],
            ),
          ],
        ),
      ),
    );

    return pdf.save(); // Return the PDF data as Uint8List
  }
}
