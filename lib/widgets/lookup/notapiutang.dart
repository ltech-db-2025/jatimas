import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/customtextfield.dart';
import 'package:ljm/widgets/lookup/template_paginate_table_url.dart';

class PilihNotaPiutang extends StatefulWidget {
  final int idkontak;
  final Function(TRANSAKSI?)? onPilih;
  final TRANSAKSI? initial;
  final Widget? child;
  const PilihNotaPiutang(this.idkontak, {super.key, this.initial, this.onPilih, this.child});

  @override
  State<PilihNotaPiutang> createState() => _PilihNotaPiutangState();
}

class _PilihNotaPiutangState extends State<PilihNotaPiutang> {
  TRANSAKSI? selected;

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    selected = widget.initial;
    if (widget.initial != null) {
      /* if (widget.initial!.nama == null || widget.initial!.kode == null) {
        selected = await getKontakByID(widget.initial!.id);
      } */
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
            controller: TextEditingController(text: selected?.notrans ?? 'Pilih Nota'),
            label: 'Nota *',
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
                    child: const Text('Pilih Nota :', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                      child: TablePaginateUrl(
                    path: '/pelunasan/piutang/kontak/${widget.idkontak}',
                    itemBuilder: (context, itemx, index) {
                      var item = TRANSAKSI.fromMap(itemx);
                      return ListTile(
                          selectedTileColor: customTema.appBarTheme.backgroundColor,
                          selected: (item.id == selected?.id),
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -4),
                          leading: Text(
                            "${formattanggal(item.tanggal, 'dd/mm')}\n${formattanggal(item.tanggal, 'yyyy')}",
                            style: TextStyle(fontSize: 12),
                          ),
                          title: Text(item.notrans ?? ''),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(flex: 1, child: Text("Nilai : ${formatuang(item.kredit)}")),
                              Flexible(flex: 1, child: Text("Bayar : ${formatuang(item.pembayaran)}")),
                              Flexible(flex: 1, child: Text("saldo : ${formatuang(item.saldo)}")),
                            ],
                          ),
                          trailing: Text(
                            "${formattanggal(item.tempo, 'dd/mm')}\n${formattanggal(item.tempo, 'yyyy')}",
                            style: TextStyle(fontSize: 12),
                          ),
                          onTap: () {
                            selected = item;
                            widget.onPilih?.call(item);
                            setState(() {});
                            Get.back(result: item);
                          });
                    },
                  )),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
