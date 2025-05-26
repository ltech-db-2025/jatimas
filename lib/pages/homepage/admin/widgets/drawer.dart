part of '../page.dart';

Drawer drawer(BuildContext context, void Function(int) onTap) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        buildUserHeader(),
        // menuDrawer('Dashboard', context, child: const Icon(Icons.dashboard), onTap: () => onTap(2)),
        ExpansionTile(title: const Text("Keuangan"), children: <Widget>[
          menuDrawer('Klasifikasi', context, child: const Icon(Icons.dashboard), onTap: () => onTap(100)),
          menuDrawer('Subklasifikasi', context, child: const Icon(Icons.shopping_cart), onTap: () => onTap(101)),
          menuDrawer('Rekening Akutansi', context, child: const Icon(Icons.add_road), onTap: () => onTap(102)),
        ]),
        ExpansionTile(title: const Text("Daftar Barang"), children: <Widget>[
          menuDrawer('Pricelist', context, child: const Icon(Icons.dashboard), onTap: () => onTap(3)),
          menuDrawer('Stok', context, child: const Icon(Icons.shopping_cart), onTap: () => onTap(3)),
          menuDrawer('Mutasi', context, child: const Icon(Icons.add_road), onTap: () => onTap(15)),
          menuDrawer('Kategori Barang', context, child: Image.asset('assets/manual.png', width: 24), onTap: () => Get.toNamed("/barang/kategori")),
          menuDrawer('Merk Barang', context, child: Image.asset('assets/manual.png', width: 24), onTap: () => Get.toNamed("/merkbarang")),
          menuDrawer('Kelompok Barang', context, child: Image.asset('assets/manual.png', width: 24), onTap: () => Get.toNamed("/kelompokbarang")),
          menuDrawer('Jenis Barang', context, child: Image.asset('assets/manual.png', width: 24), onTap: () => Get.toNamed("/barang/jenis")),
        ]),
        ExpansionTile(title: const Text("Pelanggan"), children: <Widget>[
          menuDrawer('Daftar Pelanggan', context, child: const Icon(Icons.people), onTap: () => onTap(4)),
          const Divider(),
          menuDrawer('Tagihan', context, child: const Icon(Icons.calculate_rounded), onTap: () => onTap(10)),
        ]),
        ExpansionTile(title: const Text("Penjualan"), children: <Widget>[
          menuDrawer('Riwayat Penjualan', context, child: const Icon(Icons.shopping_cart), onTap: () => Get.toNamed("/penjualan")),
          menuDrawer('Pelunasan', context, child: const Icon(Icons.calculate), onTap: () => onTap(7)),
          menuDrawer('Riwayat Penjualan', context, child: const Icon(Icons.dashboard), onTap: () {
            onTap(0);
            // indexaktifcart = 0;
          }),
        ]),
        ExpansionTile(title: const Text("Laporan"), children: <Widget>[
          menuDrawer('Riwayat Penjualan', context, child: const Icon(Icons.dashboard), onTap: () => Get.toNamed("/penjualan")),
          menuDrawer('Riwayat Mutasi', context, child: const Icon(Icons.add_road), onTap: () => onTap(14)),
          menuDrawer('Piutang Jatuh Tempo', context, child: const Icon(Icons.shopping_cart), onTap: () => onTap(0)),
          menuDrawer('Omset bulan ini', context, child: const Icon(Icons.dashboard), onTap: () {
            onTap(0);
            //indexaktifcart = 2;
          }),
          menuDrawer('Pelunasan', context, child: const Icon(Icons.calculate), onTap: () => onTap(0)),
        ]),
        const Divider(),
        menuDrawer('Pengaturan', context, child: const Icon(Icons.settings), onTap: () => onTap(8)),
        menuDrawer('Tentang kami', context, child: const Icon(Icons.info), onTap: () => onTap(9)),
        const Divider(),
        Text(koneksi),
        ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Keluar'),
            onTap: () async {
              Get.back();
              dp('se');
              await handleSignOut();
            })
      ],
    ),
  );
}

Widget menuDrawer(String title, context, {Widget? child, void Function()? onTap}) {
  return ListTile(
      leading: child,
      title: Text(title),
      onTap: () {
        Get.back();
        onTap!();
        //Navigator.pop(context);

        // scaffoldHome.currentState!.closeDrawer();
      });
}
