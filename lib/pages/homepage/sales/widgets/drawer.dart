part of '../page.dart';

Drawer drawer(BuildContext context, void Function(int) onTap) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        buildUserHeader(),
        menuDrawer('Dashboard', context, icon: Icons.dashboard, onTap: () => onTap(2)),
        ExpansionTile(iconColor: mainColor, title: Text("Keuangan", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF00b3b0))), children: <Widget>[
          menuDrawer('Klasifikasi', context, icon: Icons.dashboard, onTap: () => onTap(100)),
          menuDrawer('Subklasifikasi', context, icon: Icons.shopping_cart, onTap: () => onTap(101)),
          menuDrawer('Rekening Akutansi', context, icon: Icons.add_road, onTap: () => onTap(102)),
        ]),
        ExpansionTile(iconColor: mainColor, title: Text("Daftar Barang", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF00b3b0))), children: <Widget>[
          menuDrawer('Pricelist', context, icon: Icons.dashboard, onTap: () => Get.toNamed('/barang')),
          menuDrawer('Stok', context, icon: Icons.shopping_cart, onTap: () => onTap(3)),
          menuDrawer('Mutasi', context, icon: Icons.add_road, onTap: () => onTap(15)),
        ]),
        ExpansionTile(iconColor: mainColor, title: Text("Pelanggan", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF00b3b0))), children: <Widget>[
          menuDrawer('Daftar Pelanggan', context, icon: Icons.people, onTap: () => onTap(4)),
          const Divider(),
          menuDrawer('Tagihan', context, icon: Icons.calculate_rounded, onTap: () => onTap(10)),
        ]),
        ExpansionTile(iconColor: mainColor, title: Text("Penjualan", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF00b3b0))), children: <Widget>[
          menuDrawer('Order', context, icon: Icons.shopping_cart, onTap: () => onTap(13)),
          menuDrawer('Pelunasan', context, icon: Icons.calculate, onTap: () => onTap(7)),
          menuDrawer('Riwayat Penjualan', context, icon: Icons.dashboard, onTap: () {
            onTap(0);
            // indexaktifcart = 0;
          }),
        ]),
        ExpansionTile(iconColor: mainColor, title: Text("Laporan", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF00b3b0))), children: <Widget>[
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
        if (kIsWeb)
          menuDrawer('Download Apk', context, icon: Icons.phone_android, onTap: () async {
            await downloadApk();
          }),
        if (!kIsWeb)
          if (!Platform.isAndroid)
            menuDrawer('Download Apk', context, icon: Icons.phone_android, onTap: () async {
              await downloadApk();
            }),
        menuDrawer('Pengaturan', context, icon: Icons.settings, onTap: () => onTap(8)),
        menuDrawer('Tentang kami', context, icon: Icons.info, onTap: () => onTap(9)),
        const Divider(),
        Text(koneksi),
        ListTile(leading: Icon(Icons.logout), title: Text('Keluar', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF00b3b0))), onTap: handleSignOut),
      ],
    ),
  );
}

Widget menuDrawer(String title, context, {IconData? icon, void Function()? onTap}) {
  return ListTile(
      leading: Icon(icon),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xFF00b3b0))),
      onTap: () {
        Get.back();
        onTap!();
      });
}

/* Widget userWidget() {
  return UserAccountsDrawerHeader(
    accountName: Row(children: [
      Text(getUserName(), style: const TextStyle(fontWeight: FontWeight.bold, backgroundColor: Colors.black)),
      (pegawai != null)
          ? Text(
              pegawai!.kode.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, backgroundColor: Colors.black),
            )
          : const Text('')
    ]),
    accountEmail: Text(getEmail(), style: const TextStyle(fontWeight: FontWeight.bold, backgroundColor: Colors.black)),
    decoration: const BoxDecoration(image: DecorationImage(image: ExactAssetImage('assets/images/background.jpg'), fit: BoxFit.cover)),
    currentAccountPicture: buildUserHeader(),
  );
}
 */