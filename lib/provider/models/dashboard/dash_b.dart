import 'dart:convert';

import 'package:collection/collection.dart';

class DashB {
	int? idsales;
	int? tahun;
	int? bulan;
	int? total;
	int? retur;
	int? pelunasan;
	int? pn;
	int? piutang;
	int? top;
	double? poin;
	int? poinbln;
	int? permintaan;
	double? kas;
	double? kasglobal;

	DashB({
		this.idsales, 
		this.tahun, 
		this.bulan, 
		this.total, 
		this.retur, 
		this.pelunasan, 
		this.pn, 
		this.piutang, 
		this.top, 
		this.poin, 
		this.poinbln, 
		this.permintaan, 
		this.kas, 
		this.kasglobal, 
	});

	@override
	String toString() {
		return 'DashB(idsales: $idsales, tahun: $tahun, bulan: $bulan, total: $total, retur: $retur, pelunasan: $pelunasan, pn: $pn, piutang: $piutang, top: $top, poin: $poin, poinbln: $poinbln, permintaan: $permintaan, kas: $kas, kasglobal: $kasglobal)';
	}

	factory DashB.fromMap(Map<String, dynamic> data) => DashB(
				idsales: data['idsales'] as int?,
				tahun: data['tahun'] as int?,
				bulan: data['bulan'] as int?,
				total: data['total'] as int?,
				retur: data['retur'] as int?,
				pelunasan: data['pelunasan'] as int?,
				pn: data['pn'] as int?,
				piutang: data['piutang'] as int?,
				top: data['top'] as int?,
				poin: (data['poin'] as num?)?.toDouble(),
				poinbln: data['poinbln'] as int?,
				permintaan: data['permintaan'] as int?,
				kas: (data['kas'] as num?)?.toDouble(),
				kasglobal: (data['kasglobal'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toMap() => {
				'idsales': idsales,
				'tahun': tahun,
				'bulan': bulan,
				'total': total,
				'retur': retur,
				'pelunasan': pelunasan,
				'pn': pn,
				'piutang': piutang,
				'top': top,
				'poin': poin,
				'poinbln': poinbln,
				'permintaan': permintaan,
				'kas': kas,
				'kasglobal': kasglobal,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DashB].
	factory DashB.fromJson(String data) {
		return DashB.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [DashB] to a JSON string.
	String toJson() => json.encode(toMap());

	DashB copyWith({
		int? idsales,
		int? tahun,
		int? bulan,
		int? total,
		int? retur,
		int? pelunasan,
		int? pn,
		int? piutang,
		int? top,
		double? poin,
		int? poinbln,
		int? permintaan,
		double? kas,
		double? kasglobal,
	}) {
		return DashB(
			idsales: idsales ?? this.idsales,
			tahun: tahun ?? this.tahun,
			bulan: bulan ?? this.bulan,
			total: total ?? this.total,
			retur: retur ?? this.retur,
			pelunasan: pelunasan ?? this.pelunasan,
			pn: pn ?? this.pn,
			piutang: piutang ?? this.piutang,
			top: top ?? this.top,
			poin: poin ?? this.poin,
			poinbln: poinbln ?? this.poinbln,
			permintaan: permintaan ?? this.permintaan,
			kas: kas ?? this.kas,
			kasglobal: kasglobal ?? this.kasglobal,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! DashB) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			idsales.hashCode ^
			tahun.hashCode ^
			bulan.hashCode ^
			total.hashCode ^
			retur.hashCode ^
			pelunasan.hashCode ^
			pn.hashCode ^
			piutang.hashCode ^
			top.hashCode ^
			poin.hashCode ^
			poinbln.hashCode ^
			permintaan.hashCode ^
			kas.hashCode ^
			kasglobal.hashCode;
}
