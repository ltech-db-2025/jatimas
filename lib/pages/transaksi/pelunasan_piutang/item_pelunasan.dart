import 'package:flutter/material.dart';
import 'package:ljm/pages/homepage/widgets/editor.dart';
import 'package:ljm/provider/models/transaksi/kas.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';
import 'package:get/get.dart';
import 'package:ljm/widgets/editor/editoruang.dart';
import 'controller.dart';

class ItemPelunasan extends StatefulWidget {
  final PelunasanPiutangController controller;
  final itemx;
  final int index;
  const ItemPelunasan(this.controller, this.itemx, this.index, {super.key});

  @override
  State<ItemPelunasan> createState() => _ItemPelunasanState();
}

class _ItemPelunasanState extends State<ItemPelunasan> {
  late PelunasanPiutangController c;
  TRANSAKSI item = TRANSAKSI();
  KAS? pelunasan = null;
  var _xC = TextEditingController(text: "0");
  @override
  void initState() {
    super.initState();
    c = widget.controller;
    item = TRANSAKSI.fromMap(widget.itemx);
    pelunasan = widget.controller.pelunasan.value.detailkas?.firstWhereOrNull((p) => p.refidtrans == item.id);
    if (pelunasan != null) _xC = TextEditingController(text: formatangka(pelunasan!.nilai));
  }

  onNilaiBayar(String nilai) {
    if (pelunasan != null) {
      pelunasan!.nilai = makeDouble2(nilai);
      var i = c.pelunasan.value.detailkas!.indexWhere((p) => p.refidtrans == item.id);
      if (i > -1) {
        c.pelunasan.value.detailkas?.removeWhere((p) => p.refidtrans == item.id);
        c.pelunasan.value.detailkas?.insert(i, pelunasan!);
      } else {
        c.pelunasan.value.detailkas!.add(pelunasan!);
      }
      // dp("nilai: $nilai\n$pelunasan");
      c.hitung();
      setState(() {});
    } else {
      pelunasan = KAS(
        idtrans: c.pelunasan.value.id,
        id: c.pelunasan.value.id,
        refidtrans: item.id,
        refnotrans: item.notrans,
        tanggal: item.tanggal,
        rek: item.rekkredit,
        akuntansi: item.akunkredit,
        nilai: makeDouble2(nilai),
      );
      dp("nilai: $nilai\n$pelunasan");
      c.pelunasan.value.detailkas!.add(pelunasan!);

      c.hitung();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(color: tema.primaryColor);
    return Card(
        child: (Get.width < 400)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 12, color: Colors.black),
                    child: Flex(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      direction: Axis.horizontal,
                      children: [
                        SizedBox(
                            width: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nomor', style: _style),
                                Text('Tanggal', style: _style),
                                Text('Kredit', style: _style),
                                Text('Pembayaran', style: _style),
                                Text('Potong Nota', style: _style),
                              ],
                            )),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(": ${item.notrans}"),
                              Text(": ${formattanggal(item.tanggal, 'dd/MM/yyyy HH:mm')}"),
                              Text(": ${formatuang(item.kredit)}"),
                              Text(": ${formatuang(item.pembayaran)}"),
                              Text(": ${formatuang(item.potongnota)}"),
                            ],
                          ),
                        ),
                        Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(children: [SizedBox(width: 70, child: Text('Sisa Kredit', style: _style)), Text(": ${formatuang(item.saldo)}")]),
                                Row(children: [SizedBox(width: 70, child: Text('Tempo', style: _style)), Text(": ${formattanggal(item.tempo)}")]),
                                SizedBox(height: 5),
                                Text('Bayar', style: _style),
                                SizedBox(height: 5),
                                EditorUang(
                                  scaleFactor: 0.8,
                                  dense: true,
                                  controller: _xC,
                                  maxValue: item.saldo,
                                  onChanged: onNilaiBayar,
                                ),
                                InkWell(
                                  onTap: () {
                                    onNilaiBayar(item.saldo.toString().replaceAll('.', ','));
                                    setState(() {
                                      _xC = TextEditingController(text: formatangka(item.saldo));
                                    });
                                  },
                                  child: Text(
                                    'Lunasi Nota',
                                    style: st12.copyWith(color: Colors.deepOrange),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    )),
              )
            : Column(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(flex: 1, child: Text("${item.notrans}", style: st10)),
                      Flexible(flex: 1, child: Text("${formattanggal(item.tanggal)}", style: st10)),
                      Flexible(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text("${formatuang(item.nilai)}", style: st10))),
                      Flexible(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text("${formatuang(item.bayar)}", style: st10))),
                      Flexible(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text("${formatuang(item.saldo)}", style: st10))),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                onNilaiBayar(item.saldo.toString().replaceAll('.', ','));
                                setState(() {
                                  _xC = TextEditingController(text: formatangka(item.saldo));
                                });
                              },
                              child: Text(
                                'Lunasi',
                                style: st10.copyWith(color: tema.primaryColor),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: EditorUangText(
                                controller: _xC,
                                label: 'label',
                                maxValue: item.saldo,
                                scaleFactor: 0.6,
                                onChanged: onNilaiBayar,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ));
  }
}
