import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/widgets/template_paginate_table.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

class TabView2 extends StatefulWidget {
  final KONTAK data;
  const TabView2(this.data, {super.key});

  @override
  State<TabView2> createState() => _TabView2State();
}

class _TabView2State extends State<TabView2> {
  var sql = '';
  @override
  void initState() {
    sql = """
        SELECT t.*, l.nama as lokasi, s.kode as sales
        FROM transaksi t 
        left join lokasi l on l.id = t.idlokasi 
        left join ktk s on s.id = t.idpegawai
        where t.idkontak = ${widget.data.id} and saldo > 0
      """;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TablePaginate(
          sql: sql,
          itemBuilder: (context, itemx, index) {
            var item = TRANSAKSI.fromMap(itemx);
            return ListTile(
              onTap: () => Get.toNamed('/penjualan/detail', arguments: {"item": item}),
              visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity),
              dense: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50, child: Text(item.id.toString())),
                  SizedBox(width: 100, child: Text(formattanggal(item.tanggal))),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(formatuang(item.nilaitotal)),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
