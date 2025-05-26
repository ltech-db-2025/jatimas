import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/database/query.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/customtextfield.dart';
import 'package:ljm/widgets/template_paginate_table.dart';
import 'package:ljm/provider/models/lokasi.dart';

class PilihLokasi extends StatefulWidget {
  final Function(LOKASI?)? onPilih;
  final LOKASI? initial;
  final Widget? child;
  const PilihLokasi({super.key, this.initial, this.onPilih, this.child});

  @override
  State<PilihLokasi> createState() => _PilihLokasiState();
}

class _PilihLokasiState extends State<PilihLokasi> {
  LOKASI? selected;
  String sql = "SELECT * FROM lokasi where aktif = 1";
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    selected = widget.initial;
    if (widget.initial != null) {
      if (widget.initial!.nama == null || widget.initial!.kode == null) {
        selected = await getLokasiByID(widget.initial!.id);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: widget.child ?? IgnorePointer(child: CustomTextField(readOnly: true, controller: TextEditingController(text: selected?.kode ?? 'Pilih Lokasi'), label: 'Lokasi', suffixIcon: Icons.arrow_forward_ios_outlined)),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.50,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text('Pilih Lokasi :', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                      child: iSales()
                          ? ListView.builder(
                              itemCount: user.akseslokasi?.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                    selectedTileColor: customTema.appBarTheme.backgroundColor,
                                    selected: (user.akseslokasi?[index].idlokasi == selected?.id),
                                    dense: true,
                                    visualDensity: const VisualDensity(vertical: -4),
                                    title: Text(user.akseslokasi?[index].kode ?? ''),
                                    onTap: () {
                                      selected = LOKASI(id: user.akseslokasi?[index].idlokasi, kode: user.akseslokasi?[index].kode, nama: user.akseslokasi?[index].nama);
                                      widget.onPilih?.call(LOKASI(id: user.akseslokasi?[index].idlokasi, kode: user.akseslokasi?[index].kode, nama: user.akseslokasi?[index].nama));
                                      setState(() {});
                                      Get.back(result: LOKASI(id: user.akseslokasi?[index].idlokasi, kode: user.akseslokasi?[index].kode, nama: user.akseslokasi?[index].nama));
                                    });
                              },
                            )
                          : TablePaginate(
                              itemBuilder: (context, itemx, index) {
                                var item = LOKASI.fromMap(itemx);
                                return ListTile(
                                    selectedTileColor: customTema.appBarTheme.backgroundColor,
                                    selected: (item.id == selected?.id),
                                    dense: true,
                                    visualDensity: const VisualDensity(vertical: -4),
                                    title: Text(item.nama ?? ''),
                                    onTap: () {
                                      selected = item;
                                      widget.onPilih?.call(item);
                                      setState(() {});
                                      Get.back(result: item);
                                    });
                              },
                              sql: sql)),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
