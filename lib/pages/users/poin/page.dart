import 'package:flutter/material.dart';
import 'package:ljm/tools/env.dart';

import 'model.dart';

class PoinPage extends StatefulWidget {
  const PoinPage({super.key});

  @override
  State<PoinPage> createState() => _PoinPageState();
}

class _PoinPageState extends State<PoinPage> {
  var listPoin = <Poin>[];

  @override
  void initState() {
    initData();
    super.initState();
  }

  setLoading([value = true]) {
    setState(() {
      isLoading = value;
    });
  }

  initData() async {
    setLoading();
    listPoin = await Poin.fetchData(getidKontak());
    setProses('download data Poin Selesai');

    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Poin ${getUserName()}')),
        body: (isLoading)
            ? showloading()
            : ListView.builder(
                itemCount: listPoin.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      dense: true,
                      leading: Text(formattanggal(listPoin[index].tanggal)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(listPoin[index].keterangan),
                          Text(listPoin[index].notrans),
                        ],
                      ),
                      subtitle: Text(listPoin[index].kontak!.nama ?? ''),
                      trailing: SizedBox(width: 50, child: Align(alignment: Alignment.centerRight, child: Text(formatangka(listPoin[index].poin.toString())))));
                }));
  }
}
