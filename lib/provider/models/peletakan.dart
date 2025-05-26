class PELETAKAN {
  String? id;
  int? idlokasi;
  String? kode;
  String? rak;

  PELETAKAN({this.id, this.idlokasi, this.kode, this.rak});

  PELETAKAN.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idlokasi = json['idlokasi'];
    kode = json['kode'];
    rak = json['rak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idlokasi'] = idlokasi;
    data['kode'] = kode;
    data['rak'] = rak;
    return data;
  }
}
