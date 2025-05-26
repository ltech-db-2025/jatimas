
import 'package:ljm/provider/models/keuangan/keuangan.dart';
import 'package:ljm/tools/env.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class BukubesarPage extends StatefulWidget {
  final double id;
  final String? judul;
  const BukubesarPage(this.id, {super.key, this.judul});

  @override
  State<BukubesarPage> createState() => _BukubesarPageState();
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

class _BukubesarPageState extends State<BukubesarPage> {
/*   Future<List<Kontak>> kontaks;
  _BukubesarPageState(this.kontaks); */
  List<Jurnal>? jurnal;
  final debouncer = Debouncer(milliseconds: 5000);
  var isLoading = true;
  var isSearching = false;

  @override
  void initState() {
    _loadFromApi();
    super.initState();
  }

  Widget appBarTitle = const Text(
    "Saldo",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );

  Future<void> _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    // wait for 2 seconds to simulate loading of data
    jurnal = await getBukubesar(widget.id);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.judul!),
        bottom: buildTableHeader(context, orientation),
        elevation: 0,
      ),
      body: //_isLoading ? showloading() : Center(child: Text('Tidak ada Data'))
          isLoading
              ? const LoadingList()
              : RefreshIndicator(
                  onRefresh: _loadFromApi,
                  child: OrientationBuilder(builder: (context, x) {
                    return x == Orientation.portrait ? detailBody(context) : detailH(context);
                  })),
    );
  }

  buildTableHeader(BuildContext context, Orientation orientation) {
    return orientation == Orientation.portrait ? headerV(context) : headerH(context);
  }

  headerV(BuildContext context) {
    dp(lebar.toString());
    var lbr = MediaQuery.of(context).size.width - 20;
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.deepOrange,
        child: Row(children: [
          hKolom("TGL", lbr * .1, 0),
          hKolom("NOTRANS", lbr * .2, -1),
          hKolom("KONTAK", lbr * .2, -1),
          hKolom("DEBIT", lbr * .15, 1),
          hKolom("KREDIT", lbr * .15, 1),
          hKolom("SALDO", lbr * .2, 1),
        ]),
      ),
    );
  }

  headerH(BuildContext context) {
    dp(lebar.toString());
    var lbr = MediaQuery.of(context).size.width - 20;
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.deepOrange,
        child: Row(children: [
          hKolom("TGL", lbr * .1, 0),
          hKolom("NOTRANS", lbr * .1, -1),
          hKolom("KONTAK", lbr * .1, -1),
          hKolom("URAIAN", lbr * .4, -1),
          hKolom("DEBIT", lbr * .1, 1),
          hKolom("KREDIT", lbr * .1, 1),
          hKolom("SALDO", lbr * .1, 1),
        ]),
      ),
    );
  }

  Widget detailBody(BuildContext context) {
    var lbr = MediaQuery.of(context).size.width - 20;
    return ListView.builder(
        itemCount: jurnal!.length,
        itemBuilder: (context, index) {
          var model = jurnal![index];
          return ListTile(
            tileColor: (index % 2 == 0) ? Colors.white : Colors.orange[100],
            dense: true,
            contentPadding: const EdgeInsets.only(top: 0, bottom: -5, left: 10, right: 10),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kolom(formattanggal(model.tg.toString(), "dd/MM/yy HH.mm"), lbr * .2, -1),
                Row(
                  children: [
                    kolom("${model.nt}", lbr * .2, -1),
                    kolom("${model.kt}", lbr * .3, -1),
                    kolom(formatangka(model.d), lbr * .15, 1, st: const TextStyle(color: Colors.blue)),
                    kolom(formatangka(model.k), lbr * .15, 1, st: TextStyle(color: Colors.red[900])),
                    kolom(formatangka(model.s), lbr * .2, 1),
                  ],
                ),
              ],
            ),
            title: kolom("${model.u}", lbr * .9, -1),
          );
        });
  }

  Widget detailH(BuildContext context) {
    var lbr = MediaQuery.of(context).size.width - 20;
    return ListView.builder(
        itemCount: jurnal!.length,
        itemBuilder: (context, index) {
          var model = jurnal![index];
          return ListTile(
            tileColor: (index % 2 == 0) ? Colors.white : Colors.orangeAccent[100],
            dense: true,
            contentPadding: const EdgeInsets.only(top: 0, bottom: -5, left: 10, right: 10),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Row(
              children: [
                kolom(formattanggal(model.tg.toString()), lbr * .1, 0),
                kolom("${model.nt}", lbr * .1, -1),
                kolom("${model.kt}", lbr * .1, -1),
                kolom("${model.u}", lbr * .4, -1),
                kolom(formatangka(model.d), lbr * .1, 1),
                kolom(formatangka(model.k), lbr * .1, 1),
                kolom(formatangka(model.s), lbr * .1, 1),
              ],
            ),
          );
        });
  }

  Widget detailBodyPotrait(BuildContext context, int index, {List<Jurnal>? lt}) {
    var lbr = MediaQuery.of(context).size.width - 20;
    var model = (lt == null) ? jurnal![index] : lt[index];
    if (index == 0) {
      return Column(
        children: <Widget>[
          ListTile(
            tileColor: Colors.deepOrange,
            dense: true,
            contentPadding: const EdgeInsets.only(top: 0, bottom: -5, left: 10, right: 10),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Row(
              children: [
                hKolom("TANGGAL", lbr * .1, 0),
                hKolom("NOTRANS", lbr * .1, -1),
                hKolom("KONTAK", lbr * .1, -1),
                hKolom("URAIAN", lbr * .4, -1),
                hKolom("DEBIT", lbr * .1, 1),
                hKolom("KREDIT", lbr * .1, 1),
                hKolom("SALDO", lbr * .1, 1),
              ],
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(top: 0, bottom: -5, left: 10, right: 10),
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: Row(
              children: [
                kolom(formattanggal(model.tg.toString()), lbr * .1, 0),
                kolom("${model.nt}", lbr * .1, -1),
                kolom("${model.kt}", lbr * .1, -1),
                kolom("${model.u}", lbr * .4, -1),
                kolom(formatangka(model.d), lbr * .1, 1),
                kolom(formatangka(model.k), lbr * .1, 1),
                kolom(formatangka(model.s), lbr * .1, 1),
              ],
            ),
          ),
        ],
      );
    } else {
      return ListTile(
        tileColor: (index % 2 == 0) ? Colors.white : Colors.greenAccent[100],
        dense: true,
        contentPadding: const EdgeInsets.only(top: 0, bottom: -5, left: 10, right: 10),
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        title: Row(
          children: [
            kolom(formattanggal(model.tg.toString()), lbr * .1, 0),
            kolom("${model.nt}", lbr * .1, -1),
            kolom("${model.kt}", lbr * .1, -1),
            kolom("${model.u}", lbr * .4, -1),
            kolom(formatangka(model.d), lbr * .1, 1),
            kolom(formatangka(model.k), lbr * .1, 1),
            kolom(formatangka(model.s), lbr * .1, 1),
          ],
        ),
      );
    }
  }
}
