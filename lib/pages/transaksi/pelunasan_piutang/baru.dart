import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/pages/transaksi/pelunasan_piutang/item_pelunasan.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/widgets/customtextfield.dart';
import 'package:ljm/widgets/lookup/kontak.dart';

import 'controller.dart';

class PelunasanPiutangBaru extends StatefulWidget {
  const PelunasanPiutangBaru({super.key});

  @override
  State<PelunasanPiutangBaru> createState() => _PelunasanPiutangBaruState();
}

class _PelunasanPiutangBaruState extends State<PelunasanPiutangBaru> {
  var c = getPelunasanPiutangController();
  var pageSize = 10; // jumlah records per loading
  TextEditingController tglTransaksiController = TextEditingController(text: 'Hari Ini');
  late final pagingController = PagingController<int, dynamic>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);
  var pelangganController = TextEditingController();

  @override
  void initState() {
    c.resetTransaksi();
    tglTransaksiController = TextEditingController(text: formattanggal(c.pelunasan.value.tanggal, 'dd/MM/yyyy HH:mm'));

    super.initState();
  }

  @override
  void dispose() {
    tglTransaksiController.dispose();

    pelangganController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> fetchPage(int pageKey) async {
    var query = {
      'j': pageSize.toString(),
      'p': pageKey.toString(),
    };

    final newItems = await getUrlData('/pelunasan/piutang/kontak/${c.pelunasan.value.idkontak}', query);
    return newItems ?? [];
  }

  @override
  Widget build(BuildContext context) {
    dp("${Get.width}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Pelunasan Piutang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.tryParse(c.pelunasan.value.tanggal.toString()) ?? DateTime.now(),
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != DateTime.tryParse(c.pelunasan.value.tanggal.toString())) {
                  setState(() {
                    c.pelunasan.value.tanggal = picked.toString();
                    tglTransaksiController.text = formattanggal(picked.copyWith(hour: DateTime.now().hour, minute: DateTime.now().minute, second: 0, millisecond: 0).toString(), 'dd/MM/yyyy HH:mm');
                  });
                }
              },
              child: IgnorePointer(
                child: CustomTextField(readOnly: true, enabled: true, controller: tglTransaksiController, label: 'Tanggal Transaksi', suffixIcon: Icons.calendar_month),
              ),
            ),
            const Align(alignment: Alignment.centerLeft, child: CustomTextStandard(text: 'Catatan')),
            const SizedBox(height: 10),
            PilihPelanggan(
                initial: KONTAK(id: c.pelunasan.value.idkontak, kode: c.pelunasan.value.kontak),
                onPilih: (selectedPelanggan) async {
                  setState(() {
                    if (selectedPelanggan != null) {
                      c.pelunasan.value.detail != [];
                      c.totalController.value = TextEditingController(text: formatangka(0));
                      c.totalpembayaranbaru.value = 0;

                      c.pelunasan.value.idkontak = selectedPelanggan.id;
                      c.pelunasan.value.kontak = selectedPelanggan.kode;
                      pelangganController.text = selectedPelanggan.nama ?? '';
                      c.alamatController.value = TextEditingController(text: selectedPelanggan.alamatkirim);

                      /* if (selectedPelanggan.desa != null) c.alamatController.value.text += "\n${selectedPelanggan.desa}";
                      if (selectedPelanggan.kecamatan != null) c.alamatController.value.text += ' - ${selectedPelanggan.kecamatan}';
                      if (selectedPelanggan.kabupaten != null) c.alamatController.value.text += '\n${selectedPelanggan.kabupaten}';
                      if (selectedPelanggan.provinsi != null) c.alamatController.value.text += ' - ${selectedPelanggan.provinsi}';
                      if (selectedPelanggan.kodepos != null) c.alamatController.value.text += '\n${selectedPelanggan.kodepos}';
                      if (selectedPelanggan.telp != null) c.alamatController.value.text += '\n${selectedPelanggan.telp}'; */
                      c.update();
                      pagingController.refresh();
                    }
                  });
                }),
            Align(
                alignment: Alignment.centerRight,
                child: Obx(() => AutoSizeText(
                      c.alamatController.value.text,
                      style: st8,
                      textAlign: TextAlign.right,
                    ))),
            const SizedBox(height: 10),
            if (Get.width >= 400)
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(flex: 1, child: Text("Nomot", style: st10)),
                      Flexible(flex: 1, child: Text("Tanggal", style: st10)),
                      Flexible(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text("Nilai", style: st10))),
                      Flexible(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text("terbayar", style: st10))),
                      Flexible(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text("Sisa", style: st10))),
                      Flexible(flex: 2, fit: FlexFit.tight, child: Align(alignment: Alignment.centerRight, child: Text("Bayar", style: st10))),
                    ],
                  )),
            Obx(() => Expanded(
                  child: (c.pelunasan.value.idkontak == null)
                      ? Container()
                      : PagingListener(
                          controller: c.pagingController,
                          builder: (context, state, fetchNextPage) => PagedListView<int, dynamic>(
                            state: state,
                            fetchNextPage: fetchNextPage,
                            builderDelegate: PagedChildBuilderDelegate<dynamic>(
                              itemBuilder: (context, itemx, index) {
                                return ItemPelunasan(c, itemx, index);
                              },
                              firstPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                              newPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                              noItemsFoundIndicatorBuilder: (_) => const Center(child: Text('Tidak ada Piutang')),
                            ),
                          ),
                        ),
                )),
            // masukkan catatan dengan tombol dan dialog;
            /*      const SizedBox(height: 10),
            TextField(
              controller: TextEditingController(text: c.pelunasan.value.catatan),
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) => c.pelunasan.value.catatan = value,
            ), */
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Jumlah Bayar', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black)),
                Text(c.pelunasan.value.akunkas ?? '-', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black)),
              ],
            ),
            const SizedBox(height: 10),
            // button(text: Text('test'), onPressed: () => [dp("${c.pelunasan}"), dp('${c.pelunasan.value.detailkas}')]),
            Obx(() => TextField(
                  textAlign: TextAlign.right,
                  controller: c.totalController.value,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0, // Menambahkan padding sesuai dengan tinggi keyboard
          left: 16.0,
          right: 16.0,
        ),
        child: Obx(() => ElevatedButton(
              onPressed: (c.totalpembayaranbaru.value != 0)
                  ? () async {
                      pesanError1('Dalam Pengembangan');
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Warna latar belakang tombol
              ),
              child: Text(
                'Simpan Pembayaran',
                style: TextStyle(
                  color: Colors.white, // Warna teks
                ),
              ),
            )),
      ),
    );
  }
}
