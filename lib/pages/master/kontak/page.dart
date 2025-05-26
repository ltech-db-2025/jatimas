import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/template_paginate_table.dart';

class PageKontak extends StatelessWidget {
  final Function(KONTAK)? onClick;
  const PageKontak({this.onClick, super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(skala)),
      child: Scaffold(
        // appBar: AppBar(title: const Text('Daftar Pelanggan')),
        body: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TablePaginate2(
                itemBuilder: (context, item, index) {
                  var itemx = KONTAK.fromMap(item);
                  return _kontaklisttile2(index, itemx, onClick: onClick);
                },
                sql: "select * from kontak where c = 1 and aktif = 1 order by nama")),
      ),
    );
  }
}

Widget _kontaklisttile2(int index, KONTAK model, {final Function(KONTAK)? onClick}) {
  //Kontak model = listdata!;
  return Column(
    children: [
      Divider(),
      InkWell(
          onTap: () {
            if (onClick != null) {
              onClick(model);
            } else {
              Get.toNamed('/kontak/pelanggan/detail', arguments: {"judul": model.nama ?? '', "kontak": model});
            }
          },
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      model.nama ?? '',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '12',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Rp 100.000',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    ],
  );
}
