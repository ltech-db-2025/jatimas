import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/models/termin.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/widgets/template_paginate_table.dart';

class PilihTermin2 extends StatefulWidget {
  final Function(TERMIN?)? onPilih;
  final TERMIN? initial;
  final Widget? child;
  const PilihTermin2({super.key, this.initial, this.onPilih, this.child});

  @override
  State<PilihTermin2> createState() => _PilihTermin2State();
}

class _PilihTermin2State extends State<PilihTermin2> {
  TERMIN? selectedTermin;
  String sql = "SELECT * FROM termin";
  @override
  void initState() {
    selectedTermin = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: widget.child ??
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Expanded(
                  flex: 2,
                  child: CustomTextStandard(
                    text: 'Termin',
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomTextStandard(
                    text: ': ${selectedTermin?.kode ?? 'Pilih Termin'}',
                    color: selectedTermin == null ? Colors.grey : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showDialogTermin(context);
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.blue,
                    size: 20,
                  ),
                )
              ]),
            ));
  }

  void _showDialogTermin(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showModalBottomSheet(context);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit), // Ikon untuk Edit
                      SizedBox(width: 8.0), // Jarak antara ikon dan teks
                      CustomTextStandard(text: "Edit"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedTermin = null; // Mengatur selectedSales menjadi null
                    });
                  },
                  style: ElevatedButton.styleFrom(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: Colors.red), // Ikon untuk Hapus
                      SizedBox(width: 8.0), // Jarak antara ikon dan teks
                      CustomTextStandard(text: "Hapus"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showModalBottomSheet(BuildContext context) {
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
                child: const Text('Pilih Termin', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  child: TablePaginate(
                      filter: ['kode', 'nama'],
                      itemBuilder: (context, itemx, index) {
                        var item = TERMIN.fromMap(itemx.assoc());
                        return ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -4),
                            title: CustomTextStandard(text: item.nama ?? ''),
                            onTap: () {
                              selectedTermin = item;
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
  }
}
