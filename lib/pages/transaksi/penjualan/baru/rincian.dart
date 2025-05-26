import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/transaksi/penjualan/controller.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/termin.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/widgets/lookup/template2/sales.dart';
import 'package:ljm/widgets/lookup/template2/termin.dart';
import 'package:ljm/widgets/template_paginate_table.dart';

class RincianDraftPenjualan extends StatefulWidget {
  final TRANSAKSI item;

  const RincianDraftPenjualan(
    this.item, {
    super.key,
    // required this.item
  });

  @override
  State<RincianDraftPenjualan> createState() => _RincianDraftPenjualanState();
}

class _RincianDraftPenjualanState extends State<RincianDraftPenjualan> {
  var newtrans = TRANSAKSI();
  String selectedDate = ''; // Nilai default untuk tanggal
  @override
  void initState() {
    newtrans = widget.item;
    selectedDate = formattanggal2(newtrans.tanggal);
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    // Menampilkan dialog pemilih tanggal
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(newtrans.tanggal!) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        // Mengubah format tanggal ke string yang diinginkan
        newtrans.tanggal = picked.toString();
        selectedDate = "${picked.day} ${namaBulan(picked.month)} ${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Rincian Sales Order',
          // style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                showDragHandle: true,
                backgroundColor: Colors.white,
                context: context,
                builder: (BuildContext context) {
                  return Wrap(
                    children: [
                      ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Fungsi untuk menutup modal
                            },
                            child: const Icon(Icons.cancel),
                          ),
                          title: const CustomTextStandard(
                            text: 'Lainnya',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.print),
                        title: const Text('Cetak'),
                        onTap: () {
                          // Implementasi untuk mencetak
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.chat),
                        title: const Text('WhatsApp'),
                        onTap: () {
                          // Implementasi untuk berbagi ke WhatsApp
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.share),
                        title: const Text('Bagikan'),
                        onTap: () {
                          // Implementasi untuk berbagi
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Ubah'),
                        onTap: () {
                          // Implementasi untuk mengubah
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Hapus'),
                        onTap: () {
                          // Implementasi untuk menghapus
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pilihKontak(context),
            _namaKontak(context),
            _noTransaksi(context),
            _tglTransaksi(context),
            PilihTermin2(
              initial: TERMIN(kode: newtrans.termin),
            ),
            PilihSales2(
              initial: KONTAK(id: newtrans.idpegawai),
            ),
//-----------------------------------------------------------------------------------//
            const Divider(),
            _headlineTransaksi(context),
            _detailTransaksi(context),
            const Divider(),
            _totalTransaksi(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: _bottomBar(context),
      ),
    );
  }

  Widget _pilihKontak(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          // alignment: Alignment.topRight, // Mengatur posisi ikon di sudut kanan atas
          children: [
            const CircleAvatar(
              radius: 40, // Sesuaikan dengan ukuran yang Anda inginkan
              backgroundColor: Color(0xFF00b3b0), // Atur warna latar belakang sesuai kebutuhan
              child: Icon(
                Icons.person,
                size: 60, // Sesuaikan dengan ukuran ikon yang Anda inginkan
                color: Colors.white, // Atur warna ikon sesuai kebutuhan
              ),
            ),
            Positioned(
              right: -5,
              top: 0,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Bentuk lingkaran
                  color: Colors.grey.withValues(alpha: 0.7), // Warna abu-abu transparan
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ), // Ikon edit
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.50,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                child: const CustomTextStandard(text: 'Pilih Pelanggan', fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: TablePaginate(
                                      filter: ['kode', 'nama', 'alamat_kirim'],
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
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                ),
                                                CustomTextStandard(
                                                  text: item.nama ?? '',
                                                  fontSize: 14,
                                                ),
                                                CustomTextStandard(text: item.alamat ?? ''),
                                              ],
                                            ),
                                            onTap: () {
                                              newtrans.datakontak = item;
                                              newtrans.idkontak = item.id;
                                              newtrans.kontak = item.kode;
                                              newtrans.namakontak = item.nama;

                                              Get.back(result: item);
                                            });
                                      },
                                      sql: 'select * from kontak where aktif = 1 and c = 1')),
                            ],
                          ),
                        );
                      },
                    );
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _namaKontak(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: CustomTextStandard(
          text: newtrans.namakontak ?? 'Pilih Nama Pelanggan',
          fontSize: 14,
          color: (newtrans.namakontak == null || newtrans.namakontak == 'Pilih Nama Pelanggan') ? Colors.grey : Colors.black,
        ),
      ),
    );
  }

  Widget _noTransaksi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: CustomTextStandard(text: 'Invoice', color: Colors.grey)),
          Expanded(
              child: CustomTextStandard(text: ': ${newtrans.notrans ?? 'Auto Number'}', color: Colors.grey
                  //
                  )),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.transparent,
              size: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget _tglTransaksi(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Expanded(
          flex: 2,
          child: CustomTextStandard(
            text: 'Tanggal Transaksi',
            color: Colors.grey,
          ),
        ),
        Expanded(
          flex: 2,
          child: CustomTextStandard(
            text: ': $selectedDate',
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () => _selectDate(context),
          icon: const Icon(
            Icons.more_vert,
            color: Colors.blue,
            size: 20,
          ),
        )
      ]),
    );
  }

  Widget _headlineTransaksi(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomTextStandard(
        text: 'Detail Transaksi',
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget _detailTransaksi(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: newtrans.detail!.length,
      itemBuilder: (context, index) {
        var item = newtrans.detail![index];
        return Card(
          elevation: 1,
          child: ListTile(
            dense: true,
            title: CustomTextStandard(
              text: item.nama,
              fontSize: 10,
              maxlines: 2,
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextStandard(
                            text: item.kode ?? '',
                            color: Colors.grey.shade600,
                            fontSize: 10,
                          ),
                          CustomTextStandard(
                            text: item.merk ?? '',
                            color: (item.merk == 'OLIKE')
                                ? Colors.orange.shade300
                                : (item.merk == 'ORAIMO')
                                    ? const Color.fromARGB(255, 4, 252, 16)
                                    : (item.merk == 'BASEUS')
                                        ? Colors.yellow
                                        : Colors.black,
                            fontSize: 10,
                          ),
                        ],
                      ),
                      CustomTextStandard(
                        text: '${formatangka(item.proses)} ${item.satuan} @ ${formatuang(item.harga)}',
                        color: Colors.grey.shade600,
                        fontSize: 10,
                      ),
                    ],
                  ),
                ),
                // CustomTextStandard(text: formatuang(item.jumlah), fontSize: 10)
              ],
            ),
            trailing: CustomTextStandard(text: formatuang(item.jumlah), fontSize: 10),
          ),
        );
      },
    );
  }

  Widget _totalTransaksi(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const CustomTextStandard(text: 'Sub Total'), CustomTextStandard(text: formatuang(newtrans.nilai))],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const CustomTextStandard(text: 'Diskon'), CustomTextStandard(text: formatuang(newtrans.diskon))],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTextStandard(
                text: 'Total',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomTextStandard(
                text: formatuang(newtrans.nilaitotal),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _bottomBar(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween, // Mengatur tombol agar terdistribusi
      children: [
        // const SizedBox(width: 8), // Spasi antara tombol
        Expanded(
          child: SizedBox(
              width: 100,
              child: ElevatedButton(
                  onPressed: () {
                    Get.offNamedUntil('/penjualan', ModalRoute.withName('/'));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00b3b0), // Mengatur warna latar belakang tombol Simpan
                  ),
                  child: Text('Draf'))),
        ),
        SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                var res = await executeSql3('call post_draft_to_trans(${newtrans.id})');
                if (res.isNotEmpty) {
                  newtrans = TRANSAKSI.fromMap(res.first);
                  var pj = getPenjualanController();

                  pj.pagingController.refresh();
                  pj.pagingDraftController.refresh();
                  await pj.initRekapData();
                  Get.offNamedUntil('/penjualan/rincian', ModalRoute.withName('/penjualan'), arguments: {"item": newtrans});

                  //  await pj.initRekapData();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Mengatur warna latar belakang tombol Simpan
              ),
              child: const CustomTextStandard(
                text: 'Proses',
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
