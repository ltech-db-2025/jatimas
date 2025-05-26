import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/models/barangjenis.dart';
import 'package:ljm/tools/env.dart';

import 'controller.dart';

class BrgJenisPage extends StatefulWidget {
  const BrgJenisPage({super.key});

  @override
  State<BrgJenisPage> createState() => _BrgJenisPageState();
}

class _BrgJenisPageState extends State<BrgJenisPage> {
  var c = Get.put(getJensiBarangController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Daftar Jenis Barang"),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  c.pagingController.refresh();
                },
                child: const Icon(Icons.download))
          ],
        ),
        floatingActionButton: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () => Get.toNamed('/barang/jenis/baru')!.then((value) {
              if (value is BARANGJENIS) c.updateBrgJenis(value);
              setState(() {});
            }),
            heroTag: "fab2",
            child: const Icon(Icons.add),
          ),
        ]),
        body: Obx(() => c.loading.value
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
                        onChanged: (e) => c.pagingController.refresh(),
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
                        builder: (context, state, fetchNextPage) => PagedListView<int, BARANGJENIS>(
                          state: state,
                          fetchNextPage: fetchNextPage,
                          builderDelegate: PagedChildBuilderDelegate<BARANGJENIS>(
                            itemBuilder: (context, data, index) => Center(
                                child: ListTile(
                              title: Text(data.jenis.toString(), textScaler: TextScaler.linear(.8), style: const TextStyle(fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.more_vert),
                              onTap: () {
                                Get.toNamed('/barang/jenis/edit', arguments: data);
                              },
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
