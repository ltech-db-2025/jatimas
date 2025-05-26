import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/main.dart';
import 'package:ljm/tools/env.dart';

Drawer drawer(BuildContext context, void Function(int) onTap) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        buildUserHeader(),
        menuDrawer('Dashboard', context, icon: Icons.dashboard, onTap: () => onTap(2)),
        ExpansionTile(title: const Text("Keuangan"), children: <Widget>[
          menuDrawer('Klasifikasi', context, icon: Icons.dashboard, onTap: () => onTap(100)),
          menuDrawer('Subklasifikasi', context, icon: Icons.shopping_cart, onTap: () => onTap(101)),
          menuDrawer('Rekening Akutansi', context, icon: Icons.add_road, onTap: () => onTap(102)),
        ]),
        ExpansionTile(title: const Text("Daftar Barang"), children: <Widget>[
          menuDrawer('Pricelist', context, icon: Icons.dashboard, onTap: () => onTap(3)),
          menuDrawer('Stok', context, icon: Icons.shopping_cart, onTap: () => onTap(3)),
          menuDrawer('Mutasi', context, icon: Icons.add_road, onTap: () => onTap(15)),
        ]),
        ExpansionTile(title: const Text("Pelanggan"), children: <Widget>[
          menuDrawer('Daftar Pelanggan', context, icon: Icons.people, onTap: () => onTap(4)),
          const Divider(),
          menuDrawer('Tagihan', context, icon: Icons.calculate_rounded, onTap: () => onTap(10)),
        ]),
        ExpansionTile(title: const Text("Penjualan"), children: <Widget>[
          menuDrawer('Order', context, icon: Icons.shopping_cart, onTap: () => onTap(13)),
          menuDrawer('Pelunasan', context, icon: Icons.calculate, onTap: () => onTap(7)),
          menuDrawer('Riwayat Penjualan', context, icon: Icons.dashboard, onTap: () {
            onTap(0);
            // indexaktifcart = 0;
          }),
        ]),
        ExpansionTile(title: const Text("Laporan"), children: <Widget>[
          menuDrawer('Riwayat Penjualan', context, icon: Icons.dashboard, onTap: () => onTap(0)),
          menuDrawer('Riwayat Mutasi', context, icon: Icons.add_road, onTap: () => onTap(14)),
          menuDrawer('Piutang Jatuh Tempo', context, icon: Icons.shopping_cart, onTap: () => onTap(0)),
          menuDrawer('Omset bulan ini', context, icon: Icons.dashboard, onTap: () {
            onTap(0);
            //indexaktifcart = 2;
          }),
          menuDrawer('Pelunasan', context, icon: Icons.calculate, onTap: () => onTap(0)),
        ]),
        const Divider(),
        menuDrawer('Pengaturan', context, icon: Icons.settings, onTap: () => onTap(8)),
        menuDrawer('Tentang kami', context, icon: Icons.info, onTap: () => onTap(9)),
        const Divider(),
        Text(koneksi),
        const ListTile(leading: Icon(Icons.logout), title: Text('Keluar'), onTap: handleLogout)
      ],
    ),
  );
}

Widget menuDrawer(String title, context, {IconData? icon, void Function()? onTap}) {
  return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Get.back();
        onTap!();
        //Navigator.pop(context);

        // scaffoldHome.currentState!.closeDrawer();
      });
}
