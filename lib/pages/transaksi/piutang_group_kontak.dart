import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/widgets/template_paginate_table.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

class ListPiutangByKontak extends StatelessWidget {
  final String title;
  final KONTAK? sales;
  final bool tempoonly;
  const ListPiutangByKontak({super.key, this.sales, this.title = 'Daftar Piutang', this.tempoonly = false});

  @override
  Widget build(BuildContext context) {
    var jttempo = '';
    if (tempoonly) jttempo = " and p.tempo <= CURRENT_DATE ";
    var idpegawai = (sales == null) ? '' : "and p.idpegawai = ${sales?.id ?? '0'}";
    return Scaffold(
      appBar: AppBar(
        title: CustomTextStandard(text: title, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: TablePaginate(
        title: title,
        sql: """
            select count(p.id) qty, 
            count(case when p.tempo <= CURRENT_DATE then p.id END) rekkredit,
            p.idkontak, k.kode kontak, k.nama namakontak, sum(p.saldo) kredit 
            from transaksi p inner join ktk k on p.idkontak = k.id
            WHERE p.saldo > 0 and kdtrans = 'PJ' $idpegawai $jttempo
              GROUP BY k.kode, p.idkontak, k.nama
              
            """,
        order: "k.kode",
        filter: ["k.kode", "k.nama"],
        itemBuilder: (context, itemx, index) {
          var item = TRANSAKSI.fromMap(itemx);

          return ListTile(
              title: Row(
                children: [
                  Expanded(child: CustomTextStandard(text: item.kontak ?? '', maxlines: 2)),
                  CustomTextStandard(text: formatuang(item.kredit)),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextStandard(text: '${formatangka(item.qty)} Invoice', color: Colors.grey),
                  Row(
                    children: [
                      const CustomTextStandard(text: 'Jatuh Tempo', color: Colors.grey),
                      const SizedBox(width: 5),
                      CustomTextStandard(text: '${formatangka(item.rekkredit)} Invoice', color: Colors.red),
                    ],
                  )
                ],
              ),
              onTap: () {
                item.nilaitotal = item.kredit;
                Get.toNamed('/piutang', arguments: {
                  "sales": sales,
                  "title": 'Daftar Piutang ${item.kontak}',
                  "params": item.copyWith(nilaitotal: item.kredit),
                }); /*() => ListPiutang(
                      sales: sales,
                      title: 'Daftar Piutang ${item.kontak}',
                      params: item.copyWith(total: item.kredit),
                    ));*/
              });
        },
      ),
    );
  }
}
