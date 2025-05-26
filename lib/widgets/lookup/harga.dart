import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/database/query.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/customtextfield.dart';
import 'package:ljm/widgets/template_paginate_table.dart';
import 'package:ljm/provider/models/harga.dart';

class PilihHarga extends StatefulWidget {
  final Function(HARGA?)? onPilih;
  final HARGA? initial;
  final Widget? child;
  final bool enabled;
  const PilihHarga({super.key, this.initial, this.onPilih, this.enabled = true, this.child});

  @override
  State<PilihHarga> createState() => _PilihHargaState();
}

class _PilihHargaState extends State<PilihHarga> {
  HARGA? selected;
  String sql = "SELECT * FROM harga where publik = 1";
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    selected = widget.initial;
    if (widget.initial != null) {
      if (widget.initial!.nama == null) {
        selected = await getHargaByID(widget.initial!.kode);
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
              controller: TextEditingController(text: selected?.nama ?? 'Pilih Harga'),
              label: 'Harga',
              suffixIcon: Icons.arrow_forward_ios_outlined,
            ),
          ),
      onTap: () {
        if (widget.enabled)
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
                      child: const Text('Pilih Harga :', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                        child: TablePaginate(
                            itemBuilder: (context, itemx, index) {
                              var item = HARGA.fromMap(itemx);
                              return ListTile(
                                  selectedTileColor: customTema.appBarTheme.backgroundColor,
                                  selected: (item.kode == selected?.kode),
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
