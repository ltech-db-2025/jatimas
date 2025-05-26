import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/models/kategori.dart';
import 'package:ljm/tools/env.dart';
import 'controller.dart';
import 'edit.dart';

class BrgKategoriPage extends StatefulWidget {
  const BrgKategoriPage({super.key});

  @override
  State<BrgKategoriPage> createState() => _BrgKategoriPageState();
}

class _BrgKategoriPageState extends State<BrgKategoriPage> {
  var c = getKategoriBarangController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daftar Kategori Barang"),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  c.pagingController.refresh();
                  // await c.syncData();
                },
                child: const Icon(Icons.download))
          ],
        ),
        floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () => Get.to(BrgKategoriEditorPage(BARANGKATEGORI()))!.then((value) {
              if (value is BARANGKATEGORI) c.updateBrgKategori(value);
              setState(() {});
            }),
            heroTag: "fab2",
            child: const Icon(Icons.add),
          ),
        ]),
        body: c.loading.value
            ? showloading()
            : RefreshIndicator(
                onRefresh: () async {
                  c.pagingController.refresh();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (x) => c.pagingController.refresh(),
                        decoration: const InputDecoration(
                          labelText: 'Cari Item',
                          hintText: 'Masukkan kata kunci',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Expanded(
                      child: PagingListener(
                        controller: c.pagingController,
                        builder: (context, state, fetchNextPage) => PagedListView<int, BARANGKATEGORI>(
                          state: state,
                          fetchNextPage: fetchNextPage,
                          builderDelegate: PagedChildBuilderDelegate<BARANGKATEGORI>(
                            itemBuilder: (context, data, index) => Center(
                                child: ListTile(
                              title: Text(data.kategori.toString(), textScaler: TextScaler.linear(.8), style: const TextStyle(fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.more_vert),
                              onTap: () {
                                Get.toNamed('/barang/kategori/edit', arguments: data);
                              },
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                )));
  }
}
