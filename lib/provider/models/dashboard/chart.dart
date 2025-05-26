import 'omset.dart';
const nulomset = <Omset>[];
class Chart  {
  late List<Omset> omset;
  late List<Omset> pelunasan;
  late List<Omset> tempo;

  Chart({this.omset = nulomset, this.pelunasan = nulomset, this.tempo = nulomset});
  /*  static Future<Chart> getData(String url) async {
    var response = await getResponse(url);
    if (response != null) {
      return Chart.fromJson(response.body);
    } else {
      return Chart();
    }
  } */

  Chart.fromJson(Map<String, dynamic> json) {
    if (json['omset'] != null) {
      omset = <Omset>[];
      json['omset'].forEach((v) {
        omset.add(Omset.fromJson(v));
      });
    }

    if (json['pelunasan'] != null) {
      pelunasan = <Omset>[];
      json['pelunasan'].forEach((v) {
        pelunasan.add(Omset.fromJson(v));
      });
    }
    if (json['tempo'] != null) {
      tempo = <Omset>[];
      json['tempo'].forEach((v) {
        tempo.add(Omset.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic>? data;
    data!['omset'] = omset.map((v) => v.toJson()).toList();
    data['pelunasan'] = pelunasan.map((v) => v.toJson()).toList();
    data['tempo'] = tempo.map((v) => v.toJson()).toList();
    return data;
  }

  Chart clone() => Chart(
        omset: omset.map((e) => e.clone()).toList(),
        pelunasan: pelunasan.map((e) => e.clone()).toList(),
        tempo: tempo.map((e) => e.clone()).toList(),
      );
  Chart copyWith({
    List<Omset>? omset,
    List<Omset>? pelunasan,
    List<Omset>? tempo,
  }) =>
      Chart(
        omset: omset ?? this.pelunasan,
        pelunasan: pelunasan ?? this.pelunasan,
        tempo: tempo ?? this.tempo,
      );
}