import 'package:flutter/material.dart';
import 'package:ljm/pages/homepage/widgets/editor.dart';
import 'package:ljm/provider/models/termin.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/provider/models/users/akseskas.dart';
import 'package:ljm/tools/env.dart';
import 'package:ljm/widgets/lookup/termin.dart';

class Pembayaran2Page extends StatefulWidget {
  final TRANSAKSI item;
  const Pembayaran2Page(this.item, {super.key});

  @override
  State<Pembayaran2Page> createState() => _Pembayaran2PageState();
}

class _Pembayaran2PageState extends State<Pembayaran2Page> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _controller = TextEditingController(text: "Rp 0");
  AksesKas? _selectedKas;
  List<String> x = ['Item 1', 'Item 2', 'Item 3'];
// Inisialisasi nilai awal untuk selected index
  List<String> items = []; // Daftar item
  final List<Tab> tabs = const [
    Tab(text: "Kas/Tunai"),
    Tab(text: "Non Tunai"),
    Tab(text: "Cicilan"),
  ];
  TRANSAKSI newTrans = TRANSAKSI();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    newTrans = widget.item;
    _selectedKas = user.akseskas?.firstWhere((x) => x.id == newTrans.rekkas);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller when the widget is removed
    _controller.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("PEMBAYARAN"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110), // Mengatur tinggi AppBar
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                totalTagihan(),
                TabBar(
                  controller: _tabController,
                  labelColor: mainColor,
                  dividerColor: background1,
                  unselectedLabelColor: background1,
                  indicatorColor: mainColor1,
                  tabs: tabs,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight - 150,
          child: TabBarView(
            controller: _tabController,
            children: [tabKasTunai(), tabNonTunai(), tabCicilan()],
          ),
        ),
      ),
    );
  }

  Widget totalTagihan() {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Tagihan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(formatuang(newTrans.nilaitotal), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget tabKasTunai() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Warna latar belakang hijau
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Border radius 5
                ),
                padding: const EdgeInsets.symmetric(vertical: 0), // Tidak ada padding vertikal
                fixedSize: const Size(double.infinity, 40), // Ukuran tombol: lebar penuh dan tinggi 40
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.money, color: Colors.white), // Ikon uang di sebelah kiri, warna putih
                        SizedBox(width: 8.0), // Jarak antara ikon dan teks
                        Text(
                          "Terima Uang Pas",
                          style: TextStyle(color: Colors.white), // Teks di tengah, warna putih
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward, color: Colors.white), // Ikon panah di sebelah kanan, warna putih
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Uang Diterima",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          textFieldInput(),
        ],
      ),
    );
  }

  Widget textFieldInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24, // Ukuran font 24
          fontWeight: FontWeight.bold, // Teks tebal
        ),
      ),
    );
  }

  Widget tabNonTunai() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "*Hanya untuk pencatatan.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16.0),
          if (user.akseskas != null)
            Expanded(
              flex: 11,
              child: Column(
                children: [
                  Container(
                    height: (user.akseskas!.length) * 70,
                    child: ListView.builder(
                      itemCount: user.akseskas!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(user.akseskas![index].alias ?? ''),
                          leading: Radio<AksesKas>(
                            activeColor: mainColor,
                            // WidgetStateProperty<Color?>? fillColor,
                            focusColor: Colors.red,
                            hoverColor: background1,
                            toggleable: true,
                            value: user.akseskas![index],
                            groupValue: _selectedKas,
                            onChanged: (AksesKas? value) {
                              setState(() {
                                _selectedKas = user.akseskas?[index];
                                newTrans.rekkas = _selectedKas?.id;
                                newTrans.akunkas = _selectedKas?.rekening;
                              });
                            },
                          ),
                          onTap: () {
                            setState(() {
                              _selectedKas = user.akseskas?[index];
                              newTrans.rekkas = _selectedKas?.id;
                              newTrans.akunkas = _selectedKas?.rekening;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10), // Jarak tetap antara ListView dan tombol "Tambah Non Tunai"
                  // SizedBox(
                  //   height: 40,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Aksi ketika tombol ditekan
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.green,
                  //       padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  //     ),
                  //     child: const Text("Tambah Non Tunai"),
                  //   ),
                  // ),
                  const Spacer(),
                ],
              ),
            ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi ketika tombol ditekan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                ),
                child: const Text("Simpan"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabCicilan() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Metode Pembayaran"),
          DropdownMetodePembayaran(
            initial: newTrans.rekkas,
            onChanged: (v) {
              newTrans.rekkas = v;
            },
          ),
          // Row(
          //   children: [
          //     Expanded(
          //         child: DropdownMetodePembayaran(
          //       initial: newTrans.rekkas,
          //       onChanged: (v) {
          //         newTrans.rekkas = v;
          //       },
          //     )),
          //     const SizedBox(width: 20),
          //     Container(
          //       width: 30,
          //       height: 30,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         border: Border.all(color: Colors.black, width: 2),
          //       ),
          //       child: const Icon(
          //         Icons.add,
          //         color: Colors.black,
          //         size: 20,
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 10),
          editoruang(context, 'Masukkan Nila Pembayaran', formatangka(newTrans.bayar)),
          const SizedBox(height: 5),
          PilihTermin(
            initial: TERMIN(kode: newTrans.termin),
            onPilih: (p0) {
              if (p0 != null) {
                newTrans.termin = p0.kode;
                newTrans.tempo = DateTime.parse(newTrans.tanggal!).add(Duration(days: p0.hari ?? 0)).toString();
                setState(() {});
              }
            },
          ),
          const SizedBox(height: 5),
          const Text("Keterangan"),
          const SizedBox(height: 5),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukkan keterangan',
            ),
          ),
          Expanded(child: Container()),
          /* const SizedBox(height: 10),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              child: const Text("Tambah Non Tunai"),
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: items.isEmpty
                ? Center(child: Text("Kosong")) // Menampilkan pesan "Kosong" jika daftar item kosong
                : ListView.builder(
                    itemCount: 2, // Ganti dengan jumlah item yang sesuai
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Item Non Tunai $index'),
                        leading: Radio<int>(
                          value: index,
                          groupValue: _selectedIndex,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedIndex = value;
                            });
                          },
                        ),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                      );
                    },
                  ),
          ), */
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Rp. 0", style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (newTrans.termin != null || ((newTrans.bayar ?? 0) >= (newTrans.nilaitotal ?? 0)))
                  ? () {
                      // Aksi ketika tombol ditekan
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              child: const Text("Simpan"),
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownMetodePembayaran extends StatefulWidget {
  final double? initial;
  final Function(double?)? onChanged;
  const DropdownMetodePembayaran({this.initial, this.onChanged, super.key});
  @override
  _DropdownMetodePembayaranState createState() => _DropdownMetodePembayaranState();
}

class _DropdownMetodePembayaranState extends State<DropdownMetodePembayaran> {
  double? _selected;
  @override
  void initState() {
    super.initState();
    _selected = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton<double>(
            iconEnabledColor: mainColor,
            value: _selected,
            onChanged: (double? newValue) {
              setState(() {
                _selected = newValue;
                if (widget.onChanged != null) widget.onChanged!(newValue);
              });
            },
            items: user.akseskas!.map<DropdownMenuItem<double>>((a) {
              return DropdownMenuItem<double>(
                value: a.id ?? 0,
                child: Text(a.alias ?? ''),
              );
            }).toList(),
            // Tambahkan style atau properti lain jika dibutuhkan
            isExpanded: true,
          ),
        ),
        Container(
          height: 1.0, // Tinggi garis
          color: mainColor, // Warna garis
        ),
      ],
    );
  }
}
