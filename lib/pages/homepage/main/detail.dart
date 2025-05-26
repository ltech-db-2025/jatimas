import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/homepage/widgets/editor.dart';
import 'package:ljm/pages/homepage/widgets/plusminus.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/tools/env.dart';

class DetailItemJual extends StatefulWidget {
  final DETAIL item;
  const DetailItemJual(this.item, {super.key});

  @override
  State<DetailItemJual> createState() => _DetailItemJualState();
}

class _DetailItemJualState extends State<DetailItemJual> {
  DETAIL item = DETAIL();
  @override
  void initState() {
    item = widget.item.copyWith(
      jumlah: widget.item.harga * widget.item.proses,
      total: item.jumlah - widget.item.diskon,
    );
    super.initState();
  }

  _hitung() {
    double diskon2 = double.tryParse(item.diskon2.toString()) ?? 0;
    item.jumlah = (item.harga) * (item.proses);
    //item.jumlahnota = (item.harga) * (item.qtynota);
    item.diskon = (diskon2 != 0) ? (item.jumlah * diskon2) / 100 : 0;
    // item.diskonnota = (diskon2 != 0) ? (item.jumlahnota * diskon2) / 100 : 0;
    //item.total = item.jumlah - item.diskon;
    // item.totalnota = item.jumlahnota - item.diskonnota;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.nama), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('*Diskon Update otomatis berdasarkan %', style: TextStyle(color: Colors.red, fontSize: 14 * sf)),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 1,
                    child: editorangka(context, "Harga Jual (Rp.)", formatangka(item.harga.toString()), onSubmit: (p0) {
                      item.harga = double.tryParse(p0) ?? 0;
                      _hitung();
                    })),
                Flexible(flex: 1, child: editor(context, item.satuan, label: "Satuan", onChanged: null, enabled: false)),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                    flex: 1,
                    child: editorangka(context, "Diskon (%)", formatangka(item.diskon2.toString()), onSubmit: (p0) {
                      item.diskon2 = p0;
                      _hitung();
                    })),
                Flexible(flex: 1, child: editorangka(context, "Diskon (Rp.)", formatangka(item.diskon.toString()), enabled: false)),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(flex: 1, child: editorangka(context, "Jumlah (Rp.)", formatangka(item.jumlah.toString()), enabled: false)),
                Flexible(flex: 1, child: Container()),
              ],
            ),
            editor(context, item.keterangan, label: "Keterangan", onChanged: (p0) => setState(() => item.keterangan = p0)),
            const SizedBox(height: 20 * sf),
            Center(
              child: PlusMinusButtons(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                size: 2,
                add: () {
                  item.proses = (item.proses) + 1;
                  _hitung();
                },
                min: () {
                  item.proses = (item.proses) - 1;
                  _hitung();
                },
                nilai: item.proses,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Simpan'),
            BottomNavigationBarItem(icon: Icon(Icons.cancel), label: 'Batal'),
          ],
          onTap: (int index) {
            // Tambahkan aksi yang sesuai untuk setiap tombol di sini
            if (index == 0) {
              Get.back(result: item);
            } else if (index == 1) {
              Get.back();
            }
          },
        ),
      ),
      // resizeToAvoidBottomInset: true,
    );
  }
}
