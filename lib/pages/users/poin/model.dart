import 'dart:convert';

import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/tools/env.dart';

class Poin {
  String notrans;
  String tanggal;
  int? idkontak;
  String keterangan;
  double nilai;
  double poin;
  double poinbln;
  KONTAK? kontak;
  Poin({this.notrans = "", this.tanggal = "", this.idkontak, this.keterangan = "", this.nilai = 0, this.poin = 0, this.poinbln = 0, this.kontak});

  Poin fromJson(Map<String, dynamic> json) => _fromJson(json);

  static Future<List<Poin>> fetchData(int id) async {
    setProses('download data Poin...');

    var response = await getResponse("https://luckyjayagroup.com/ljmbaru/laporan/poin/", {"idkontak": id.toString()});
    if (response.statusCode == 200) {
      List jsonResponse = (response.body.runtimeType == String) ? jsonDecode(response.body) : response.body;
      return jsonResponse.map((data) => _fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}

Poin _fromJson(Map<String, dynamic> json) {
  return Poin(
    notrans: json["notrans"].toString(),
    tanggal: json["tanggal"].toString(),
    idkontak: int.tryParse(json["idkontak"].toString()) ?? 0,
    keterangan: json["keterangan"].toString(),
    nilai: double.tryParse(json["nilai"].toString()) ?? 0,
    poin: double.tryParse(json["poin"].toString()) ?? 0,
    poinbln: double.tryParse(json["poinbln"].toString()) ?? 0,
    // kontak: dbc.mKONTAK.firstWhere((element) => element.id == (int.tryParse(json["idkontak"].toString()) ?? 0), orElse: () => KONTAK(nama: 'N/N')),
  );
}
