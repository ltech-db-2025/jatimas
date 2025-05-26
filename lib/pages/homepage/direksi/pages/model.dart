class FinancialData {
  final int iddivisi;
  final String divisi;
  final double rek;
  final String perkiraan;
  final double saldo;

  FinancialData({
    this.iddivisi = 0,
    required this.divisi,
    this.rek = 0,
    required this.perkiraan,
    required this.saldo,
  });

  factory FinancialData.fromJson(Map<String, dynamic> json) {
    return FinancialData(
      iddivisi: int.tryParse(json['iddivisi'].toString()) ?? 0,
      divisi: json['divisi'],
      rek: double.tryParse(json['rek'].toString()) ?? 0,
      perkiraan: json['perkiraan'],
      saldo: double.tryParse(json['saldo'].toString()) ?? 0,
    );
  }
}

Map<String, List<FinancialData>> groupDataByDivisi(List<FinancialData> dataList) {
  Map<String, List<FinancialData>> groupedData = {};

  for (var data in dataList) {
    if (!groupedData.containsKey(data.divisi)) {
      groupedData[data.divisi] = [];
    }
    groupedData[data.divisi]!.add(data);
  }

  return groupedData;
}

String calculateSubtotal(List<FinancialData> dataList) {
  double total = 0;

  for (var data in dataList) {
    total += data.saldo;
  }

  return total.toStringAsFixed(2);
}

String calculateGrandTotal(List<FinancialData> financialDataList) {
  double total = 0;

  for (var data in financialDataList) {
    total += data.saldo;
  }

  return total.toStringAsFixed(2);
}
