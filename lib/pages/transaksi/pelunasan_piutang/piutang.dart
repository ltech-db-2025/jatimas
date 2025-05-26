import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

import 'controller.dart';

class PelunasanPiutangPage extends StatefulWidget {
  const PelunasanPiutangPage({super.key});

  @override
  State<PelunasanPiutangPage> createState() => _PelunasanPiutangPageState();
}

class _PelunasanPiutangPageState extends State<PelunasanPiutangPage> {
  var c = getPelunasanPiutangController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pelunasan Piutang')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/pelunasan/piutang/baru');
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
                child: PagingListener(
                  controller: c.pagingController,
                  builder: (context, state, fetchNextPage) => PagedListView<int, TRANSAKSI>(
                    state: state,
                    fetchNextPage: fetchNextPage,
                    builderDelegate: PagedChildBuilderDelegate<TRANSAKSI>(
                      itemBuilder: (context, item, index) {
                        return ListTile(
                          onTap: () {
                            Get.toNamed('/piutang/pelunasan/rincian', arguments: item);
                          },
                          tileColor: (DateTime.parse(item.tanggal ?? '').month == DateTime.now().month) ? Colors.white : Colors.grey[100],
                          dense: true,
                          leading: Text(
                            "${formattanggal(item.tanggal, 'dd/MM')}\n${formattanggal(item.tanggal, 'yyy')}",
                            textAlign: TextAlign.center,
                          ),
                          title: Text(item.notrans ?? ''),
                          subtitle: Text("${item.kontak ?? ''} - ${item.namakontak}"),
                          trailing: SizedBox(
                              width: 80,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formatuang(item.nilai),
                                    style: TextStyle(fontSize: 12),
                                  ))),
                        );
                      },
                      firstPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                      newPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                      noItemsFoundIndicatorBuilder: (_) => const Center(child: Text('No items found')),
                    ),
                  ),
                ),
                onRefresh: () async => await c.refreshData()),
          ),
          Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Total Bulan ini"),
                  Text(" : "),
                  Obx(() => Text(
                        formatuang(c.total.value),
                        style: TextStyle(fontWeight: FontWeight.bold),
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
