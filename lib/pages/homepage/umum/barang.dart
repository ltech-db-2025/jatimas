import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ljm/provider/models/barang.dart';
import 'package:ljm/tools/env.dart';
import 'package:photo_view/photo_view.dart';
// ignore: unused_import
import 'package:photo_view/photo_view_gallery.dart';

Widget buildGridItem(BuildContext context, BARANG data) {
  final lebarlabel = 70.0;
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
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Image.network(
                              data.fileGambar ?? '',
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.edit),
                            label: Text("Edit Gambar"),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child: CachedNetworkImage(
            imageUrl: data.fileGambar ?? '',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
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
      ],
    ),
  );
}
