part of 'page.dart';

class Choice {
  Choice({this.title = '', this.icon, this.aktif = false, this.bedge = false, this.notif = 0});
  final String title;
  final Widget? icon;
  bool aktif;
  bool bedge;
  int notif;
}
/* 
List<Choice> choices = [
  Choice(title: 'Pricelist', icon: Icons.book, aktif: true),
  Choice(title: 'Pelanggan', icon: Icons.contacts, aktif: true),
  Choice(title: 'Lokasi', icon: Icons.directions_car, aktif: true),
  Choice(title: 'Mutasi', icon: Icons.directions_boat, aktif: true, bedge: true, notif: listNotifikasi.length),
  Obx(()=>Choice(title: 'Notifikasi', icon: Icons.notifications, aktif: true, notif: _nf.jmlnotif)),
  Choice(title: 'Train', icon: Icons.directions_railway),
  Choice(title: 'Walk', icon: Icons.directions_walk),
  Choice(title: 'Bicycle', icon: Icons.drafts),
  Choice(title: 'Boat', icon: Icons.dvr),
  Choice(title: 'Bus', icon: Icons.copyright),
  Choice(title: 'Train', icon: Icons.cloud_off),
  Choice(title: 'Car', icon: Icons.menu),
];
 */