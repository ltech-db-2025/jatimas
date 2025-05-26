import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'listbarangbarangcontroller.dart';

final _lebarlabel = 70.0;

class PriceList2Page extends StatefulWidget {
  final TRANSAKSI data;
  const PriceList2Page(this.data, {super.key});

  @override
  State<PriceList2Page> createState() => _PriceList2PageState();
}

class _PriceList2PageState extends State<PriceList2Page> {
  late ListBarangController c;

  @override
  void initState() {
    c = cBarang(widget.data);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: c.isSearching.value
              ? TextField(
                  controller: c.searchController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Cari Produk 2',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    // Trigger a new search when the text changes
                    c.pagingController.refresh();
                  },
                )
              : const CustomTextAppBar(text: 'Penjualan'),
          actions: [
            IconButton(
              icon: Icon(c.isSearching.value ? Icons.close : Icons.search),
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
            IconButton(
              visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
              padding: EdgeInsets.zero,
              icon: const Icon(CupertinoIcons.barcode),
              onPressed: () {},
            ),
            const Divider(thickness: 1, color: Colors.white),
            const IconButton(
              visualDensity: VisualDensity(horizontal: -4.0, vertical: -2.0),
              padding: EdgeInsets.zero,
              icon: Icon(Icons.add_circle_outline),
              onPressed: null, //() => Get.to(() => BarangEditorPage(Barang())),
            ),
            const IconButton(visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0), padding: EdgeInsets.zero, icon: Icon(CupertinoIcons.sort_down), onPressed: null //() => c.shuwUrut(context),
                ),
            IconButton(
              visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.settings),
              onPressed: () async {
                await Get.toNamed('/penjualan/pengaturan', arguments: c.pesanan.value);
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
        body: LayoutBuilder(builder: (context, constraints) {
          double itemWidth = 180.0; // Misal, setiap item butuh lebar 200px
          int crossAxisCount = (constraints.maxWidth / itemWidth).floor();

          // Pastikan setidaknya ada 1 kolom jika lebar layar sangat kecil
          if (crossAxisCount < 1) {
            crossAxisCount = 1;
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => (c.loading.value)
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
                        builder: (context, state, fetchNextPage) => PagedGridView<int, BARANG>(
                          state: state,
                          fetchNextPage: fetchNextPage,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount, // Mengatur jumlah kolom dinamis
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              mainAxisExtent: 380),
                          builderDelegate: PagedChildBuilderDelegate<BARANG>(
                            itemBuilder: (context, item, index) => Center(
                              child: BarangListTile(
                                c,
                                item,
                                selectedColumns: c.selectedColumns, // Pass selected columns
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
                    if (c.jml.value > 0)
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onTap: () async {
                              Get.toNamed('/penjualan/baru/rincian', arguments: c.pesanan.value);
                              /* var res = await Get.to(
                          () => InvoiceItemDetailPage(c.pesanan.value));
                      if (res == true) {
                        // await c.initData();
                      } */
                            },
                            tileColor: Colors.amber,
                            title: Text("${c.jml} item"),
                            trailing: RichText(
                                text: TextSpan(children: [
                              TextSpan(text: "Rp. ${formatangka(c.total)}  "),
                              const WidgetSpan(child: Icon(Icons.arrow_forward_ios, size: 16)),
                            ]))
                            /* TextButton.icon(
                        onPressed: () {},
                        label: const Icon(Icons.arrow_forward_ios, size: 16),
                        icon: Text("Rp. ${formatangka(c.total)}"),
                      ), */
                            ),
                      ),
                  ])),
          );
        }));
  }
}

class BarangListTile extends StatefulWidget {
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
  State<BarangListTile> createState() => _BarangListTileState();
}

class _BarangListTileState extends State<BarangListTile> {
  late ListBarangController c;
  late BARANG item;
  DETAIL? d;
  initState() {
    c = widget.c;

    item = widget.item;
    if (c.pesanan.value.detail != null) {
      d = c.pesanan.value.detail!.firstWhereOrNull((element) => element.idbarang == item.id);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var res = await c.tambah(item);
        if (res is DETAIL) {
          setState(() {
            d = res;
          });
        }
      },
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Ubah nilai ini untuk mengatur kelengkungan
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Text(
                textAlign: TextAlign.center,
                item.nama,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
              ),
            ),
            CachedNetworkImage(
                imageUrl: item.fileGambar ?? '', // Placeholder image
                height: 200,
                width: double.infinity,
                fit: BoxFit.scaleDown,
                errorWidget: (context, url, error) => const Icon(Icons.error)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(width: _lebarlabel, child: AutoSizeText('Kategori', style: TextStyle(color: Colors.grey[700]), maxLines: 1)),
                  AutoSizeText(item.kategori ?? '', style: TextStyle(color: Colors.grey[700]), maxLines: 1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(width: _lebarlabel, child: AutoSizeText('Stok', style: TextStyle(color: Colors.grey[700]), maxLines: 1)),
                  AutoSizeText(formatangka(item.stok), style: TextStyle(color: Colors.grey[700]), maxLines: 1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(width: _lebarlabel, child: AutoSizeText('Satuan', style: TextStyle(color: Colors.grey[700]), maxLines: 1)),
                  AutoSizeText(item.satuan, style: TextStyle(color: Colors.grey[700]), maxLines: 1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(width: _lebarlabel, child: AutoSizeText('Merk', style: TextStyle(color: Colors.grey[700]))),
                  AutoSizeText(item.merk, style: TextStyle(color: Colors.grey[700]), maxLines: 1),
                ],
              ),
            ),
            /* Text(d!.proses.toString()),
            if (d != null)
              Padding(
                  padding: const EdgeInsets.only(right: 8, top: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InputQty.int(
                      decimalPlaces: 0,
                      initVal: d!.proses,
                      decoration: QtyDecorationProps(
                        isBordered: false,
                        borderShape: BorderShapeBtn.circle,
                        width: 12,
                        isDense: true,
                      ),
                      onQtyChanged: (p0) async {
                        d?.proses = makeDouble(p0) ?? 0;
                        d?.jumlah = d!.harga * (d!.proses);

                        await c.simpan(d!);
                        await c.hitung();
                      },
                    ),
                  )), */
            if (d == null)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () async {
                        var res = await c.tambah(item);
                        if (res is DETAIL) {
                          setState(() {
                            d = res;
                          });
                        }
                      },
                      child: Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
            if (d != null)
              if (d!.proses != 0)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () async {
                            var res = await c.kurang(item);
                            if (res is DETAIL) {
                              setState(() {
                                d = res;
                              });
                            }
                          },
                          child: Icon(
                            Icons.remove_circle_outline_outlined,
                            color: Colors.red,
                          )),
                      SizedBox(width: 10),
                      Text(formatangka(d!.proses)),
                      SizedBox(width: 10),
                      Icon(Icons.add_circle_outline_outlined),
                    ],
                  ),
                ),
            if (d!.proses == 0)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () async {
                        var res = await c.tambah(item);
                        if (res is DETAIL) {
                          setState(() {
                            d = res;
                          });
                        }
                      },
                      child: Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
          ],
        ),
      ),
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
