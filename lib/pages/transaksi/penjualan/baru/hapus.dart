import 'package:flutter/material.dart';
import 'package:ljm/provider/models/termin.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/widgets/lookup/termin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Default',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PagePembayaran(),
    );
  }
}

class PagePembayaran extends StatefulWidget {
  // final TRANSAKSI data;
  // const PagePembayaran(this.data, {super.key});

  @override
  State<PagePembayaran> createState() => _PagePembayaranState();
}

class _PagePembayaranState extends State<PagePembayaran> {
  // TRANSAKSI newtrans = TRANSAKSI();
  // var pembayaranController = TextEditingController();
  // @override
  // void initState() {
  //   newtrans = widget.data;
  //   if ((newtrans.bayar ?? 0) == 0) newtrans.kredit = (newtrans.nilaitotal ?? 0) - (newtrans.bayar ?? 0);
  //   pembayaranController.text = formatangka(newtrans.proses);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Pembayaran'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/logoleonwarna.png",
                  height: 200,
                  width: 200,
                ),
              ),
              TextJudulBody(text: 'Total Tagihan'),

              Text(
                'formatuang(newtrans.nilaitotal)',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              PilihTermin(
                initial: TERMIN(kode: 'newtrans.termin'),
                onPilih: (p0) {
                  if (p0 != null) {
                    // newtrans.termin = p0.kode;
                    // newtrans.tempo = DateTime.parse(newtrans.tanggal!).add(Duration(days: p0.hari ?? 0)).toString();
                    // setState(() {});
                  }
                },
              ),
              // if ((newtrans.kredit ?? 0) > 0)
              //   Text(
              //     "Jatuh Tempo : {formattanggal(newtrans.tempo, 'EEEE, dd/MM/yyyy')}",
              //     // style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              //   ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Jumlah Bayar', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black)),
                  Text('newtrans.akunkas.toString()', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black)),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                // controller: pembayaranController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // final bayar = double.tryParse(value) ?? 0;
                  // if ((newtrans.nilaitotal ?? 0) > (bayar)) {
                  //   newtrans.proses = bayar;
                  //   newtrans.bayar = bayar;
                  //   newtrans.kredit = (newtrans.nilaitotal ?? 0) - (newtrans.bayar ?? 0);
                  //   newtrans.sisa = 0;
                  // } else {
                  //   newtrans.proses = bayar;
                  //   newtrans.bayar = newtrans.nilaitotal;
                  //   newtrans.kredit = 0;
                  //   newtrans.sisa = bayar - (newtrans.nilaitotal ?? 0);
                  // }
                  // setState(() {});
                },
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
//               if ((newtrans.sisa ?? 0) > 0 || (newtrans.kredit ?? 0) > 0)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       ((newtrans.kredit ?? 0) > 0) ? 'Sisa Tagihan' : "Kembalian",
//                       style: Theme.of(context).textTheme.headlineSmall,
//                     ),
//                     Text(
// '                      formatuang(((newtrans.kredit ?? 0) > 0) ? newtrans.kredit : newtrans.sisa)',
//                       style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity, // Mengatur lebar tombol selebar layar
                child: ElevatedButton(
                  onPressed: ()
                      //  async
                      {
                    // dynamic res;
                    // if ((newtrans.id ?? 0) < 1) {
                    //   res = await getPenjualanController().simpanNewDraft(newtrans);
                    // } else {
                    //   res = await getPenjualanController().updateDraft(newtrans);
                    // }
                    // if (res is TRANSAKSI) {
                    //   var ares = await getPenjualanController().simpanDrafttoNota(res);
                    //   if (ares != null) {
                    //     newtrans = ares;
                    //     Get.offNamedUntil('/penjualan/pembayaran/cetaknotapenjualan', (route) => route.settings.name == '/penjualan', arguments: newtrans);
                    //   }
                    // } else {
                    //   pesanError("Kesalahan dalam menyimpan");
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Warna latar belakang tombol
                  ),
                  child: Text(
                    'Simpan Pembayaran',
                    style: TextStyle(
                      color: Colors.white, // Warna teks
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PagePembayaranPiutang extends StatefulWidget {
  const PagePembayaranPiutang({
    super.key,
  });

  @override
  State<PagePembayaranPiutang> createState() => _PagePembayaranPiutangState();
}

class _PagePembayaranPiutangState extends State<PagePembayaranPiutang> {
  // // List<TRANSAKSI?> notadibayar = [];
  // var dataNota;
  // double? bayar = 0;
  // var x;
  // var pembayaran;
  // var pembayaranController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   dataNota = Get.arguments['data'] ?? [];
  //   pembayaran = Get.arguments['pembayaran'] ?? 0;
  //   pembayaranController.text = pembayaran.toString();
  //   x = pembayaranController.text;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Pembayaran Piutang'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/logoleonwarna.png", // Ganti dengan path yang sesuai
                  height: 200, // Atur tinggi gambar sesuai kebutuhan
                  width: 200, // Atur lebar gambar sesuai kebutuhan
                ),
              ),
              Text(
                'Total Piutang',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                'formatuang(pembayaran)',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Align(alignment: Alignment.centerLeft, child: Text('Jumlah Bayar', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black))),
              const SizedBox(height: 10),
              TextField(
                // controller: pembayaranController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // final bayar = double.tryParse(value) ?? 0;
                  // if ((pembayaran ?? 0) > (bayar)) {
                  //   dataNota.bayar = bayar;
                  //   dataNota.kredit = (dataNota.nilaitotal ?? 0) - (dataNota.bayar ?? 0);
                  // }
                  // // else {
                  // //   dataNota.proses = bayar;
                  // //   dataNota.bayar = dataNota.nilaitotal;
                  // //   dataNota.kredit = 0;
                  // //   dataNota.sisa = bayar - (dataNota.nilaitotal ?? 0);
                  // // }
                  // setState(() {});
                },
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // if ((newtrans.sisa ?? 0) > 0 || (newtrans.kredit ?? 0) > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                    // ((newtrans.kredit ?? 0) > 0) ? 'Sisa Tagihan' : "Kembalian",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "",
                    // formatuang(((newtrans.kredit ?? 0) > 0) ? newtrans.kredit : newtrans.sisa),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                width: double.infinity, // Mengatur lebar tombol selebar layar
                child: ElevatedButton(
                  onPressed: ()
                      // async
                      {
                    // // if (newtrans.bayar != null) {
                    // //   var sql = """ update t_draft
                    // //   set bayar = ${newtrans.bayar},
                    // //   kredit = ${newtrans.kredit},
                    // //   proses = ${newtrans.proses},
                    // //   sisa = ${newtrans.sisa}
                    // //    """;
                    // //   sql += " where id = ${newtrans.id}";
                    // //   await executeSql(sql);
                    // // }

                    // if (dataNota.isNotEmpty) {
                    //   // Print the contents of dataNota
                    //   debugPrint('Data to send: ${dataNota.map((nota) => {'id': nota?.id, 'nilaitotal': nota?.nilaitotal, 'bayar': nota?.bayar}).toList()}');
                    //   // Debug print the bayar value
                    //   debugPrint('Bayar value: $x'); // Mencetak nilai bayar
                    //   // Navigate to the next page and send the data
                    //   Get.toNamed('/penjualan/pembayaran/cetaknotapiutang', arguments: {
                    //     // "data": notadibayar,
                    //     "data": dataNota,
                    //     "totalpiutang": pembayaran,
                    //     "bayar": x,
                    //   });
                    // } else {
                    //   // Show a message or handle the case where there is no data
                    //   debugPrint('No data to send.');
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Warna latar belakang tombol
                  ),
                  child: Text(
                    'Simpan Pembayaran',
                    style: TextStyle(
                      color: Colors.white, // Warna teks
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 200, // Ganti dengan minHeight yang Anda inginkan
                ),
                child: Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // itemCount: dataNota.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nota: {dataNota[index].id}'),
                            Text('{formatuang(dataNota[index].nilaitotal)}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
