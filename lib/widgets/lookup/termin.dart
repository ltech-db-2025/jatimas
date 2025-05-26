import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/widgets/customtextfield.dart';
import 'package:ljm/provider/models/termin.dart';
import 'package:ljm/widgets/template_paginate_table.dart';

class PilihTermin extends StatefulWidget {
  final Function(TERMIN?)? onPilih;
  final TERMIN? initial;
  final Widget? child;
  final TextEditingController? controller;
  const PilihTermin({super.key, this.controller, this.initial, this.onPilih, this.child});

  @override
  State<PilihTermin> createState() => _PilihTerminState();
}

class _PilihTerminState extends State<PilihTermin> {
  TERMIN? selectedTermin;
  String sql = "SELECT * FROM termin";
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    selectedTermin = widget.initial;
    _controller = TextEditingController(text: selectedTermin?.kode ?? 'Pilih Termin');
    if (widget.controller != null) _controller = widget.controller!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: widget.child ??
          IgnorePointer(
            child: CustomTextField(
              readOnly: true,
              controller: _controller,
              label: 'Termin',
              suffixIcon: Icons.arrow_forward_ios_outlined,
            ),
          ),
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
                    child: const Text('Pilih Termin :', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                      child: TablePaginate(
                          filter: ['kode', 'nama'],
                          itemBuilder: (context, itemx, index) {
                            var item = TERMIN.fromMap(itemx);
                            return ListTile(
                                dense: true,
                                visualDensity: const VisualDensity(vertical: -4),
                                title: Text(item.nama ?? ''),
                                onTap: () {
                                  selectedTermin = item;
                                  widget.onPilih?.call(item);
                                  setState(() {
                                    _controller = TextEditingController(text: selectedTermin?.kode ?? 'Pilih Termin');
                                  });
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
