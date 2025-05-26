import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/foundation.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/homepage/sales/widgets/chart.dart';
import 'package:ljm/pages/master/kontak/page.dart';
import 'package:ljm/pages/transaksi/penjualan/baru/listbarang.dart';

import 'package:ljm/pages/users/login2/login.dart';
import 'package:ljm/main.dart';
import 'package:ljm/provider/models/dashboard/top.dart';
import 'package:ljm/tools/env.dart';
import 'package:shimmer/shimmer.dart';

import '../../../provider/models/user.dart';
import 'controller.dart';

part 'repos.dart';
part 'events.dart';
part 'widgets/transaksi_btn.dart';
part 'widgets/drawer.dart';
part 'widgets/menugrid.dart';
part 'widgets/top10.dart';

class DBSales extends StatefulWidget {
  final User user;

  const DBSales(this.user, {Key? key}) : super(key: key);

  @override
  _DBSalesState createState() => _DBSalesState();
}

class _DBSalesState extends State<DBSales> {
  final GlobalKey<ScaffoldState> _salesScaffoldKey = GlobalKey<ScaffoldState>();
  final DBSalesController controller = Get.find<DBSalesController>();
  bool _isButtonVisible = false;
  final List<String> _titles = [
    'LEONTECH',
    'Pesanan',
    '2',
    'Data Pelanggan',
    'Profil',
  ];

  void _onItemTapped(int index) {
    _isButtonVisible = false;
    setState(() {
/*       switch (index) {
        case 1
          
          break;
        default:
      } */
      controller.activePage.value = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(skala)),
        child: Obx(() => Scaffold(
              key: _salesScaffoldKey,
              drawer: drawer(context, (i) => _onTapDrawer(i)),
              appBar: (controller.activePage == 1)
                  ? null
                  : AppBar(
                      elevation: 0,
                      leading: InkWell(onTap: () => _salesScaffoldKey.currentState!.openDrawer(), child: Icon(Icons.menu, color: Colors.white)
                          // buildUserAvatar() punya wak upi
                          ),

                      title: Text(_titles[controller.activePage.value]),
                      // title: Text('${user.nama} LEONTECH', style: TextStyle(color: Colors.deepOrange)),
                      actions: [
                        Image.asset(
                          "assets/logoleonputih.png", // Ganti dengan path yang sesuai
                          height: 80, // Atur tinggi gambar sesuai kebutuhan
                          width: 80, // Atur lebar gambar sesuai kebutuhan
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        controller.isProsesDashboard.value ? showLoading3() : Padding(padding: const EdgeInsets.only(right: 20.0), child: GestureDetector(onTap: () => controller.getData(true), child: const Icon(Icons.refresh, color: Colors.white))),
                      ],
                    ),
              body: (controller.isLoading.value) ? showloading() : _bodyx(context, controller),
              floatingActionButton: Stack(
                clipBehavior: Clip.none,

                // alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    bottom: 10,
                    left: MediaQuery.of(context).size.width / 2 - 185,
                    child: _isButtonVisible
                        ? Container(
                            // color: Colors.yellow,
                            height: 100,
                            width: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildActionButton(Icons.add, 'Penjualan', () {
                                  Get.toNamed('/penjualan/baru');
                                }),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center, // Atau sesuai keinginan Anda
                                  children: [
                                    _buildActionButton(Icons.person_add, 'Pelanggan', () {
                                      Get.toNamed('/kontak/baru');
                                    }),
                                    SizedBox(width: 60), // Menambahkan jarak 16 piksel antara tombol
                                    _buildActionButton(Icons.swap_horiz, 'Mutasi', () {}),
                                  ],
                                )
                              ],
                            ))
                        : SizedBox.shrink(),
                  )
                ],
              ),
              bottomNavigationBar: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45.withValues(alpha: 0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: ClipPath(
                      clipper: InnerCurveClipper(),
                      child: BottomNavigationBar(
                        elevation: 0,
                        backgroundColor: Colors.white,
                        type: BottomNavigationBarType.fixed,
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.home),
                            ),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Icon(Icons.shopping_cart_checkout),
                            ),
                            label: 'Barang',
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Icon(Icons.notifications),
                            ),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Icon(Icons.notifications),
                            ),
                            label: 'Pelanggan',
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.person),
                            ),
                            label: 'Profile',
                          ),
                        ],
                        currentIndex: controller.activePage.value,
                        selectedItemColor: Color(0xFF00b3b0),
                        unselectedItemColor: Colors.grey,
                        onTap: _onItemTapped,
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 28,
                    bottom: 40,
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _isButtonVisible = !_isButtonVisible; // Toggle visibility
                        });
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Color(0xFF00b3b0),
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return Container(
      height: 30,
      width: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: Color(0xFF00b3b0), width: 1.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          backgroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 14,
            ), // Icon for "Penjualan"
            SizedBox(width: 8.0), // Spacing between icon and text
            Text(
              label, style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.black),
              // style: TextStyle(color: Colors.white, fontSize: 16.0), // Text styling
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyx(BuildContext context, DBSalesController controller) {
    switch (controller.activePage.value) {
      case 0:
        return PopScope(
            // ignore: deprecated_member_use
            onPopInvoked: (b) => showExitPopup(context),
            child: RefreshIndicator(
              onRefresh: () => controller.getData(true),
              child: SingleChildScrollView(
                child: controller.isLoading.value
                    ? SliverFillRemaining(
                        child: Center(
                            child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          showLoading3(),
                          // Obx(() => Text(dbc.prosesText.value)),
                        ],
                      )))
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 36),
                            child: Card(
                              elevation: 8,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 16.0, bottom: 8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Annual Sales Report', style: TextStyle(color: Color(0xFF00b3b0), fontSize: 18)),
                                      )),
                                  // avatar(),
                                  Obx(() => SizedBox(height: 250, child: controller.loadingTop10.value ? showloading() : _top10(controller))),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          child: Icon(
                                            Icons.receipt_long_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: 150, child: Text('Total Transaksi')),
                                        Text(formatangka((controller.ddashb.value.total).toString()), style: TextStyle(color: Color(0xFF00b3b0), fontSize: 24, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    height: 70,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => Get.toNamed('/penjualan'),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                                Text(
                                                  'Penjualan',
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                  child: Text(formatangka((controller.ddashb.value.total).toString()), style: TextStyle(color: Color(0xFF00b3b0), fontSize: 14, fontWeight: FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(endIndent: 20),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => Get.toNamed('/pelunasan/piutang'),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Total',
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                                Text(
                                                  'Pelunasan',
                                                  style: Theme.of(context).textTheme.bodySmall,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                  child: Text(formatangka(controller.ddashb.value.pelunasan.toString()), style: TextStyle(color: Color(0xFF00b3b0), fontSize: 14, fontWeight: FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(endIndent: 20),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Total',
                                                style: Theme.of(context).textTheme.bodySmall,
                                              ),
                                              Text(
                                                'Tagihan',
                                                style: Theme.of(context).textTheme.bodySmall,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: Text(formatangka(controller.ddashb.value.piutang.toString()), style: TextStyle(color: Color(0xFF00b3b0), fontSize: 14, fontWeight: FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ));

      case 1:
        return PriceListPage();
      case 3:
        return PageKontak(
            // judul: Text('Daftar Pelanggan')
            );
      case 4:
        return Center(child: Text('Halaman Produk'));
      case 5:
        return Center(child: Text('Halaman Akun'));
      default:
        return Center(child: Text('Halaman Tidak Ditemukan'));
    }
  }

  // _getBarang(int id) async {}
  // _body(BuildContext context, DBSalesController controller) {
  //   return PopScope(
  //       // ignore: deprecated_member_use
  //       onPopInvoked: (b) => showExitPopup(context),
  //       child: RefreshIndicator(
  //         onRefresh: () => controller.getData(true),
  //         child: SingleChildScrollView(
  //           child: controller.isLoading.value
  //               ? SliverFillRemaining(
  //                   child: Center(
  //                       child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     showLoading3(),
  //                     // Obx(() => Text(dbc.prosesText.value)),
  //                   ],
  //                 )))
  //               : Column(
  //                   children: <Widget>[
  //                     // avatar(),
  //                     Obx(() => SizedBox(height: 200, child: /* controller.loadingTop10.value ? showloading() :  */ _top10(controller))),

  //                     _btnTransaksi(controller),

  //                     SizedBox(height: 135, child: _menuGrid(controller)),
  //                     const SizedBox(height: 10),
  //                     const Padding(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: Align(alignment: Alignment.centerLeft, child: Text('Barang Baru Datang', style: tstebal)),
  //                     ),

  //                     /* Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 8),
  //                       child: SizedBox(
  //                         height: 300,
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Obx(
  //                             () => controller.loadingBarangBaru.value
  //                                 ? LoadingList(child: loadingBarangBaruDatang(Get.width - mg))
  //                                 : ListView.builder(
  //                                     itemCount: controller.listBarangDatang.length,
  //                                     itemBuilder: (context, i) {
  //                                       if (controller.listBarangDatang[i].id != null && controller.listBarangDatang[i].kode == 'null') Barang.get(data: {'id': controller.listBarangDatang[i].id.toString()});

  //                                       return Card(
  //                                         child: Row(
  //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             SizedBox(width: (Get.width - mg) * .14, child: MyAutoSizeText(controller.listBarangDatang[i].kode.toString())),
  //                                             SizedBox(width: (Get.width - mg) * .5, child: MyAutoSizeText(controller.listBarangDatang[i].nama.toString())),
  //                                             SizedBox(width: (Get.width - mg) * .1, child: Align(alignment: Alignment.centerRight, child: MyAutoSizeText(controller.listBarangDatang[i].merk.toString()))),
  //                                             SizedBox(width: (Get.width - mg) * .08, child: Align(alignment: Alignment.centerRight, child: MyAutoSizeText(formatangka(controller.listBarangDatang[i].qty.toString())))),
  //                                             SizedBox(width: (Get.width - mg) * .08, child: MyAutoSizeText(controller.listBarangDatang[i].satuan.toString())),
  //                                           ],
  //                                         ),
  //                                       );
  //                                     },
  //                                   ),
  //                           ),
  //                         ),
  //                       ),
  //                     ), */
  //                     /*  _listWidget("Penjualan", formatangka(dashb.total.toString())),
  //                     Container(height: 100, color: Colors.red[100]),
  //                     Container(height: 200, color: Colors.yellow[100]),
  //                     const Text('Footer'), */
  //                   ],
  //                 ),
  //         ),
  //       ));
  // }
}

avatar() => SizedBox(
    width: Get.width,
    height: 240,
    child: Container(
        color: Colors.deepOrange,
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(15), child: buildUserHeader()),
            Container(height: 40, color: Colors.amber, child: Center(child: Text(getUserName()))),
          ],
        )));

class InnerCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double centerX = size.width / 2;
    double fabRadius = 16; // Adjust this based on the button size and gap

    // Start from left side
    path.moveTo(0, 0);
    // Draw a line up to the left side of the FAB
    path.lineTo(centerX - fabRadius - 20, 0);
    // Draw an arc around the FAB
    path.arcToPoint(
      Offset(centerX + fabRadius + 20, 0),
      radius: Radius.circular(fabRadius + 20),
      clockwise: false,
    );
    // Continue the line on the right
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
