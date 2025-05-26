import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/pages/homepage/sales/controller.dart';
import 'package:ljm/pages/homepage/widgets/inputangka.dart';
// import 'package:ljm/pages/homepage/widgets/inputangka.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/provider/models/users/akseslokasi.dart';
import 'package:ljm/tools/env.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'listbarangbarangcontroller.dart';

class PriceListPage extends StatefulWidget {
  final TRANSAKSI? data;
  const PriceListPage({this.data, super.key});

  @override
  State<PriceListPage> createState() => _PriceListPageState();
}

class _PriceListPageState extends State<PriceListPage> {
  TRANSAKSI? nT;
  late ListBarangController c;
  var judul = 'Pesanan';
  var lokasi = '';
  bool isLoading = true;
  @override
  void initState() {
    if (widget.data == null) judul = 'Price List';
    initdata();
    super.initState();
  }

  initdata() async {
    nT = widget.data ?? getSalesController().transaksi.value;
    if (nT != null) {
      c = cBarang(nT!);
      if (user.akseslokasi != null && nT != null) {
        AksesLokasi? auser = user.akseslokasi!.firstWhereOrNull((e) => e.idlokasi == nT!.idlokasi);
        if (auser != null) {
          judul += '  [${auser.kode}]';
        } else {
          if (nT!.lokasi != null) judul += '  [${nT!.lokasi}]';
        }
      }
      isLoading = false;
      setState(() {});
    } else {
      dp('nt null');
    }
    ;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Mengatur warna icon menjadi putih
        ),
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: isLoading
            ? null
            : c.isSearching.value
                ? TextField(
                    controller: c.searchController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Cari Produk',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      // Trigger a new search when the text changes
                      c.pagingController.refresh();
                    },
                  )
                : Text(judul, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)),
        actions: isLoading
            ? null
            : [
                IconButton(
                  icon: Icon(
                    c.isSearching.value ? Icons.close : Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      c.isSearching.value = !c.isSearching.value;
                      if (!c.isSearching.value) {
                        c.searchController.clear();
                        c.pagingController.refresh(); // Refresh the list
                      }
                    });
                  },
                ),
                /*  IconButton(
                  visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                  padding: EdgeInsets.zero,
                  icon: const Icon(CupertinoIcons.barcode, color: Colors.white),
                  onPressed: () {},
                ), */
                const Divider(thickness: 1, color: Colors.white),
                IconButton(
                  visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () async {
                    await Get.toNamed('/penjualan/pengaturan', arguments: {
                      "data": c.pesanan.value,
                      "pilihharga": false,
                      "pilihlokasi": true,
                      "onLokasiChanged": (p0) {
                        if (p0 != null) {
                          c.pesanan.value.idlokasi = p0.id;
                          c.pesanan.value.lokasi = p0.kode;
                        }
                      }
                    });
                    //Get.to(() => const PengaturanPenjualan());
                    c.setPengaturan();
                  },
                ),
                const SizedBox(width: 10.0),

                // Column Selection Button
                /* PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                // Update selected columns based on user selection
                if (c.selectedColumns.contains(value)) {
                  c.selectedColumns.remove(value);
                } else {
                  c.selectedColumns.add(value);
                }
                c.pagingController.refresh(); // Refresh the list
              });
            },
            itemBuilder: (context) {
              return c.availableColumns.map((column) {
                return PopupMenuItem<String>(
                  value: column,
                  child: Text(column),
                );
              }).toList();
            },
          ), */
              ],
      ),
      body: isLoading
          ? showloading()
          : Obx(() => (c.loading.value)
              ? LoadingList()
              : Column(children: [
                  Text(c.trigger.toString(), style: const TextStyle(color: Colors.white70, fontSize: 2)),
                  SizedBox(
                      height: 30,
                      child: c.loading.value
                          ? const SizedBox()
                          : Row(
                              children: [
                                JenisLayanan(
                                  c.kategoriCap.value,
                                  isSelected: true,
                                  onTap: () {
                                    c.kategoriChange(-6);
                                  },
                                  onLongPress: () {
                                    List<PopupMenuEntry> lit = [
                                      PopupMenuItem(
                                        height: 20,
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Semua'),
                                            if (-6 == c.selectedJenis.value) const Icon(Icons.check, size: 12),
                                          ],
                                        ),
                                        onTap: () {
                                          c.kategoriChange(-6);
                                          //  scrollController.animateTo(double.parse(i.toString()) * lebarkolom, duration: Duration(seconds: 1), curve: Curves.ease);
                                        },
                                      )
                                    ];

                                    for (int n = 0; n < c.brgKategori.length; n++) {
                                      lit.add(PopupMenuItem(
                                        height: 20,
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(c.brgKategori[n].kategori ?? ''),
                                            if (c.brgKategori[n].id == c.selectedJenis.value) const Icon(Icons.check, size: 12),
                                          ],
                                        ),
                                        onTap: () {
                                          c.kategoriChange(c.brgKategori[n].id ?? 0);
                                          // scrollController.animateTo(double.parse(n.toString()) * lebarkolom, duration: Duration(seconds: 1), curve: Curves.ease);
                                        },
                                      ));
                                    }
                                    showMenu(
                                      context: context,
                                      position: const RelativeRect.fromLTRB(0, 0, 0, 0),
                                      items: lit,
                                    );
                                  },
                                ),
                                Expanded(
                                    child: ListView.builder(
                                        controller: c.scrollController.value,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: c.brgKategori.length,
                                        itemBuilder: (context, i) {
                                          return JenisLayanan(
                                            c.brgKategori[i].kategori.toString(),
                                            isSelected: (c.brgKategori[i].id == c.selectedJenis.value),
                                            onTap: () {
                                              c.kategoriChange(c.brgKategori[i].id ?? 0);
                                            },
                                          );
                                        }))
                              ],
                            )),
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: () async {
                      await c.reLoad();
                    },
                    child: PagingListener(
                      controller: c.pagingController,
                      builder: (context, state, fetchNextPage) => PagedListView<int, BARANG>(
                        state: state,
                        fetchNextPage: fetchNextPage,
                        builderDelegate: PagedChildBuilderDelegate<BARANG>(
                          itemBuilder: (context, data, index) => Center(
                            child: BarangListTile(
                              c,
                              data,
                              selectedColumns: c.selectedColumns, // Pass selected columns
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                  if (c.jml.value > 0)
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await c.deleteall();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                onTap: () async {
                                  await Get.toNamed('/penjualan/baru/rincian', arguments: c);
                                  c.pagingController.refresh();
                                },
                                tileColor: Color(0xFF00b3b0),
                                title: Text(
                                  "${c.jml} item",
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(text: "Rp. ${formatangka(c.total)}  "),
                                  const WidgetSpan(
                                      child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.white,
                                  )),
                                ]))),
                          ),
                        ),
                      ],
                    ),
                ])),
    );
  }
}

class BarangListTile extends StatelessWidget {
  final ListBarangController c;
  final BARANG item;
  final List<String> selectedColumns; // Receive selected columns

  const BarangListTile(
    this.c,
    this.item, {
    super.key,
    required this.selectedColumns,
  });

  @override
  Widget build(BuildContext context) {
    DETAIL? d;
    if (c.pesanan.value.detail != null) {
      d = c.pesanan.value.detail!.firstWhereOrNull((element) => element.idbarang == item.id);
    }

    return ListTile(
      // Image.asset('assets/images/logo.png')
      leading: item.gambar != null
          ? CachedNetworkImage(
              fadeInDuration: Duration.zero,
              fadeOutDuration: Duration.zero,
              imageUrl: item.fileGambar ?? '',
              width: 50,
              height: 50,

              fit: BoxFit.cover,
/*               placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()), */
              errorWidget: (context, url, error) => const Icon(Icons.error), // Menangani kesalahan
            )
          : SizedBox(
              width: 50,
              height: 50,
              child: const Icon(Icons.warning),
            ),
      title: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () => c.tambah(item),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(item.fileGambar.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  RichText(
                    maxLines: 2,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: item.nama, style: TextStyle(fontSize: 12)),
                        TextSpan(text: "  [${item.merk}]", style: TextStyle(color: Color(0xFF00b3b0), fontSize: 12)),
                      ],
                    ),
                  ),
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                      children: [
                        const TextSpan(text: 'Rp. '),
                        TextSpan(text: formatangka(item.harga)),
                        TextSpan(text: "  / ${item.satuan}"),
                      ],
                    ),
                  ),
                  if ((item.nostok ?? 0) != 1)
                    RichText(
                        text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        const TextSpan(text: "Stok  "),
                        TextSpan(
                          text: formatangka(item.stok ?? 0),
                          style: TextStyle(
                            color: ((item.stok ?? 0) > 0) ? Colors.green[900] : Colors.red[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
                ],
              ),
            ),
          ),
        ],
      ),
      trailing: (d != null)
          ? TextButton.icon(
              onPressed: () async {
                String sat = (item.idsatuan != null) ? '(${item.satuan})' : '';
                await showDoubleDialog(
                  context,
                  d?.proses ?? 0,
                  label: 'Masukkan Qty $sat',
                  onDelete: () async {
                    await c.delete(d!);
                    //if (res) {
                    c.pesanan.value.detail!.removeWhere((element) => element.idtrans == d!.idtrans && element.idbarang == item.id);
                    c.pagingController.refresh();
                    Get.back();
                    c.hitung();
                    Get.snackbar('title', 'Item dihapus dari ranjang', snackPosition: SnackPosition.BOTTOM);
                    // }
                  },
                  onSubmit: (p0) async {
                    var _lanjut = true;
                    if (p0 > (item.stok ?? 0)) _lanjut = await konfirmasi("Stok tidak mencukup!!\nStok: ${formatangka(item.stok)}\nPesanan: ${formatangka(p0)}") ?? false;
                    if (_lanjut) {
                      d?.proses = p0;
                      d?.jumlah = d.harga * (d.proses);
                      var i = c.pesanan.value.detail!.indexWhere((element) => element.idtrans == d!.idtrans && element.idbarang == item.id);
                      c.pesanan.value.detail!.removeAt(i);
                      c.pesanan.value.detail!.insert(i, d!);
                      Get.back();
                      await c.simpan(d);
                      await c.hitung();
                      // c.pagingController.refresh();
                    }
                  },
                  buttonBuilder: (context, onDelete, onSubmit) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              await onDelete!(); // Panggil fungsi delete
                              Get.back();
                            },
                            child: Text('Delete'),
                          ),
                        ),
                        SizedBox(width: 10), // Jarak antara tombol
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              onSubmit(d?.proses ?? 0); // Panggil fungsi submit dengan proses
                              Get.back();
                            },
                            child: Text('Submit'),
                          ),
                        ),
                        SizedBox(width: 10), // Jarak antara tombol
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Get.back(), // Kembali tanpa tindakan
                            child: Text('Cancel'),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit, color: Color(0xFF00b3b0)),
              label: Text(formatangka(d.proses.toString()), style: TextStyle(color: ((d.proses) > (item.stok ?? 0)) ? Colors.red : mainColor)),
            )
          : null,
    );
  }
}

class JenisLayanan extends StatelessWidget {
  final String layanan;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  const JenisLayanan(this.layanan, {this.isSelected = false, required this.onTap, this.onLongPress, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: MaterialButton(
        onLongPress: onLongPress,
        onPressed: onTap,
        color: isSelected ? Colors.black54 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        child: Text(layanan, style: TextStyle(fontSize: 10, color: isSelected ? Colors.white : Colors.black45)),
      ),
    );
  }
}
