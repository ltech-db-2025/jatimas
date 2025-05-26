import 'dart:io';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
// import 'package:share_plus/share_plus.dart';

class PageCetakNotaPiutang extends StatefulWidget {
  const PageCetakNotaPiutang({super.key});

  @override
  State<PageCetakNotaPiutang> createState() => _PageCetakNotaPiutangState();
}

class _PageCetakNotaPiutangState extends State<PageCetakNotaPiutang> {
  List<TRANSAKSI?> notadibayar = [];
  List<dynamic> dataNota = []; // Initialize as an empty list
  var totalpiutang;
  var bayar;
  @override
  void initState() {
    super.initState();
    // Retrieve arguments from GetX
    dataNota = Get.arguments['data'] ?? [];
    totalpiutang = Get.arguments['totalpiutang'] ?? [];
    bayar = Get.arguments['bayar'] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Cetak Nota Pembayaran Piutang',
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _lingkaran(context),
              _kembalian(context),
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

  Widget _kembalian(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // if ((newtrans.kredit ?? 0) != 0) Text('Kredit ', style: Theme.of(context).textTheme.bodySmall),
        // if ((newtrans.kredit ?? 0) != 0)
        //   Text(
        //     formatuang(newtrans.kredit),
        //     style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
        //   ),
        // if ((newtrans.sisa ?? 0) != 0) Text('Kembalian ', style: Theme.of(context).textTheme.bodySmall),
        // if ((newtrans.sisa ?? 0) != 0)
        //   Text(
        //     formatuang(newtrans.sisa),
        //     style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
        //   ),
      ],
    );
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [Text(formattanggal2(newtrans.tanggal), style: Theme.of(context).textTheme.labelLarge), Text('Kas', style: Theme.of(context).textTheme.labelLarge)],
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [Text(newtrans.notrans ?? '', style: Theme.of(context).textTheme.labelLarge), Text(((newtrans.kredit ?? 0) == 0) ? 'Lunas' : 'Kredit', style: Theme.of(context).textTheme.labelLarge)],
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [Text('Tgl Pembayaran', style: Theme.of(context).textTheme.labelLarge), Text(formattanggal(newtrans.tanggal), style: Theme.of(context).textTheme.labelLarge)],
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [Text('Kepada', style: Theme.of(context).textTheme.labelLarge), Text(newtrans.namakontak ?? '', style: Theme.of(context).textTheme.labelLarge)],
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [Text('Sales', style: Theme.of(context).textTheme.labelLarge), Text(newtrans.pegawai ?? '', style: Theme.of(context).textTheme.labelLarge)],
        // )
      ],
    );
  }

  Widget _detailPenjualan(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Nota'), Text('SubTotal')],
        ),
        Divider(),
        Container(
          height: (dataNota.isNotEmpty ? (dataNota.length * 60).toDouble() : 100),
          child: ListView.builder(
              shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              itemCount: dataNota.length,
              itemBuilder: (context, index) {
                var item = dataNota[index]; // Ambil item yang sesuai

                return Card(
                  elevation: 1,
                  child: ListTile(
                    dense: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Nota ID: ${item.id}'), // Display the Nota ID
                        Text('${formatuang(item.nilaitotal)}'), // Display the formatted total value
                      ],
                    ),
                  ),
                );
              }),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total ${dataNota.length} ITEMS'),
            Text(formatuang(totalpiutang.toDouble())),
          ],
        ),
      ],
    );
  }

  Widget _totalDibayar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Dibayar',
          style: TextStyle(color: Colors.red),
        ),
        Text(formatuang(bayar)),
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
                        onPressed: () async {
                          await _shareNota();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Warna latar belakang tombol
                          side: BorderSide(color: Color(0xFF00b3b0)), // Warna border
                          minimumSize: Size(110, 40), // Mengatur lebar dan tinggi tombol
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ShareImagePage(), // Halaman yang akan dituju
                          //   ),
                          // );

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ReceiptPage(newtrans), // Halaman yang akan dituju
                          //   ),
                          // );
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
                          'Cetak Bluetooth',
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
                onPressed: () {
                  // Tambahkan aksi untuk tombol Buat Transaksi Baru
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

  Future<Uint8List> loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  Future<void> _printNota() async {
    final pdfData = await _generatePdf();
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
  }

  Future<Uint8List> _generatePdf() async {
    final ttf = await rootBundle.load("assets/roboto/Roboto-Regular.ttf");
    final pdf = pw.Document();
    final image = await imageFromAssetBundle('assets/logoleonwarna.png');
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Nota Penjualan', style: pw.TextStyle(fontSize: 24, font: pw.Font.ttf(ttf))),
            pw.SizedBox(height: 20),
            pw.Image(
              image,
              width: 100, // specify the width
              height: 100, // specify the height
              fit: pw.BoxFit.contain, // adjust how the image fits within the bounds
            ),
            pw.SizedBox(height: 20),
            pw.Row(children: [
              pw.SizedBox(width: 100, child: pw.Text('Tanggal', style: pw.TextStyle(font: pw.Font.ttf(ttf)))),
              // pw.SizedBox(width: 100, child: pw.Text(': ${formattanggal(newtrans.tanggal)}', style: pw.TextStyle(font: pw.Font.ttf(ttf)))),
            ]),
            pw.Row(children: [
              pw.SizedBox(width: 100, child: pw.Text('Nama Kontak', style: pw.TextStyle(font: pw.Font.ttf(ttf)))),
              // pw.SizedBox(width: 100, child: pw.Text(': ${newtrans.namakontak}', style: pw.TextStyle(font: pw.Font.ttf(ttf)))),
            ]),
            // pw.Text('Nama Kontak: ${newtrans.namakontak}'),
            // pw.SizedBox(height: 20),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.SizedBox(width: 300, child: pw.Text('Produk', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontWeight: pw.FontWeight.bold, fontSize: 10))),
                pw.SizedBox(width: 20, child: pw.Text('Qty', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontWeight: pw.FontWeight.bold, fontSize: 10))),
                pw.SizedBox(width: 10),
                pw.SizedBox(width: 50, child: pw.Text('Satuan', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontWeight: pw.FontWeight.bold, fontSize: 10))),
                pw.SizedBox(width: 100, child: pw.Text('Harga', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontWeight: pw.FontWeight.bold, fontSize: 10), textAlign: pw.TextAlign.right)),
                pw.SizedBox(width: 80, child: pw.Text('Jumlah', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontWeight: pw.FontWeight.bold, fontSize: 10), textAlign: pw.TextAlign.right)),
                pw.SizedBox(width: 80, child: pw.Text('Pot.', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontWeight: pw.FontWeight.bold, fontSize: 10), textAlign: pw.TextAlign.right)),
                pw.SizedBox(width: 80, child: pw.Text('SubTotal', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontWeight: pw.FontWeight.bold, fontSize: 10), textAlign: pw.TextAlign.right)),
              ],
            ),
            pw.Divider(),
            // Loop through the transaction details
            // for (var item in newtrans.detail!) ...[
            //   pw.Row(
            //     mainAxisAlignment: pw.MainAxisAlignment.start,
            //     children: [
            //       pw.SizedBox(width: 300, child: pw.Text(item.nama, style: pw.TextStyle(font: pw.Font.ttf(ttf), fontSize: 10))),
            //       pw.SizedBox(
            //         width: 20, // Atur lebar untuk qty
            //         child: pw.Align(
            //           alignment: pw.Alignment.center, // Posisikan teks di tengah
            //           child: pw.Text(formatangka(item.proses), style: pw.TextStyle(font: pw.Font.ttf(ttf), fontSize: 10)), // Qty
            //         ),
            //       ),
            //       pw.SizedBox(width: 10),
            //       pw.SizedBox(
            //         width: 50, // Atur lebar untuk qty
            //         child: pw.Text(item.satuan ?? 'Satuan', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontSize: 10)), // Qty
            //       ),
            //       pw.SizedBox(width: 100, child: pw.Text(formatuang(item.harga), style: pw.TextStyle(font: pw.Font.ttf(ttf), fontSize: 10), textAlign: pw.TextAlign.right)),
            //       pw.SizedBox(width: 80, child: pw.Text(formatuang(item.jumlah), style: pw.TextStyle(font: pw.Font.ttf(ttf), fontSize: 10), textAlign: pw.TextAlign.right)),
            //       pw.SizedBox(width: 80, child: pw.Text('', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontSize: 10), textAlign: pw.TextAlign.right)),
            //       pw.SizedBox(width: 80, child: pw.Text(formatuang(item.jumlah), style: pw.TextStyle(font: pw.Font.ttf(ttf), fontSize: 10), textAlign: pw.TextAlign.right)),
            //     ],
            //   ),
            //   pw.SizedBox(height: 4),
            // ],
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                // pw.Text('Total ${newtrans.detail?.length} ITEMS',
                //     style: pw.TextStyle(
                //       font: pw.Font.ttf(ttf),
                //     )),
                // pw.Text(formatuang(newtrans.nilaitotal), style: pw.TextStyle(font: pw.Font.ttf(ttf), fontWeight: pw.FontWeight.bold, fontSize: 12)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Dibayar', style: pw.TextStyle(font: pw.Font.ttf(ttf))),
                // pw.Text(formatuang(newtrans.bayar), style: pw.TextStyle(font: pw.Font.ttf(ttf))),
              ],
            ),
            pw.SizedBox(height: 40),
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Text('Terima Kasih atas Kepercayaan Anda', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontSize: 16)),
                  pw.Text('--- Happy Shopping ---', style: pw.TextStyle(font: pw.Font.ttf(ttf), fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return pdf.save(); // Return the PDF data as Uint8List
  }

  Future<void> _shareNota() async {
    final pdfData = await _generatePdf();

    // Save the PDF file temporarily
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/nota_penjualan.pdf';
    final file = File(filePath);
    await file.writeAsBytes(pdfData);

    // Share the PDF file
    // await Share.shareXFiles([XFile(filePath)], text: 'Check out this Nota Penjualan!');
  }
}
