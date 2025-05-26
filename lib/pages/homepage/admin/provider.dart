import 'package:flutter/cupertino.dart';

class JmlNotif {
  String kode;
  int jml;
  JmlNotif(this.kode, this.jml);
}

class ApplicationProvider with ChangeNotifier {
  List<JmlNotif> _notifPermintaan = <JmlNotif>[];

  List<JmlNotif> get notifpermintaan => _notifPermintaan;
  set notifpermintaan(List<JmlNotif> value) {
    _notifPermintaan = value;
    notifyListeners();
  }
}
