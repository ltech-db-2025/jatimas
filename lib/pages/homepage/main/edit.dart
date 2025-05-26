import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/homepage/main/controller.dart';
import 'package:ljm/pages/homepage/widgets/editor.dart';
import 'package:ljm/tools/env.dart';

class DetailJualPage extends StatelessWidget {
  const DetailJualPage({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.find<MainController>();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Keranjang')),
      body: Obx(
        () => Column(
          children: [
            Text(c.nTotal.toString(), style: const TextStyle(color: Colors.white, fontSize: 1)),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Barang'), Align(alignment: Alignment.centerRight, child: Text("Subtotal"))],
              ),
            ),
            /*   Expanded(
                child: (c.keranjang.isEmpty)
                    ? const Center(child: Text('KOSONG'))
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider(thickness: 1, height: 2);
                        },
                        itemCount: c.keranjang.length,
                        itemBuilder: (context, index) {
                          double jumlah = c.keranjang[index].harga * c.keranjang[index].proses;
                          double jumlahnota = c.keranjang[index].harga * c.keranjang[index].qtynota;
                          // ignore: unused_local_variable
                          double total = jumlah - c.keranjang[index].diskon;
                          // ignore: unused_local_variable
                          double totalnota = jumlahnota - c.keranjang[index].diskonnota;
                          var brg = dbc.mBarang.firstWhere((element) => element.id == c.keranjang[index].idbarang, orElse: () => Barang());
                          return InkWell(
                              onTap: () async {
                                var res = await Get.to(() => DetailItemJual(c.keranjang[index]));
                                if (res is DetailDraft) {
                                  c.keranjang[index] = res;
                                  await c.keranjang[index].simpanLocal();
                                  await c.hitung();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0 * sf),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(brg.nama, textScaler: const TextScaler.linear(sf)),
                                        RichText(
                                          textScaler: const TextScaler.linear(sf),
                                          text: TextSpan(
                                            style: TextStyle(color: Colors.blueGrey.shade800),
                                            children: [
                                              TextSpan(text: formatangka(c.keranjang[index].proses.toString())),
                                              const TextSpan(text: " x Rp. "),
                                              TextSpan(text: formatangka(c.keranjang[index].harga.toString())),
                                              if (c.keranjang[index].idsatuan != null) TextSpan(text: " /${brg.satuan}"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: RichText(
                                            textScaler: const TextScaler.linear(sf),
                                            text: TextSpan(
                                              style: const TextStyle(color: Colors.black),
                                              text: 'Rp. ',
                                              children: [
                                                TextSpan(text: formatangka(total)),
                                              ],
                                            )))
                                  ],
                                ),
                              ));
                        })),
            ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(thickness: 1, height: 2);
                },
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      (i == 1) ? _showDiskon(c, context) : null;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        RichText(
                          textScaler: const TextScaler.linear(sf),
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            //text: i.toString(),
                            children: (i == 0)
                                ? [
                                    const WidgetSpan(
                                      child: Icon(Icons.money, size: 20.0, color: Colors.black),
                                    ),
                                    const TextSpan(text: ' Subtotal '),
                                  ]
                                : (i == 1)
                                    ? [
                                        const WidgetSpan(
                                          child: Icon(Icons.discount_outlined, size: 20.0, color: Colors.black),
                                        ),
                                        const TextSpan(text: ' Diskon '),
                                        TextSpan(text: formatter.format(double.tryParse(c.jual.value.pdiskon.toString()) ?? 0)),
                                        const TextSpan(text: ' %'),
                                      ]
                                    : (i == 2)
                                        ? [
                                            const WidgetSpan(
                                              child: Icon(Icons.discount_outlined, size: 20.0, color: Colors.black),
                                            ),
                                            const TextSpan(text: ' Ongkos Kirim '),
                                          ]
                                        : [
                                            const TextSpan(text: 'Total '),
                                          ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              textScaler: const TextScaler.linear(sf),
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  const TextSpan(text: 'Rp. '),
                                  TextSpan(
                                      text: (i == 0)
                                          ? formatangka(c.subtotal.toString())
                                          : (i == 1)
                                              ? formatangka(c.jual.value.diskon.toString())
                                              : (i == 2)
                                                  ? '0.0'
                                                  : formatangka(c.total.value.toString()),
                                      style: TextStyle(fontWeight: FontWeight.bold, color: (i == 1 && c.jual.value.diskon > 0) ? Colors.red : Colors.black)),
                                ],
                              ),
                            )),
                      ]),
                    ),
                  );
                })
          */
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
        child: const Text('Proses'),
        onPressed: () {
          _showBottomSheet(c, context, 'judul');
        },
      ),
    );
  }

  _showBottomSheet(MainController c, BuildContext context, String judul) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              height: 280.0,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: mainColor,
                    width: double.infinity,
                    child: const Text('Proses Pembayaran', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DatePickerTextFieldWidget(
                              label: "Tanggal",
                              selectedDate: DateTime.now(),
                              onDateChanged: (a) => c.jual.value.tanggal = a.toIso8601String(),
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DatePickerTextFieldWidget(
                              label: "Tempo",
                              selectedDate: DateTime.now(),
                              onDateChanged: (a) => c.jual.value.tempo = a.toIso8601String(),
                            ),
                          ))
                    ],
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.people),
                          hintText: 'Pelanggan',
                        ),
                        controller: TextEditingController(text: c.kontak.value.nama ?? ''),
                        readOnly: true,
                        onTap: () async {
                          await Get.to(() => /* CustomerPage */ (
                                onClick: (p0) {
                                  dp("costomer: ${p0.id}, nama: ${p0.nama}");
                                  c.jual.value.idkontak = p0.id;
                                  c.jual.value.kontak = p0.nama ?? '';
                                  c.kontak.value = p0;
                                  c.update();
                                },
                              ));
                        },
                      ),
                    ),
                  ),
                  editor(context, c.jual.value.catatan, hint: 'Catatan', onChanged: (p0) => c.jual.value.catatan = p0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: mainColor),
                          child: const Text('Batal'),
                        ),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ElevatedButton(
                          onPressed: () async {
                            final res = await c.simpan2();
                            if (res == true) {
                              Get.back();
                              Get.back(result: true);
                              Get.snackbar('title', 'Ok');
                            } else {
                              Get.snackbar('title', 'Error');
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: mainColor, foregroundColor: Colors.white),
                          child: const Text('Simpan'),
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class DiskonScreen extends StatefulWidget {
  final MainController c;
  const DiskonScreen(this.c, {super.key});

  @override
  State<DiskonScreen> createState() => _DiskonScreenState();
}

class _DiskonScreenState extends State<DiskonScreen> {
  late MainController c;
  double diskon = 0;
  double pdiskon = 0;
  double subtotal = 0;
  double total = 0;
  TextEditingController cpdiskon = TextEditingController();
  TextEditingController cdiskon = TextEditingController();
  @override
  void initState() {
    c = widget.c;

    diskon = c.jual.value.diskon ?? 0;
    pdiskon = double.tryParse(c.jual.value.pdiskon.toString()) ?? 0;
    subtotal = c.subtotal.value;
    total = c.total.value;
    cpdiskon = TextEditingController(text: formatter.format(pdiskon));
    cdiskon = TextEditingController(text: formatangka(diskon));

    super.initState();
  }

  @override
  void dispose() {
    cpdiskon.dispose();
    cdiskon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        height: 190.0,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: mainColor,
              width: double.infinity,
              child: const Text('Diskon', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: editorangka(
                        context,
                        'Berdasarkan %',
                        formatter.format(pdiskon),
                        editingController: cpdiskon,
                        autoFocus: true,
                        onChanged: (p0) {
                          p0 = p0.replaceAll(',', '.');
                          pdiskon = double.tryParse(p0) ?? 0;
                          diskon = (subtotal * pdiskon) / 100;
                          total = subtotal - diskon;
                          cdiskon = TextEditingController(text: formatangka(diskon));
                          setState(() {});
                        },
                      )),
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: editorangka(
                        context,
                        'Berdasarkan Rp.',
                        formatangka(diskon.toString()),
                        editingController: cdiskon,
                        onChanged: (p0) {
                          p0 = p0.replaceAll(',', '.');
                          diskon = double.tryParse(p0) ?? 0;
                          pdiskon = (diskon * 100) / subtotal;
                          total = subtotal - diskon;
                          cpdiskon = TextEditingController(text: formatter.format(pdiskon));
                          setState(() {});
                        },
                      ),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: mainColor),
                    child: const Text('Batal'),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () {
                      c.jual.value.pdiskon = pdiskon.toString();
                      c.jual.value.diskon = diskon;
                      c.hitung();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: mainColor, foregroundColor: Colors.white),
                    child: const Text('Simpan'),
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
