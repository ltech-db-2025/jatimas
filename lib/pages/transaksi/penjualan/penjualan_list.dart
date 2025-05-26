import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/widgets/template_paginate_table.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'lunas':
      return Colors.green;
    case 'belum lunas':
      return Colors.pink;
    case 'belum bayar':
      return Colors.red;
    default:
      return Colors.black;
  }
}

class ListPenjualan extends StatelessWidget {
  final KONTAK? sales;
  final TRANSAKSI? invoice;
  final bool semuaNota;
  const ListPenjualan({this.invoice, this.sales, this.semuaNota = true, super.key});

  @override
  Widget build(BuildContext context) {
    var order = "p.id desc";

    String sql = '';
    var idpegawai = (sales == null) ? '' : "and p.idpegawai = ${sales?.id ?? 'null'}";
    if (semuaNota || invoice == null) {
      sql = """
        select p.id, p.tanggal, p.idlokasi, p.lokasi, p.idpegawai, p.pegawai, p.idkontak, p.kontak, p.iddevisi, p.devisi,
          p.nilai, p.diskon, p.nilaitotal, p.tempo
        from transaksi p            
        WHERE p.id is not null and kdtrans = 'PJ' $idpegawai """;
      // EXTRACT(MONTH FROM tanggal) = EXTRACT(MONTH FROM CURRENT_DATE)AND EXTRACT(YEAR FROM tanggal) = EXTRACT(YEAR FROM CURRENT_DATE)
    } else {
      sql = (sales != null)
          ? """
        select p.id, p.tanggal, p.idlokasi, p.lokasi, p.idpegawai, p.pegawai, p.idkontak, p.kontak, p.iddevisi, p.devisi,
          p.nilai, p.diskon, p.nilaitotal, p.tempo
        from transaksi p 
        WHERE kdtrans = 'PJ' and idpegawai = ${sales?.id} and Date(p.tanggal) = Date('${invoice?.tanggal}')"""
          : """
          select p.id, p.tanggal, p.idlokasi, p.lokasi, p.idpegawai, p.pegawai, p.idkontak, p.kontak, p.iddevisi, p.devisi,
            p.nilai, p.diskon, p.nilaitotal, p.tempo
            from transaksi p 
            WHERE kdtrans = 'PJ' and Date(p.tanggal) = Date('${invoice?.tanggal}')
        """;
    }

    return Scaffold(
      appBar: AppBar(
        title: CustomTextStandard(
          text: semuaNota || invoice == null ? 'Semua Invoice' : 'Invoice ${formattanggal(invoice?.tanggal, 'EEEE, dd/MM/yyyy')}',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: TablePaginate(
          sql: sql,
          filter: ['ktk,nama', 'ktk.kode', 'p.id'],
          order: order,
          itemBuilder: (context, itemx, index) {
            var item = TRANSAKSI.fromMap(itemx);
            return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(Icons.note_alt_outlined, color: Colors.white),
                ),
                title: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextStandard(
                            text: item.kontak ?? '',
                            fontWeight: FontWeight.bold,
                            maxlines: 2,
                          ),
                          CustomTextStandard(
                            text: 'Invoice: ${item.id}',
                            fontSize: 10.0,
                            color: Colors.grey,
                          ),
                          CustomTextStandard(
                            text: 'Tanggal: ${formattanggal(item.tanggal, 'dd/MM/yyyy HH:mm')}',
                            fontSize: 10.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (sales == null) CustomTextStandard(text: item.sales ?? ''),
                          CustomTextStandard(
                            text: '${formatuang(item.nilai)}',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                          if (item.status != null)
                            CustomTextStandard(
                              text: item.status.toString(),
                              fontSize: 12.0,
                              color: getStatusColor(item.status.toString()),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () => Get.toNamed('/penjualan/rincian', arguments: {'item': item}) //InvoiceItemDetailPage(item: item),{

                );
          }),
    );
  }
}
