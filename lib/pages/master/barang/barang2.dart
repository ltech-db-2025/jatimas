import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/tools/env.dart';
import 'controller.dart';

class BarangPage2 extends StatefulWidget {
  const BarangPage2({super.key});

  @override
  State<BarangPage2> createState() => _BarangPage2State();
}

class _BarangPage2State extends State<BarangPage2> {
  var c = getBarangController();
  final lebarlabel = 70.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            : const Text('Daftar Barang dan Jasa'),
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
          child: PagingListener(
            controller: c.pagingController,
            builder: (context, state, fetchNextPage) => PagedGridView<int, BARANG>(
              state: state,
              fetchNextPage: fetchNextPage,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount, // Mengatur jumlah kolom dinamis
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  // childAspectRatio: 0.6, // Aspect ratio untuk item grid
                  mainAxisExtent: 380),
              builderDelegate: PagedChildBuilderDelegate<BARANG>(
                itemBuilder: (context, item, index) => buildGridItem(item),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildGridItem(BARANG data) {
    return Card(
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
              data.nama,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
            ),
          ),
          CachedNetworkImage(
              imageUrl: data.fileGambar ?? '', // Placeholder image
              height: 200,
              width: double.infinity,
              fit: BoxFit.scaleDown,
              errorWidget: (context, url, error) => const Icon(Icons.error)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(width: lebarlabel, child: AutoSizeText('Kategori', style: TextStyle(color: Colors.grey[700]), maxLines: 1)),
                AutoSizeText(data.kategori ?? '', style: TextStyle(color: Colors.grey[700]), maxLines: 1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(width: lebarlabel, child: AutoSizeText('Stok', style: TextStyle(color: Colors.grey[700]), maxLines: 1)),
                AutoSizeText(formatangka(data.stok), style: TextStyle(color: Colors.grey[700]), maxLines: 1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(width: lebarlabel, child: AutoSizeText('Satuan', style: TextStyle(color: Colors.grey[700]), maxLines: 1)),
                AutoSizeText(data.satuan, style: TextStyle(color: Colors.grey[700]), maxLines: 1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(width: lebarlabel, child: AutoSizeText('Merk', style: TextStyle(color: Colors.grey[700]))),
                AutoSizeText(data.merk, style: TextStyle(color: Colors.grey[700]), maxLines: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
