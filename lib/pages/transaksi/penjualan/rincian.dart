import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/provider/connection.dart';
// import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

class RincianPenjualan extends StatefulWidget {
  final TRANSAKSI item;

  const RincianPenjualan({super.key, required this.item});

  @override
  State<RincianPenjualan> createState() => _RincianPenjualanState();
}

class _RincianPenjualanState extends State<RincianPenjualan> {
  var pageSize = 10; // jumlah records per loading
  late final pagingController = PagingController<int, dynamic>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);
  late final pagingBarangKosongController = PagingController<int, dynamic>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPageBarangKosong);
  late final pagingPembayaranController = PagingController<int, dynamic>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPagePembayaran);
// final ac = Get.find<AppController>();
  var item = TRANSAKSI();

  @override
  void initState() {
    item = widget.item;

    cekKelengkapandata();
    super.initState();
  }

  Future<List<dynamic>> fetchPage(int pageKey) async {
    // dp("item:=> ${item}");
    String sql = """
      select d.idbarang, b.kode, b.nama, m.merk, d.proses, d.qty, s.satuan, d.harga, d.jumlah, d.diskon, d.total 
      from detail d 
      inner join barang b  on b.id = d.idbarang 
      left  join brgmerk m on m.id = b.idmerk 
      left join satuan s on s.id = d.idsatuan
      where d.idtrans = ${item.id} and d.qty > 0
    """;

    sql += " ORDER BY b.nama LIMIT $pageSize OFFSET $pageKey";
    final newItems = await executeSql(sql);
    return newItems;
  }

  Future<List<dynamic>> fetchPageBarangKosong(int pageKey) async {
    String sql = """
      select d.idbarang, b.kode, b.nama, m.merk, d.proses qty, s.satuan, d.harga, d.jumlah, d.diskon, d.total 
      from detail d 
      inner join barang b  on b.id = d.idbarang 
      left  join brgmerk m on m.id = b.idmerk 
      left join satuan s on s.id = d.idsatuan
      where d.idtrans = ${item.id} and coalesce(d.qty,0) = 0
    """;

    sql += " ORDER BY b.nama LIMIT $pageSize OFFSET $pageKey";

    final newItems = await executeSql(sql);
    return newItems;
  }

  Future<List<dynamic>> fetchPagePembayaran(int pageKey) async {
    // dp("item:=> ${item}");
    String sql = """
      select t.tanggal, t.id, k.nilai bayar 
      from kas k 
      inner join transaksi t on t.id = k.idtrans and kdtrans = 'PP'
      where k.refidtrans = ${item.id}
    """;

    sql += " ORDER BY t.tanggal LIMIT $pageSize OFFSET $pageKey";
    final newItems = await executeSql(sql);
    return newItems;
  }

  cekKelengkapandata() async {
    var asql = '';

    var fields = '';
    var joins = '';

    if (item.idkontak == null) fields += 't.idkontak, ';
    if (item.idlokasi == null) fields += 't.idlokasi, ';
    if (item.lokasi == null) fields += 't.lokasi, ';
    if (item.idpegawai == null) fields += 't.idpegawai, ';
    if (item.tempo == null) fields += 't.tempo, ';

    if (item.lokasi == null) fields += 'p.lokasi, ';
    if (item.pegawai == null) fields += 'p.pegawai, ';
    if (item.namakontak == null || item.kontak == null || item.alamat_kirim == '') {
      fields += 'k.nama namakontak, k.kode kontak, k.alamat_kirim, ';
      joins += 'left join kontak k on k.id = t.idkontak ';
    }
    if (fields.isNotEmpty) fields = fields.substring(0, fields.length - 2);
    if (joins.isNotEmpty) joins = joins.substring(0, joins.length - 1);
    if (fields.isNotEmpty || joins.isNotEmpty) {
      asql = 'select $fields from transaksi t $joins where t.id = ${item.id} ';
      var res = [];
      try {
        res = await executeSql(asql);
        if (res.isNotEmpty) {
          item.idlokasi ??= makeInt(res.first["idlokasi"]);
          item.lokasi ??= res.first["lokasi"];

          item.idpegawai ??= makeInt(res.first["idpegawai"]);
          item.pegawai ??= res.first["pegawai"];

          item.idkontak ??= makeInt(res.first["idkontak"]);
          item.kontak ??= res.first["kontak"];
          item.namakontak ??= res.first["namakontak"];
          item.alamat_kirim = res.first["alamat_kirim"];
        } else {}
      } catch (e) {
        dp("error => :$e");
        dp(asql);
        dp('-----------------');
        dp("res: $res");
      }
    }
  }

  // final String telephoneNumber = '123-456-7890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // forceMaterialTransparency: true,
        // backgroundColor: Colors.white,
        title: const CustomTextStandard(
          text: 'Rincian Invoice Penjualan',
          fontSize: 14,
          fontWeight: FontWeight.bold,
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
                          item.detail = pagingController.items!.map((e) => DETAIL.fromMap(e)).toList();
                          // Get.to(() => TransactionNoteApp(item));
                          // Navigator.pop(context);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dataPelanggan(context),

          Divider(height: 20, thickness: 2),
          // const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Expanded(child: CustomTextStandard(text: 'Invoice', color: Colors.grey, fontSize: 11)),
                Expanded(child: CustomTextStandard(text: ': ${item.id}', fontSize: 11)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Expanded(child: CustomTextStandard(text: 'Tanggal', color: Colors.grey, fontSize: 11)),
                Expanded(child: CustomTextStandard(text: ": ${formattanggal(item.tanggal, 'EEEE, dd MMMM yyyy HH:mm:ss')}", fontSize: 11)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Expanded(child: CustomTextStandard(text: 'Jatuh Tempo', color: Colors.grey, fontSize: 11)),
                Expanded(child: CustomTextStandard(text: ": ${formattanggal(item.tempo, 'EEEE, dd MMMM yyyy')}", fontSize: 11)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(child: CustomTextStandard(text: 'Cabang', color: Colors.grey, fontSize: 11)),
                Expanded(child: CustomTextStandard(text: ": ${item.devisi}", fontSize: 11)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Expanded(child: CustomTextStandard(text: 'Gudang', color: Colors.grey, fontSize: 11)),
                Expanded(child: CustomTextStandard(text: ': ${item.lokasi}', fontSize: 11)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Expanded(child: CustomTextStandard(text: 'Sales', color: Colors.grey, fontSize: 11)),
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            showDragHandle: true,
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    title: const CustomTextStandard(
                                      text: 'Dibuat Oleh',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context); // Fungsi untuk menutup modal
                                      },
                                      child: const Icon(Icons.cancel),
                                    ),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    title: CustomTextStandard(text: 'Nama Pengguna', color: Colors.grey),
                                    trailing: CustomTextStandard(text: item.pegawai ?? ''),
                                  ),
                                  ListTile(
                                    title: CustomTextStandard(text: 'Tanggal', color: Colors.grey),
                                    trailing: CustomTextStandard(text: formattanggal(item.tanggal, 'EEEE, dd MMMM yyyy')),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: CustomTextStandard(text: ': ${item.pegawai}', color: Colors.red, fontSize: 11))),
              ],
            ),
          ),

          if (pagingPembayaranController.items?.isNotEmpty ?? false)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomTextStandard(text: 'Pembayaran', fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          if (pagingPembayaranController.items?.isNotEmpty ?? false) const Divider(),
          SizedBox(
            height: (pagingPembayaranController.items == null) ? 0 : (pagingPembayaranController.items?.length ?? 0) * 30,
            child: PagingListener(
              controller: pagingPembayaranController,
              builder: (context, state, fetchNextPage) => PagedListView<int, dynamic>(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  itemBuilder: (context, item, index) {
                    var data = TRANSAKSI.fromMap(item);
                    return ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      dense: true,
                      onTap: () => Get.toNamed('/piutang/pelunasan/rincian', arguments: data),
                      leading: CustomTextStandard(text: data.id.toString(), textAlign: TextAlign.right),
                      title: CustomTextStandard(text: formatuang(data.bayar)),
                      trailing: CustomTextStandard(text: formattanggal(data.tanggal)),
                    );
                  },
                ),
              ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextStandard(text: 'Rincian Penjualan', fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(child: SingleChildScrollView(child: _rincianInvoicePenjualan(context)))
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 110, // Set ukuran height yang sesuai untuk BottomAppBar
        child: _bottomBar(context),
      ),
    );
  }

  Widget _dataPelanggan(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              const CircleAvatar(radius: 40, backgroundColor: Colors.red, child: Icon(Icons.person, size: 60, color: Colors.white)),
            ],
          )),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: CustomTextStandard(text: item.kontak ?? '', color: Colors.grey, fontSize: 10)),
                      InkWell(onTap: () => Get.toNamed('/kontak/pelanggan/detail', arguments: {"kontak": KONTAK(id: item.idkontak)}), child: Icon(Icons.edit, size: 14)),
                    ],
                  ),
                  CustomTextStandard(
                    text: item.namakontak ?? '',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    maxlines: 2,
                  ),
                  CustomTextStandard(
                    text: item.alamat_kirim,
                    fontSize: 11,
                    maxlines: 4,
                  ),
                  /* Row(
                    children: [
                      Icon(
                        Icons.phone_android,
                        size: 12,
                      ),
                      Expanded(child: CustomTextStandard(text: 'No. Telephone : $telephoneNumber', fontSize: 11)),
                      InkWell(
                        onTap: () {
                          _copyToClipboard(context, telephoneNumber);
                        },
                        child: Icon(
                          Icons.copy,
                          size: 12,
                        ),
                      ),
                    ],
                  ), */
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rincianInvoicePenjualan(BuildContext context) {
    return Column(
      children: [
        // ListTile(
        //   title: const CustomTextStandard(text: 'Daftar Produk', fontSize: 16, fontWeight: FontWeight.bold),
        //   trailing: GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.cancel)),
        // ),
        // const Divider(),
        PagingListener(
          controller: pagingController,
          builder: (context, state, fetchNextPage) => PagedListView<int, dynamic>(
            state: state,
            fetchNextPage: fetchNextPage,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<dynamic>(
              itemBuilder: (context, item, index) {
                var data = DETAIL.fromMap(item);
                return ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  dense: true,
                  title: CustomTextStandard(text: data.nama),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextStandard(
                        text: data.kode ?? '',
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                      if ((data.qty) < (data.proses)) CustomTextStandard(text: 'Order: ${formatangka(data.proses)} ${data.satuan}', color: Colors.blue),
                      CustomTextStandard(
                        text: '${formatangka(data.qty)} ${data.satuan} @ ${formatuang(data.harga)}',
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ],
                  ),
                  trailing: CustomTextStandard(
                    text: formatuang(data.jumlah),
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),
        ),
        PagingListener(
          controller: pagingBarangKosongController,
          builder: (context, state, fetchNextPage) => PagedListView<int, dynamic>(
            state: state,
            fetchNextPage: fetchNextPage,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            builderDelegate: PagedChildBuilderDelegate<dynamic>(
              firstPageProgressIndicatorBuilder: (context) => const Text(''),
              noItemsFoundIndicatorBuilder: (context) => const Center(child: CustomTextStandard(text: 'Semua Orderan Terpenuhi', color: Colors.green)),
              itemBuilder: (context, item, index) {
                var data = DETAIL.fromMap(item);
                if (index == 0) {
                  return Column(
                    children: [
                      const Divider(),
                      const Center(child: CustomTextStandard(text: 'Item Tidak Terpenuhi', color: Colors.red)),
                      ListTile(
                        visualDensity: const VisualDensity(vertical: -4),
                        dense: true,
                        title: CustomTextStandard(text: data.nama, color: Colors.grey),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextStandard(text: data.kode ?? '', color: Colors.grey),
                            CustomTextStandard(text: '${formatangka(data.qty)} ${data.satuan} @ ${formatuang(data.harga)}', color: Colors.grey),
                          ],
                        ),
                        trailing: CustomTextStandard(text: formatuang(data.jumlah), color: Colors.grey),
                      )
                    ],
                  );
                }
                return ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  dense: true,
                  title: CustomTextStandard(text: data.nama, color: Colors.grey),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextStandard(text: data.kode ?? '', color: Colors.grey),
                      CustomTextStandard(text: '${formatangka(data.qty)} ${data.satuan} @ ${formatuang(data.harga)}', color: Colors.grey),
                    ],
                  ),
                  trailing: CustomTextStandard(text: formatuang(data.jumlah), color: Colors.grey),
                );
              },
            ),
          ),
        ),
        // const Divider(),
        // Padding(
        //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const CustomTextStandard(text: 'Sub Total'),
        //       CustomTextStandard(text: formatuang(item.nilai)),
        //     ],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const CustomTextStandard(text: 'Diskon'),
        //       CustomTextStandard(text: formatuang(item.diskon)),
        //     ],
        //   ),
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 16.0, right: 16.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [CustomTextStandard(text: 'PPN'), CustomTextStandard(text: 'Rp. 0')],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const CustomTextStandard(text: 'Total', fontSize: 14, fontWeight: FontWeight.bold),
        //       CustomTextStandard(text: formatuang(item.nilaitotal), fontSize: 14, fontWeight: FontWeight.bold),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _bottomBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Divider(height: 10, thickness: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const CustomTextStandard(text: 'Sub Total', fontSize: 11), CustomTextStandard(text: formatuang(item.nilaitotal), fontSize: 11)],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const CustomTextStandard(text: 'Diskon', fontSize: 11), CustomTextStandard(text: formatuang(item.diskon), fontSize: 11)],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CustomTextStandard(text: 'PPN', fontSize: 11), CustomTextStandard(text: 'Rp. 0', fontSize: 11)],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const CustomTextStandard(text: 'Total', fontWeight: FontWeight.bold), CustomTextStandard(text: formatuang(item.nilaitotal), fontWeight: FontWeight.bold)],
          ),
        )
      ],
    );
  }
}
