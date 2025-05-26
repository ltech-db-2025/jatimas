import 'dart:convert';

import 'package:ljm/tools/env.dart';
import 'dart:async';

class Jurnal {
  double? kd;
  String? a;
  String? nt;
  String? kt;
  String? tg;
  String? u;
  double? sa;
  double? k;
  double? d;
  double? s;
  Jurnal({this.kd, this.a, this.nt, this.kt, this.tg, this.u, this.sa, this.k, this.d, this.s});

  factory Jurnal.fromMap(Map<String, dynamic> json) => Jurnal(
        kd: double.tryParse(json["kd"].toString()),
        a: json["a"],
        nt: json["nt"],
        kt: json["kt"],
        tg: json["tg"],
        u: json["u"],
        sa: double.tryParse(json["sa"].toString()) ?? 0,
        k: double.tryParse(json["k"].toString()) ?? 0,
        d: double.tryParse(json["d"].toString()) ?? 0,
        s: double.tryParse(json["s"].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {"kd": kd, "a": a, "nt": nt, "kt": kt, "tg": tg, "u": u, "sa": sa, "k": k, "d": d, "s": s};
  factory Jurnal.fromJson(String data) {
    return Jurnal.fromMap(jsonDecode(data) as Map<String, dynamic>);
  }
}

class SaldoKas {
  double? kd;
  String? a;
  double? s;
  SaldoKas({this.kd, this.a, this.s});

  factory SaldoKas.fromMap(Map<String, dynamic> json) => SaldoKas(kd: double.tryParse(json["kd"].toString()) ?? 0, a: json['a'], s: double.tryParse(json["s"].toString()) ?? 0);

  Map<String, dynamic> toJson() => {"kd": kd, "a": a, "s": s};

  factory SaldoKas.fromJson(String data) {
    return SaldoKas.fromMap(jsonDecode(data) as Map<String, dynamic>);
  }
}

class VSaldoKas {
  double? kd;
  int? k;
  String? klasifikasi;
  double? sk;
  String? subklasifikasi;
  String? a;
  double? s;
  VSaldoKas({this.kd, this.k, this.klasifikasi, this.sk, this.subklasifikasi, this.a, this.s});

  factory VSaldoKas.fromJson(Map<String, dynamic> json) => VSaldoKas(kd: double.tryParse(json["kd"].toString()) ?? 0, k: int.tryParse(json["k"].toString()) ?? 0, klasifikasi: json["klasifikasi"], sk: double.tryParse(json["sk"].toString()) ?? 0, subklasifikasi: json["subklasifikasi"], a: json["a"], s: double.tryParse(json["s"].toString()) ?? 0);

  Map<String, dynamic> toJson() => {"kd": kd, "k": k, "klasifikasi": klasifikasi, "sk": sk, "subklasifikasi": subklasifikasi, "a": a, "s": s};
}

Future<List<SaldoKas>> getSaldoKas() async {
  prosestxt = "Download Saldo Kas";
  setProses(prosestxt);
  var url = "$urlHome2/saldokas/";
  Map<String, dynamic> xdata = {"id": iddevisi.toString()};
  var response = await getResponse(url, xdata);

  if (response == null) return <SaldoKas>[];
  return (response.body as List).map((x) => SaldoKas.fromMap(x)).toList();
}

Future<List<Jurnal>> getBukubesar(double id) async {
  try {
    prosestxt = "Download Rinciaan Bukubesar";
    setProses(prosestxt);
    var url = "$urlBase/laporan/bukubesar/";
    Map<String, dynamic> xdata = {"id": id.toString()};
    var response = await getResponse(url, xdata);
    if (response == null) return <Jurnal>[];
    return (response.body as List).map((x) => Jurnal.fromMap(x)).toList();
  } catch (c) {
    doError("Gagal Download ");
    dp("getBukubesar \n$c");
    return <Jurnal>[];
  }
}
