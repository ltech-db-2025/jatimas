import 'package:get/get.dart';

import 'bukubesar.dart';
import 'package:ljm/provider/models/keuangan/keuangan.dart';
import 'package:ljm/tools/env.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SaldoKasPage extends StatefulWidget {
  const SaldoKasPage({super.key});

  @override
  State<SaldoKasPage> createState() => _SaldoKasPageState();
}

class Debouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;
  Debouncer({this.milliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(microseconds: milliseconds!), action);
  }
}

class _SaldoKasPageState extends State<SaldoKasPage> {
/*   Future<List<Kontak>> kontaks;
  _SaldoKasPageState(this.kontaks); */
  List<SaldoKas>? saldokas;
  final debouncer = Debouncer(milliseconds: 5000);
  var isLoading = true;
  var isSearching = false;
  String dicari = '';

  @override
  void initState() {
    _loadFromApi();
    super.initState();
  }

  Widget appBarTitle = const Text("Saldo", style: TextStyle(color: Colors.white));
  Icon actionIcon = const Icon(Icons.search, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              setState(() {
                dicari = value;
              });
            },
            decoration: const InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.search), hintText: 'Cari Kas ', filled: true, fillColor: Colors.orangeAccent),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings_input_antenna),
              onPressed: () async {
                await _loadFromApi();
              },
            ),
            Container(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(icon: const Icon(Icons.delete), onPressed: () => {}),
            ),
          ],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: saldokas!.length,
                itemBuilder: (context, index) => detailBody(context, index),
              ));
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    // wait for 2 seconds to simulate loading of data
    saldokas = await getSaldoKas();

    setState(() {
      isLoading = false;
    });
  }

  Widget detailBody(BuildContext context, int index, {List<SaldoKas>? lt}) {
    var model = (lt == null) ? saldokas![index] : lt[index];
    if (index == 0) {
      return Column(
        children: <Widget>[
          const ListTile(
            tileColor: Colors.deepOrange,
            dense: true,
            contentPadding: EdgeInsets.only(top: 0, bottom: -5, left: 10, right: 10),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Text("KODE", style: tstebalPutih),
            title: Text(" REKENING AKUN", style: tstebalPutih),
            trailing: Text("SALDO", style: tstebalPutih),
          ),
          ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(top: 0, bottom: -5, left: 10, right: 10),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            leading: Text(model.kd.toString()),
            title: Text(model.a.toString()),
            trailing: Text(formatangka(model.s)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BukubesarPage(model.kd!, judul: model.a),
                ),
              );
            },
          ),
        ],
      );
    } else {
      return ListTile(
        tileColor: (index % 2 == 0) ? Colors.white : Colors.greenAccent[100],
        dense: true,
        contentPadding: const EdgeInsets.only(top: 0, bottom: -5, left: 10, right: 10),
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        leading: Text(model.kd.toString()),
        title: Text(model.a.toString()),
        trailing: Text(formatangka(model.s)),
        onTap: () {
          dp("kode: ${model.kd ?? 0}");
          Get.to(() => BukubesarPage(
                model.kd ?? 0,
                judul: model.a ?? '',
              ));
        },
      );
    }
  }
}
