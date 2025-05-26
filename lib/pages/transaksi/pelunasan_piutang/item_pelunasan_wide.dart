import 'package:flutter/material.dart';
import 'package:ljm/pages/homepage/widgets/editor.dart';
import 'package:ljm/provider/models/transaksi/kas.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';
import 'package:get/get.dart';
import 'controller.dart';

class ItemPelunasanWide extends StatefulWidget {
  final PelunasanPiutangController controller;
  final itemx;
  final int index;
  const ItemPelunasanWide(this.controller, this.itemx, this.index, {super.key});

  @override
  State<ItemPelunasanWide> createState() => _ItemPelunasanWideState();
}

class _ItemPelunasanWideState extends State<ItemPelunasanWide> {
  late PelunasanPiutangController c;
  TRANSAKSI item = TRANSAKSI();
  KAS? pelunasan = null;
  var _xC = TextEditingController();
  @override
  void initState() {
    super.initState();
    c = widget.controller;
    item = TRANSAKSI.fromMap(widget.itemx);
    pelunasan = widget.controller.pelunasan.value.detailkas?.firstWhereOrNull((p) => p.refidtrans == item.id);
    if (pelunasan != null) _xC = TextEditingController(text: formatangka(pelunasan!.nilai));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
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
                      if (pelunasan != null) {
                        pelunasan!.nilai = item.saldo;
                        var i = c.pelunasan.value.detailkas!.indexWhere((p) => p.refidtrans == item.id);
                        if (i > -1) {
                          c.pelunasan.value.detailkas?.removeWhere((p) => p.refidtrans == item.id);
                          c.pelunasan.value.detailkas?.insert(i, pelunasan!);
                        } else {
                          c.pelunasan.value.detailkas!.add(pelunasan!);
                        }
                        c.hitung();
                      } else {
                        pelunasan = KAS(
                          idtrans: c.pelunasan.value.id,
                          id: c.pelunasan.value.id,
                          refidtrans: item.id,
                          refnotrans: item.notrans,
                          tanggal: item.tanggal,
                          rek: item.rekkredit,
                          akuntansi: item.akunkredit,
                          nilai: item.saldo,
                        );
                        if (pelunasan != null) {
                          c.pelunasan.value.detailkas!.add(pelunasan!);
                          c.hitung();
                        }
                      }
                      setState(() {
                        _xC = TextEditingController(text: formatangka(item.saldo));
                      });
                      // dp("c.pelunasan.value:\n${c.pelunasan.value}");
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
                      onChanged: (nilai) {
                        if (pelunasan != null) {
                          pelunasan!.nilai = double.tryParse(nilai.replaceAll('.', ''));
                          var i = c.pelunasan.value.detailkas!.indexWhere((p) => p.refidtrans == item.id);
                          if (i > -1) {
                            c.pelunasan.value.detailkas?.removeWhere((p) => p.refidtrans == item.id);
                            c.pelunasan.value.detailkas?.insert(i, pelunasan!);
                          } else {
                            c.pelunasan.value.detailkas!.add(pelunasan!);
                          }
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
                            nilai: double.tryParse(nilai.replaceAll('.', '')),
                          );
                          c.pelunasan.value.detailkas!.add(pelunasan!);
                          c.hitung();
                          setState(() {});
                        }
                      },
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
