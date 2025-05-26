import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/widgets/customcontainer.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/widgets/template_paginate_table.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

class ListPiutang extends StatefulWidget {
  final KONTAK? sales;
  final String title;
  final TRANSAKSI? params;
  final bool tempoonly;
  const ListPiutang({super.key, this.sales, this.params, this.title = 'Daftar Piutang', this.tempoonly = false});

  @override
  State<ListPiutang> createState() => _ListPiutangState();
}

class _ListPiutangState extends State<ListPiutang> {
  List<int?> cek = [];
  List<double?> total = [];
  List<TRANSAKSI?> notadibayar = [];
  double totalpelunasan = 0;
  var idpegawai = '';
  var useidkontak = '';
  var jttempo = '';
  var fieldsales = '';
  var sql = '';

  @override
  void initState() {
    if (widget.tempoonly) jttempo = " and p.tempo <= CURRENT_DATE ";
    if (widget.params != null) {
      if (widget.params!.idkontak != null) useidkontak = "and p.idkontak = ${widget.params!.idkontak ?? '0'}";
    } else {}
    if (widget.sales != null) {
      idpegawai = "and p.idpegawai = ${widget.sales?.id}";
      fieldsales = ' p.idpegawai, s.kode sales';
      sql = """
        select p.id, p.tanggal tanggal, k.kode kontak, p.nilai, p.diskon, p.nilaitotal, p.bayar, p.kredit, p.potongnota,  p.pembayaran, p.saldo, p.tempo 
        from transaksi p inner join ktk k on p.idkontak = k.id
        WHERE coalesce(p.saldo,0) <> 0 and kdtrans = 'PJ'  $idpegawai $useidkontak $jttempo""";
    } else {
      sql = """
        select p.id, p.tanggal tanggal, k.kode kontak, p.idpegawai, s.kode sales, p.nilai, p.diskon, p.nilaitotal, p.bayar, p.kredit, p.potongnota,  p.pembayaran, p.saldo, p.tempo 
        from transaksi p 
        inner join ktk k on p.idkontak = k.id
        inner join ktk s on p.idpegawai = s.id        
        WHERE coalesce(p.saldo,0) <> 0 and kdtrans = 'PJ' $useidkontak $jttempo""";
    }
    dp(sql);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextStandard(text: widget.title, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          if (widget.params?.idkontak != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomContainer(
                borderColor: Colors.red,
                borderRadius: 10.0,
                color: Colors.green[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Expanded(child: CustomTextStandard(text: 'Pelanggan')),
                        Expanded(
                          child: InkWell(
                            onTap: () => Get.toNamed('kontak/pelanggan/detail', arguments: {"judul": "Pelanggan", "kontak": KONTAK(id: widget.params?.idkontak)}),
                            child: CustomTextStandard(
                              text: widget.params?.namakontak ?? '',
                              color: Colors.grey,
                              maxlines: 2,
                            ),
                          ),
                        )
                      ]),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(child: CustomTextStandard(text: 'Total Piutang')),
                          Expanded(
                            child: CustomTextStandard(
                              text: formatuang(widget.params?.nilaitotal),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            child: TablePaginate(
              title: widget.title,
              sql: sql,
              order: "p.tempo",
              filter: ["k.kode", "k.nama"],
              itemBuilder: (context, itemx, index) {
                var item = TRANSAKSI.fromMap(itemx);

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  minLeadingWidth: 0,
                  horizontalTitleGap: 5,
                  dense: true,
                  key: Key(item.id.toString()),
                  leading: (widget.params?.idkontak != null)
                      ? Checkbox(
                          visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
                          activeColor: Colors.red,
                          value: cek.contains(item.id),
                          onChanged: (bool? value) {
                            if (value == true) {
                              cek.add(item.id);
                              total.add(item.nilaitotal);
                              notadibayar.add(item);
                            } else {
                              cek.remove(item.id);
                              notadibayar.removeWhere((element) => element?.id == item.id);
                              total.remove(item.nilaitotal);
                            }
                            totalpelunasan = total.fold(0, (previousValue, element) => previousValue + (element ?? 0));
                            setState(() {});
                          },
                        )
                      : null,
                  title: Row(
                    children: [
                      Expanded(child: CustomTextStandard(text: item.kontak ?? '', maxlines: 2)),
                      CustomTextStandard(text: 'Kredit: ${formatuang(item.kredit)}'),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextStandard(text: 'No. ${formatangka(item.id)}', color: Colors.grey),
                          Row(
                            children: [
                              const CustomTextStandard(text: 'Nilai Nota:', color: Colors.grey),
                              const SizedBox(width: 5),
                              CustomTextStandard(text: formatuang(item.nilaitotal)),
                            ],
                          ),
                          if (widget.sales == null)
                            Row(
                              children: [
                                const CustomTextStandard(text: 'Sales:', color: Colors.grey),
                                const SizedBox(width: 5),
                                CustomTextStandard(text: item.sales ?? ''),
                              ],
                            ),
                          if ((item.bayar ?? 0) > 0)
                            Row(
                              children: [
                                const CustomTextStandard(text: 'DP:', color: Colors.grey),
                                const SizedBox(width: 5),
                                CustomTextStandard(text: formatuang(item.bayar)),
                              ],
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if ((item.pembayaran ?? 0) > 0)
                            Row(
                              children: [
                                const CustomTextStandard(text: 'Pembayaran:', color: Colors.grey),
                                const SizedBox(width: 5),
                                CustomTextStandard(text: formatuang(item.pembayaran)),
                              ],
                            ),
                          if ((item.potongnota ?? 0) > 0)
                            Row(
                              children: [
                                const CustomTextStandard(text: 'Potong Nota:', color: Colors.grey),
                                const SizedBox(width: 5),
                                CustomTextStandard(text: formatuang(item.potongnota)),
                              ],
                            ),
                          Row(
                            children: [
                              const CustomTextStandard(text: 'Saldo:', color: Colors.grey),
                              const SizedBox(width: 5),
                              CustomTextStandard(text: formatuang(item.saldo)),
                            ],
                          ),
                          Row(
                            children: [
                              const CustomTextStandard(text: 'Jatuh Tempo:', color: Colors.grey),
                              const SizedBox(width: 5),
                              CustomTextStandard(text: formattanggal(item.tempo), color: (DateTime.parse(item.tempo.toString()).isBefore(DateTime.now())) ? Colors.red : Colors.black),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  onTap: () => Get.toNamed('/penjualan/rincian', arguments: {'item': item}), // (() => InvoiceItemDetailPage(item: item), transition: Transition.fade),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: (widget.params?.idkontak != null)
          ? CustomContainer(
              borderColor: Colors.transparent,
              height: 100,
              color: Colors.grey[300],
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomTextStandard(text: 'Total Bayar', fontSize: 14),
                        CustomTextStandard(text: formatuang(totalpelunasan), fontWeight: FontWeight.bold, fontSize: 18),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (totalpelunasan > 0) ? () => Get.toNamed('') : null,
                              //(() => TerimaPembayaran(itemdibayar: notadibayar, x: widget.params?.copyWith(bayar: totalpelunasan))) : null, //, y: 'Bayar')) : null,
                              style: ElevatedButton.styleFrom(backgroundColor: totalpelunasan > 0 ? Colors.red : Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                              child: const CustomTextStandard(text: 'Bayar', color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
