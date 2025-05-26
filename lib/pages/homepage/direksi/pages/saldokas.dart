// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ljm/env/env.dart';
import 'package:ljm/pages/homepage/admin/widgets/bukubesar.dart';
import 'package:ljm/tools/env.dart';

import 'model.dart';
import 'wigets.dart';

class SaldoKasGlobalPage extends StatefulWidget {
  const SaldoKasGlobalPage({super.key});

  @override
  State<SaldoKasGlobalPage> createState() => _SaldoKasGlobalPageState();
}

class _SaldoKasGlobalPageState extends State<SaldoKasGlobalPage> {
  late List<FinancialData> financialDataList;
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    await fetchData();
  }

  Future<void> fetchData() async {
    var url = Env.URLKEUANGAN;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      financialDataList = List<FinancialData>.from(data.map((item) => FinancialData.fromJson(item)));
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(skala)),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Saldo Kas Lucky Jaya Group'),
            ),
            body: const Scaffold(body: LoadingList())),
      );
    }

    Map<String, List<FinancialData>> groupedData = groupDataByDivisi(financialDataList);

    List<Widget> listItems = [];

    // Add data items and subtotal items to the list
    groupedData.forEach((divisi, dataList) {
      listItems.add(SubtotalItem(divisi: divisi, subtotal: calculateSubtotal(dataList)));
      //listItems.add(HeaderItem(key: UniqueKey(), divisi: divisi));
      listItems.addAll(dataList.map((data) => ListTile(
            onTap: () {
              if (data.iddivisi == 1) Get.to(() => BukubesarPage(data.rek, judul: data.perkiraan));
            },
            dense: true,
            leading: Text(data.rek.toString()),
            title: Text(data.perkiraan),
            trailing: Text(formatangka(data.saldo.toString())),
          )));
    });

    // Add grand total item to the list
    listItems.add(const Divider());
    listItems.add(GrandTotalItem(grandTotal: calculateGrandTotal(financialDataList)));

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(skala)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Saldo Kas Lucky Jaya Group'),
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: ListView(children: listItems),
        ),
      ),
    );
  }
}
