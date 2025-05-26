import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/pages/transaksi/penjualan/controller.dart';
import 'package:ljm/widgets/customtext.dart';

import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

class PenjualanPage extends StatefulWidget {
  const PenjualanPage({super.key});

  @override
  State<PenjualanPage> createState() => _PenjualanPageState();
}

class _PenjualanPageState extends State<PenjualanPage> /* with SingleTickerProviderStateMixin */ {
  // late AnimationController _controller;
  // late Animation<Color?> _colorAnimation;

  var c = getPenjualanController();

  var widgetSales = <Widget>[];

  @override
  void initState() {
    super.initState();
    /* _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Ulang animasi

    _colorAnimation = ColorTween(begin: Colors.yellow, end: Colors.red).animate(_controller); */
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  void showSalesBottomModal(BuildContext context) {
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
                child: const Text('Pilih Sales :', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: c.sales.length,
                      itemBuilder: (context, i) {
                        if (i == 0) {
                          return Column(
                            children: [
                              ListTile(
                                  title: const Text('Semua Sales', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  onTap: () async {
                                    salesAktif = null;
                                    prefs.remove('salesAktif');
                                    Get.back();

                                    await c.initRekapData();
                                    c.pagingController.refresh();
                                    c.pagingDraftController.refresh();

                                    c.update();
                                    setState(() {});
                                  }),
                              ListTile(
                                  title: Text(c.sales[i].nama ?? ''),
                                  onTap: () async {
                                    Get.back();
                                    salesAktif = c.sales[i];
                                    // if (salesAktif != null) prefs.setString("salesAktif", salesAktif!.toJson());
                                    await c.initRekapData();
                                    c.pagingController.refresh();
                                    c.pagingDraftController.refresh();

                                    c.update();
                                    setState(() {});
                                  })
                            ],
                          );
                        }
                        return ListTile(
                            title: Text(c.sales[i].nama ?? ''),
                            onTap: () async {
                              Get.back();
                              salesAktif = c.sales[i];
                              // if (salesAktif != null) prefs.setString("salesAktif", salesAktif!.toJson());
                              await c.initRekapData();
                              // c.pagingController.nextPageKey = 0;
                              c.pagingController.refresh();
                              c.update();
                              setState(() {});
                            });
                      },
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penjualan',
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Mengatur warna icon menjadi putih
        ),
      ),
      body: Column(
        // ganti pilih sales
        children: [
          const SizedBox(height: 10),
          if (salesAktif == null || TipeOperator.values[user.tipe] == TipeOperator.direksi)
            Container(
              height: 50,
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8.0, right: 8.0, bottom: 8.0),
                child: GestureDetector(
                  onTap: () => showSalesBottomModal(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border(bottom: BorderSide(color: mainColor)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextStandard(text: salesAktif?.nama ?? 'Pilih Sales', color: Colors.black, fontSize: 14),
                          Icon(Icons.arrow_forward_ios_outlined, size: 16, color: mainColor),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          _headlinePiutang(context),
          const SizedBox(height: 10),
          _semuaPiutang(context),
          const SizedBox(height: 10),
          _piutangJatuhTempo(context),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
            child: Align(alignment: Alignment.centerLeft, child: Text('Draf Penjualan', style: Theme.of(context).textTheme.bodyLarge)),
          ),
          _detailDrafPenjualan(context),
          _invoicePenjualan(context),
          Divider(),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Obx(() => (c.ready.value)
                    ? PagingListener(
                        controller: c.pagingController,
                        builder: (context, state, fetchNextPage) => PagedListView<int, dynamic>(
                          state: state,
                          fetchNextPage: fetchNextPage,
                          builderDelegate: PagedChildBuilderDelegate<dynamic>(
                            itemBuilder: (context, item, index) {
                              var itemx = TRANSAKSI.fromMap(item);
                              return InvoiceCard(invoice: itemx, selectedSales: salesAktif);
                            },
                            firstPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                            newPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                            noItemsFoundIndicatorBuilder: (_) => const Center(child: Text('No items found')),
                          ),
                        ),
                      )
                    : LoadingList())),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/penjualan/baru'), // => const InputPenjualan2()),
        // backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _headlinePiutang(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Piutang',
            style: Theme.of(context).textTheme.bodyLarge,
          )
          // CustomTextStandard(text: 'Piutang', fontSize: 14, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  Widget _semuaPiutang(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Semua Piutang', style: Theme.of(context).textTheme.bodySmall),
              Obx(() => Text(formatuang(c.rekap.value.piutang), style: Theme.of(context).textTheme.bodySmall)),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () => Get.toNamed('/piutang/group/kontak', arguments: {"title": 'Piutang Per-Kontak', "sales": salesAktif}),
                child: Obx(() => CustomTextStandard(
                      text: '${c.rekap.value.jmlpelanggan} Pelanggan',
                      color: mainColor,
                    )),
              ),
              Text(', '),
              InkWell(
                onTap: () => Get.toNamed('/piutang', arguments: {"title": 'Daftar Piutang', "params": TRANSAKSI(idpegawai: salesAktif?.id, sales: salesAktif?.nama), "sales": salesAktif}), // () => ListPiutang(title: 'Daftar Piutang', params: TRANSAKSI(idpegawai: salesAktif?.id, sales: salesAktif?.nama), sales: salesAktif)),
                child: Obx(() => CustomTextStandard(text: '${c.rekap.value.nota} Invoices', color: mainColor)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _piutangJatuhTempo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTextStandard(text: 'Piutang Jatuh Tempo'),
              Obx(() => CustomTextStandard(text: formatuang(c.rekap.value.jtempo))),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () => Get.toNamed('/piutang/group/kontak', arguments: {"title": 'Piutang Jatuh Tempo Per-Kontak', "sales": salesAktif, "tempoonly": true}), //ListPiutangByKontak(title: 'Piutang Jatuh Tempo Per-Kontak', sales: salesAktif, tempoonly: true)),
                child: Obx(() => CustomTextStandard(text: '${c.rekap.value.jmlpelangganjt} Pelanggan', color: mainColor)),
              ),
              Text(', '),
              InkWell(
                onTap: () => Get.toNamed('/piutang', arguments: {"sales": salesAktif, "tempoonly": true, "params": TRANSAKSI(idpegawai: salesAktif?.id, sales: salesAktif?.nama)}),
                child: Obx(() => CustomTextStandard(text: '${c.rekap.value.notatempo} Invoices', color: mainColor)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _invoicePenjualan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Invoice Penjualan', style: Theme.of(context).textTheme.bodyLarge),
          GestureDetector(
            onTap: () => Get.toNamed('/penjualan/harian', arguments: {"sales": salesAktif}), //() => ListPenjualan(sales: salesAktif)),
            child: Text(
              'Lihat Semua',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailDrafPenjualan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8.0),
      child: Obx(
        () => SizedBox(
            height: (c.jmldraft.value) * 30,
            child: (c.ready.value)
                ? PagingListener(
                    controller: c.pagingDraftController,
                    builder: (context, state, fetchNextPage) => PagedListView<int, dynamic>(
                      state: state,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate<dynamic>(
                        itemBuilder: (context, item, index) {
                          var itemx = TRANSAKSI.fromMap(item);
                          return Container(
                            height: 30,
                            child: Dismissible(
                              confirmDismiss: (d) async {
                                if (d == DismissDirection.startToEnd) {
                                  var res = await konfirmasi2('Apakah Anda yakin ingin menghapus item ini ${itemx.notrans}?');
                                  if (res == true) {
                                    return await c.deleteDraft(itemx);
                                  }
                                }
                                return false;
                              },
                              onDismissed: (d) {
                                if (d == DismissDirection.startToEnd) {
                                  c.pagingDraftController.refresh();
                                }
                              },
                              key: Key(itemx.notrans ?? 'item_$index'),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Hapus', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white)),
                                  ],
                                ),
                              ),
                              direction: DismissDirection.horizontal,
                              child: Container(
                                height: 30,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed("/penjualan/baru/detail", arguments: itemx);
                                        // c.pagingDraftController.refresh();
                                      },
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: 80,
                                              child: Text(
                                                itemx.notrans ?? '',
                                                style: Theme.of(context).textTheme.labelLarge,
                                              )),
                                          SizedBox(
                                              width: 150,
                                              child: Text(
                                                formattanggal(itemx.tanggal ?? ''),
                                                style: Theme.of(context).textTheme.labelLarge,
                                              )),
                                          SizedBox(
                                            width: 50,
                                            child: Text(
                                              itemx.kontak ?? '',
                                              style: Theme.of(context).textTheme.labelLarge,
                                            ),
                                          ),
                                          // Text(
                                          //   itemx.catatan ?? '',
                                          //   style: Theme.of(context).textTheme.labelLarge,
                                          // ),
                                        ],
                                      ),
                                    ),
                                    if (itemx.catatan?.isNotEmpty == true)
                                      // AnimatedBuilder(
                                      //   animation: _colorAnimation,
                                      //   builder: (context, child) {
                                      //     return Icon(
                                      //       Icons.info,
                                      //       size: 15,
                                      //       color: _colorAnimation.value,
                                      //     );
                                      //   },
                                      // ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    InkWell(
                                      onTap: () {
                                        Informasi(itemx.catatan ?? 'Tidak ada catatan');
                                      },
                                      child: Icon(
                                        Icons.info,
                                        size: 15,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                        newPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                        noItemsFoundIndicatorBuilder: (_) => const Center(child: Text('No items found')),
                      ),
                    ),
                  )
                : LoadingList()),
      ),
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final KONTAK? selectedSales;
  final TRANSAKSI invoice;
  const InvoiceCard({super.key, required this.invoice, this.selectedSales});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        //contentPadding: const EdgeInsets.all(8.0),
        title: Text(
          formattanggal(invoice.tanggal),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        subtitle: Text('${formatangka(invoice.qty)} Invoice(s)', style: Theme.of(context).textTheme.labelLarge),
        trailing: Text(formatuang(invoice.nilaitotal), style: Theme.of(context).textTheme.bodySmall),
        onTap: () {
          Get.toNamed('/penjualan/harian', arguments: {
            'invoice': invoice, // ini bisa null
            'sales': salesAktif,
            'semuaNota': false, // ini bisa null
          });
        },
      ),
    );
  }
}
