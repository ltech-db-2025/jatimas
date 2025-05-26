import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/database/query.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/customtextfield.dart';
import 'package:ljm/widgets/template_paginate_table.dart';
import 'package:ljm/provider/models/kontak.dart';

class PilihPelanggan extends StatefulWidget {
  final Function(KONTAK?)? onPilih;
  final KONTAK? initial;
  final Widget? child;
  const PilihPelanggan({super.key, this.initial, this.onPilih, this.child});

  @override
  State<PilihPelanggan> createState() => _PilihPelangganState();
}

class _PilihPelangganState extends State<PilihPelanggan> {
  KONTAK? selected;
  String sql = "SELECT * FROM kontak where c = 1 and aktif = 1 order by nama";
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    selected = widget.initial;
    if (widget.initial != null) {
      if (widget.initial!.nama == null || widget.initial!.kode == null) {
        selected = await getKontakByID(widget.initial!.id);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: widget.child ??
          IgnorePointer(
              child: CustomTextField(
            readOnly: true,
            controller: TextEditingController(text: selected?.kode ?? 'Pilih Pelanggan'),
            label: 'Pelanggan *',
            suffixIcon: Icons.arrow_forward_ios_outlined,
          )),
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
                    child: const Text('Pilih Pelanggan :', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                      child: TablePaginate(
                          filter: ['kode', 'nama', 'alamat_kirim'],
                          itemBuilder: (context, itemx, index) {
                            var item = KONTAK.fromMap(itemx);
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
