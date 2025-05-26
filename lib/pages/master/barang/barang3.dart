import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/pages/master/barang/controller.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/tools/env.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BarangPage3 extends StatefulWidget {
  const BarangPage3({super.key});

  @override
  State<BarangPage3> createState() => _PriceListPageState();
}

class _PriceListPageState extends State<BarangPage3> {
  var c = getBarangController();
  @override
  void initState() {
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
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: c.isSearching.value
            ? TextField(
                controller: c.searchController,
                decoration: const InputDecoration(
                  hintText: 'Cari Produk',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  // Trigger a new search when the text changes
                  c.pagingController.refresh();
                },
              )
            : const CustomTextAppBar(text: 'Daftar Barang3 dan Jasa'),
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
            icon: Icon(
              Icons.add_circle_outline,
              color: background,
            ),
            onPressed: null, //() => Get.to(() => BarangEditorPage(Barang())),
          ),
          const IconButton(
              visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
              padding: EdgeInsets.zero,
              icon: Icon(
                CupertinoIcons.sort_down,
                color: background,
              ),
              onPressed: null //() => c.shuwUrut(context),
              ),
          IconButton(
            visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.settings,
              color: background,
            ),
            onPressed: () async {
              await Get.toNamed('/penjualan/pengaturan');
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
      body: Obx(() => Column(children: [
            Text(c.trigger.toString(), style: const TextStyle(color: Colors.white70, fontSize: 2)),
            SizedBox(
                height: 30,
                child: Row(
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
                c.pagingController.refresh();
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
          ])),
    );
  }
}

class BarangListTile extends StatelessWidget {
  final BarangController c;
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
    return ListTile(
      // Image.asset('assets/images/logo.png')
      leading: item.gambar != null
          ? CachedNetworkImage(
              imageUrl: item.fileGambar ?? '',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
/*               placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()), */
              errorWidget: (context, url, error) => const Icon(Icons.error), // Menangani kesalahan
            )
          : null,
      title: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => Get.toNamed('/barang/detail3', arguments: item),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(item.fileGambar.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: item.nama),
                        TextSpan(text: "  [${item.merk}]", style: TextStyle(color: Colors.blue[900])),
                      ],
                    ),
                  ),
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
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
                      style: const TextStyle(color: Colors.black),
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
