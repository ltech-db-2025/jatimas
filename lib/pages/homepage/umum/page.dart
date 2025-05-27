import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/pages/homepage/umum/banner.dart';
import 'package:ljm/pages/homepage/umum/barang.dart';
import 'package:ljm/pages/homepage/umum/kategori2.dart';
import 'package:ljm/provider/models/barang.dart';
import 'controller.dart';
// import 'kategori.dart';

class UmumPage extends StatefulWidget {
  const UmumPage({super.key});

  @override
  State<UmumPage> createState() => _UmumPageState();
}

class _UmumPageState extends State<UmumPage> {
  var c = getBarangUmumController();
  final scrollController = ScrollController();

  final kategoriBarKey = GlobalKey<State<KategoriFilterBar>>();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      (kategoriBarKey.currentState as dynamic)?.closeOverlay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(controller: scrollController, slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          expandedHeight: (Get.width < 400) ? 150 : 500,
          floating: true,
          // snap: true,
          pinned: true,
          leading: Image.asset("assets/data/LogoLeon.png"),
          title: c.isSearching.value
              ? TextField(
                  controller: c.searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white.withValues(alpha: 0.8),
                    filled: true,
                    hintText: 'Cari Produk',
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  ),
                  onChanged: (value) {
                    // Trigger a new search when the text changes
                    c.pagingController.refresh();
                  },
                )
              : const Text('Leontech'),
          centerTitle: true,
          flexibleSpace: FlexibleSpaceBar(
            background: BannerUmum(),
          ),
          actions: [
            IconButton(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              icon: Icon(c.isSearching.value ? Icons.close : Icons.search, color: Colors.white),
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
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                onPressed: () {
                  Get.toNamed('/login');
                },
                icon: Image.asset(
                  'assets/login.png',
                  width: 32,
                  height: 30,
                )),
            SizedBox(width: 10),
          ],
        ),
        SliverToBoxAdapter(
          child: KategoriFilterBar(
            key: kategoriBarKey,
            onFilterApplied: (multiFilters, singleFilters) {},
          ),
          // kategoriWidget(context, c),
        ),
        SliverLayoutBuilder(builder: (context, constraints) {
          double itemWidth = (kIsWeb)
              ? 180.0
              : Platform.isWindows
                  ? 200
                  : 180; // Misal, setiap item butuh lebar 200px
          int crossAxisCount = (constraints.crossAxisExtent / itemWidth).floor();
          // Pastikan setidaknya ada 1 kolom jika lebar layar sangat kecil
          if (crossAxisCount < 1) {
            crossAxisCount = 1;
          }

          return SliverFillRemaining(
              // hasScrollBody: false,
              // fillOverscroll: true,
              child: RefreshIndicator(
                  onRefresh: () async {
                    c.pagingController.refresh();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PagingListener(
                        controller: c.pagingController,
                        builder: (context, state, fetchNextPage) => PagedGridView<int, BARANG>(
                          state: state,
                          fetchNextPage: fetchNextPage,
                          scrollController: scrollController,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount, // Mengatur jumlah kolom dinamis
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                              // childAspectRatio: 0.6, // Aspect ratio untuk item grid
                              mainAxisExtent: (kIsWeb)
                                  ? 380
                                  : (Platform.isWindows)
                                      ? 380
                                      : 350),
                          builderDelegate: PagedChildBuilderDelegate<BARANG>(
                            itemBuilder: (context, item, index) => buildGridItem(context, item),
                          ),
                        ),
                      ),
                    ),
                  )));
        })
      ]),
    );
  }
}
