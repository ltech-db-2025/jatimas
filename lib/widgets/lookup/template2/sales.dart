import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/database/query.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/widgets/template_paginate_table.dart';

class PilihSales2 extends StatefulWidget {
  final Function(KONTAK?)? onPilih;
  final KONTAK? initial;
  final Widget? child;
  const PilihSales2({super.key, this.initial, this.onPilih, this.child});

  @override
  State<PilihSales2> createState() => _PilihState();
}

class _PilihState extends State<PilihSales2> {
  KONTAK? selected;
  String sql = "SELECT * FROM kontak where p = 1 and aktif = 1 and jabatan = 'SALES' order by nama";
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Expanded(
                  flex: 2,
                  child: CustomTextStandard(
                    text: 'Sales',
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomTextStandard(
                    text: ': ${selected?.kode ?? 'Pilih '}',
                    color: selected == null ? Colors.grey : Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showDialog(context);
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

  void _showDialog(BuildContext context) {
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
                      selected = null; // Mengatur selected menjadi null
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
              // Judul Modal
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Pilih ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              // Daftar
              Expanded(
                child: TablePaginate(
                  filter: ['kode', 'nama'],
                  itemBuilder: (context, itemx, index) {
                    var item = KONTAK.fromMap(itemx.assoc());
                    return ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -4),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextStandard(
                            text: item.kode ?? '',
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                          CustomTextStandard(text: item.nama ?? ''),
                        ],
                      ),
                      subtitle: CustomTextStandard(text: item.alamat ?? ''),
                      onTap: () {
                        selected = item;
                        widget.onPilih?.call(item); // Panggil callback jika ada
                        setState(() {}); // Memperbarui tampilan jika perlu
                        Get.back(result: item); // Kembali dengan hasil
                      },
                    );
                  },
                  sql: sql,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
