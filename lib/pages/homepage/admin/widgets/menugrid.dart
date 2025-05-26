part of '../page.dart';

_menuGrid(DBAdminController controller) {
  var choise = choices.where((element) => element.aktif == true).toList();
  return GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 5,
      children: List.generate(choise.length, (index) {
        return Center(
          child: InkWell(onTap: choise[index].onTap, child: ChoiceCard(choice: choise[index], index: index)),
        );
      }));
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({super.key, required this.choice, this.index});
  final int? index;
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(skala)),
        child: Card(
            color: Colors.white,
            child: Center(
              child: badges.Badge(
                  showBadge: choice.bedge,
                  position: badges.BadgePosition.topEnd(top: 0, end: 3),
                  badgeAnimation: const badges.BadgeAnimation.slide(
                    animationDuration: Duration(milliseconds: 300),
                  ),
                  badgeContent: Text(choice.notif.toString(), style: const TextStyle(color: Colors.white, fontSize: 12)),
                  child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Expanded(child: Container(width: 48, height: 48, color: choice.aktif ? Colors.transparent : Colors.grey, child: choice.icon)),
                    AutoSizeText(choice.title, wrapWords: false, maxLines: 1, minFontSize: 8, style: TextStyle(color: choice.aktif ? Colors.black : Colors.grey)),
                  ])),
            )));
  }
}

class Choice {
  Choice({this.title = '', this.icon, this.aktif = false, this.bedge = false, this.notif = 0, this.onTap});
  final String title;
  final Widget? icon;
  final Function()? onTap;
  bool aktif;
  bool bedge;
  int notif;
}

List<Choice> choices = [
  Choice(title: 'Barang', icon: Image.asset('assets/icons/barang.png'), aktif: true, onTap: () => Get.toNamed("/barang")),
  Choice(title: 'Pelanggan', icon: Image.asset('assets/icons/customer.png'), aktif: true, onTap: () => Get.toNamed("/kontak")),
  Choice(title: 'Lokasi', icon: Image.asset('assets/icons/warehouse.png'), aktif: true, onTap: () => Get.toNamed("/lokasi")),
  Choice(title: 'Mutasi', icon: Image.asset('assets/icons/mutasi.png'), aktif: true, bedge: true, onTap: () => Get.toNamed("/permintaanmutasi")),
  Choice(title: 'Notifikasi', icon: Image.asset('assets/manual.png'), aktif: true, onTap: () => Get.toNamed("/permintaanmutasi")),
  Choice(title: 'Kategori Barang', icon: Image.asset('assets/manual.png'), aktif: true, onTap: () => Get.toNamed("/barang/kategori")),
  Choice(title: 'Merk Barang', icon: Image.asset('assets/manual.png'), aktif: true, onTap: () => Get.toNamed("/merkbarang")),
  Choice(title: 'Kelompok Barang', icon: Image.asset('assets/manual.png'), aktif: true, onTap: () => Get.toNamed("/kelompokbarang")),
  Choice(title: 'Jenis Barang', icon: Image.asset('assets/manual.png'), aktif: true, onTap: () => Get.toNamed("/jenisbarang")),
  Choice(title: 'Akuntansi', icon: Image.asset('assets/icons/account.jpg'), aktif: true, onTap: () => Get.toNamed("/klasifikasi")),
  Choice(title: 'Bicycle', icon: const Icon(Icons.drafts)),
  Choice(title: 'Boat', icon: const Icon(Icons.dvr)),
  Choice(title: 'Bus', icon: const Icon(Icons.copyright)),
  Choice(title: 'Train', icon: const Icon(Icons.cloud_off)),
  Choice(title: 'Car', icon: const Icon(Icons.directions_car)),
  Choice(title: 'Bicycle', icon: const Icon(Icons.directions_bike)),
  Choice(title: 'Boat', icon: const Icon(Icons.directions_boat)),
  Choice(title: 'Bus', icon: const Icon(Icons.directions_bus)),
  Choice(title: 'Train', icon: const Icon(Icons.directions_railway)),
  Choice(title: 'Walk', icon: Image.asset('assets/manual.png')),
  Choice(title: 'Car', icon: const Icon(Icons.directions_car)),
  Choice(title: 'Bicycle', icon: const Icon(Icons.drafts)),
  Choice(title: 'Boat', icon: const Icon(Icons.dvr)),
  Choice(title: 'Bus', icon: const Icon(Icons.copyright)),
  Choice(title: 'Train', icon: const Icon(Icons.cloud_off)),
  Choice(title: 'Car', icon: const Icon(Icons.directions_car)),
  Choice(title: 'Bicycle', icon: const Icon(Icons.directions_bike)),
  Choice(title: 'Boat', icon: const Icon(Icons.directions_boat)),
  Choice(title: 'Bus', icon: const Icon(Icons.directions_bus)),
  Choice(title: 'Train', icon: const Icon(Icons.directions_railway)),
  Choice(title: 'Walk', icon: Image.asset('assets/manual.png')),
  Choice(title: 'Car', icon: const Icon(Icons.directions_car)),
  Choice(title: 'Bicycle', icon: const Icon(Icons.drafts)),
  Choice(title: 'Boat', icon: const Icon(Icons.dvr)),
  Choice(title: 'Bus', icon: const Icon(Icons.copyright)),
  Choice(title: 'Train', icon: const Icon(Icons.cloud_off)),
];
