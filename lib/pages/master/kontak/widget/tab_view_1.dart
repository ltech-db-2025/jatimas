import 'package:flutter/material.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/tools/env.dart';

import 'custom_text_pelanggan.dart';

class TabView1 extends StatefulWidget {
  final KONTAK data;
  const TabView1(this.data, {super.key});

  @override
  State<TabView1> createState() => _TabView1State();
}

class _TabView1State extends State<TabView1> {
  var alamat = '';
  @override
  void initState() {
    alamat = widget.data.alamat ?? '';
    if (widget.data.desa != null) alamat = '$alamat\n${widget.data.desa!}';
    if (widget.data.kecamatan != null) alamat = '$alamat - ${widget.data.kecamatan!}';
    if (widget.data.kabupaten != null) alamat = '$alamat\n${widget.data.kabupaten!}';
    if (widget.data.provinsi != null) alamat = '$alamat - ${widget.data.provinsi!}';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Center(child: CircleAvatar(radius: 40, backgroundColor: Color(0xFF00b3b0), child: Icon(Icons.people, color: Colors.white, size: 48))),
            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Center(child: CustomTextStandard(text: widget.data.perusahaan ?? widget.data.nama ?? '', fontSize: 16, fontWeight: FontWeight.bold))),
            Center(child: CustomTextStandard(text: widget.data.kode ?? '')),
            const SizedBox(height: 10),
            const Padding(padding: EdgeInsets.all(8.0), child: CustomTextStandard(text: 'Info Umum', fontWeight: FontWeight.bold)),
            const Divider(),
            CTPelanggan(text1: 'Kategori Pelanggan', text2: widget.data.kategori ?? ''),
            const CTPelanggan(text1: 'Kategori Harga', text2: 'Umum'),
            const CTPelanggan(text1: 'Kategori Diskon', text2: 'Umum'),
            const CTPelanggan(text1: 'Cabang', text2: 'Semua Cabang'),
            const SizedBox(height: 10),
            const Padding(padding: EdgeInsets.all(8.0), child: CustomTextStandard(text: 'Kontak', fontWeight: FontWeight.bold)),
            const Divider(),
            CTPelanggan(text1: 'No. Telepon Bisnis', text2: widget.data.telp ?? ''),
            CTPelanggan(text1: 'Alamat Pengiriman', text2: alamat),
            const SizedBox(height: 10),
            const Padding(padding: EdgeInsets.all(8.0), child: CustomTextStandard(text: 'Pajak', fontWeight: FontWeight.bold)),
            const Divider(),
            const CTPelanggan(text1: 'NPWP', text2: '-'),
            const CTPelanggan(text1: 'NIK', text2: '-'),
            CTPelanggan(text1: 'Nama Wajib Pajak', text2: widget.data.nama ?? ''),
            const SizedBox(height: 10),
            const Padding(padding: EdgeInsets.all(8.0), child: CustomTextStandard(text: 'Piutang', fontWeight: FontWeight.bold)),
            const Divider(),
            CTPelanggan(text1: 'Total Piutang', text2: formatuang(widget.data.piutang)),
            CTPelanggan(text1: 'Piutang Terlama', text2: '${formatangka(widget.data.saldoawal)} Hari', color2: Colors.red),
            const CTPelanggan(text1: 'Rata-rata Lama Pembayaran', text2: '?? Hari', color2: Colors.red),
            const SizedBox(height: 10),
            const Padding(padding: EdgeInsets.all(8.0), child: CustomTextStandard(text: 'Penjualan', fontWeight: FontWeight.bold)),
            const Divider(),
            CTPelanggan(text1: 'Transaksi Terahir', text2: formattanggal(widget.data.updated, 'EEEE, dd/MM/yyyy HH:mm')),
            CTPelanggan(text1: 'Penjualan Bulan Ini', text2: formatuang(widget.data.plafon), fontWeight2: FontWeight.bold),
            CTPelanggan(text1: 'Rata-rata Penjualan Per Bulan', text2: formatuang(widget.data.hutang), fontWeight2: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
