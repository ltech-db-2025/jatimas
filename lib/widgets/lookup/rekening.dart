import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/models/keuangan/rekening.dart';
import 'package:ljm/widgets/customtextfield.dart';
import 'package:ljm/widgets/template_paginate_table.dart';

class PilihRekening extends StatefulWidget {
  final Function(REKENING?)? onPilih;
  final REKENING? initial;
  final Widget? child;
  const PilihRekening({super.key, this.initial, this.onPilih, this.child});

  @override
  State<PilihRekening> createState() => _PilihRekeningState();
}

class _PilihRekeningState extends State<PilihRekening> {
  REKENING? selectedRekening;
  String sql = "SELECT kode, akun, alias FROM v_rekening where v = 1";
  @override
  void initState() {
    selectedRekening = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: widget.child ?? IgnorePointer(child: CustomTextField(readOnly: true, controller: TextEditingController(text: selectedRekening?.alias ?? 'Pilih Rekening'), label: 'Rekening', suffixIcon: Icons.arrow_forward_ios_outlined)),
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
                    child: const Text('Pilih Rekening :', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                      child: TablePaginate(
                          filter: ['alias'],
                          itemBuilder: (context, itemx, index) {
                            var item = REKENING.fromMap(itemx);
                            return ListTile(
                                dense: true,
                                visualDensity: const VisualDensity(vertical: -4),
                                title: Text(item.alias ?? ''),
                                onTap: () {
                                  selectedRekening = item;
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
