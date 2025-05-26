import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/provider/models/transaksi/detail.dart';
import 'package:ljm/tools/env.dart';
import 'package:photo_view/photo_view.dart';
// ignore: unused_import
import 'package:photo_view/photo_view_gallery.dart';

import 'controller.dart';

class ItemBarang extends StatefulWidget {
  final BARANG data;
  final DETAIL? d;
  final BarangMemberController c;
  ItemBarang(this.data, this.d, this.c, {super.key});

  @override
  State<ItemBarang> createState() => _ItemBarangState();
}

class _ItemBarangState extends State<ItemBarang> {
  DETAIL? d;
  var data = BARANG();
  var loading = true;
  final lebarlabel = 70.0;
  late BarangMemberController c;
  @override
  void initState() {
    d = widget.d;
    data = widget.data;
    loading = false;
    c = widget.c;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Ubah nilai ini untuk mengatur kelengkungan
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: AutoSizeText(
                textAlign: TextAlign.center,
                data.nama,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white),
                minFontSize: 2,
                maxLines: 2,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Show the image preview on tap
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhotoView.customChild(
                          enableRotation: true,
                          child: Scaffold(
                            appBar: AppBar(
                              title: Text(data.nama),
                            ),
                            body: Center(child: Image.network(data.fileGambar ?? '')),
                          ))));
            },
            child: CachedNetworkImage(
              imageUrl: data.fileGambar ?? '',
              height: 200,
              width: double.infinity,
              fit: BoxFit.scaleDown,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: lebarlabel, child: AutoSizeText('Kategori', style: TextStyle(color: Colors.grey[700], fontSize: 12), maxLines: 1, minFontSize: 6)),
                    AutoSizeText(data.kategori ?? '', style: TextStyle(color: Colors.grey[700], fontSize: 12), maxLines: 1, minFontSize: 6),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: lebarlabel, child: AutoSizeText('Stok', style: TextStyle(color: Colors.grey[700], fontSize: 12), maxLines: 1, minFontSize: 6)),
                    AutoSizeText(formatangka(data.stok), style: TextStyle(color: Colors.grey[700], fontSize: 12), maxLines: 1, minFontSize: 6),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: lebarlabel, child: AutoSizeText('Satuan', style: TextStyle(color: Colors.grey[700], fontSize: 12), maxLines: 1, minFontSize: 6)),
                    AutoSizeText(data.satuan, style: TextStyle(color: Colors.grey[700], fontSize: 12), maxLines: 1, minFontSize: 6),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: lebarlabel, child: AutoSizeText('Merk', style: TextStyle(color: Colors.grey[700], fontSize: 12))),
                    AutoSizeText(data.merk, style: TextStyle(color: Colors.grey[700], fontSize: 12), maxLines: 1, minFontSize: 6),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: lebarlabel, child: AutoSizeText('Harga', style: TextStyle(color: Colors.grey[700], fontSize: 12))),
                    AutoSizeText(formatuang(data.harga), style: TextStyle(color: Colors.grey[700], fontSize: 12), maxLines: 1, minFontSize: 6),
                  ],
                ),
              ],
            ),
          ),
          if (d == null)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () async {
                      var res = await c.tambah(data);
                      if (res is DETAIL) {
                        setState(() {
                          d = res;
                        });
                      }
                    },
                    child: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Colors.green,
                    )),
              ),
            ),
          if (d != null)
            if (d!.proses != 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () async {
                          var res = await c.kurang(data);
                          if (res is DETAIL) {
                            setState(() {
                              d = res;
                            });
                          }
                        },
                        child: Icon(
                          Icons.remove_circle_outline_outlined,
                          color: Colors.red,
                        )),
                    SizedBox(width: 10),
                    Text(formatangka(d!.proses)),
                    SizedBox(width: 10),
                    InkWell(
                        onTap: () async {
                          var res = await c.tambah(data);
                          if (res is DETAIL) {
                            setState(() {
                              d = res;
                            });
                          }
                        },
                        child: Icon(
                          Icons.add_circle_outline_outlined,
                          color: Colors.green,
                        )),
                  ],
                ),
              ),
          if (d != null)
            if (d!.proses == 0)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () async {
                        var res = await c.tambah(data);
                        if (res is DETAIL) {
                          setState(() {
                            d = res;
                          });
                        }
                      },
                      child: Icon(
                        Icons.add_shopping_cart_outlined,
                        color: Colors.green,
                      )),
                ),
              ),
        ],
      ),
    );
  }
}
