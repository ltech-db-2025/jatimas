import 'dart:convert';

class Rak {
  final String? id;
  final int? idlokasi;
  final String? kode;
  final String? updated;

  const Rak({this.id, this.idlokasi, this.kode, this.updated});

  @override
  String toString() {
    return 'Rak(id: $id, idlokasi: $idlokasi, kode: $kode, updated: $updated)';
  }

  factory Rak.fromMap(Map<String, dynamic> data) => Rak(
        id: data['id'] as String?,
        idlokasi: data['idlokasi'] as int?,
        kode: data['kode'] as String?,
        updated: data['updated'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'idlokasi': idlokasi,
        'kode': kode,
        'updated': updated,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rak].
  factory Rak.fromJson(String data) {
    return Rak.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rak] to a JSON string.
  String toJson() => json.encode(toMap());

  Rak copyWith({
    String? id,
    int? idlokasi,
    String? kode,
    String? updated,
  }) {
    return Rak(
      id: id ?? this.id,
      idlokasi: idlokasi ?? this.idlokasi,
      kode: kode ?? this.kode,
      updated: updated ?? this.updated,
    );
  }
}
