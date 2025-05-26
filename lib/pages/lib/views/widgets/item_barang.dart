import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ljm/pages/lib/views/screens/detail_barang.dart';
import 'package:ljm/pages/lib/views/widgets/rating_tag.dart';
import 'package:ljm/provider/models/barang.dart';
import '../../constant/app_color.dart';

import '../../main.dart';

class ItemBARANG extends StatelessWidget {
  final BARANG barang;
  final Color titleColor;
  final Color priceColor;

  const ItemBARANG({
    super.key,
    required this.barang,
    this.titleColor = Colors.black,
    this.priceColor = AppColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BARANGDetail(barang: barang)));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // item image
          Container(
            height: 150,
            padding: const EdgeInsets.all(5),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(image: AssetImage('assets/play_store_256.jpeg'), fit: BoxFit.cover),
            ),
            child: TitleTag(value: double.tryParse(barang.stok.toString()) ?? 0),
          ),

          // item details
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barang.nama,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2, bottom: 8),
                  child: Text(
                    //barang.merk,
                    Pecahan.rupiahsd(double.tryParse(barang.jual4.toString()) ?? 0, double.tryParse(barang.jual5.toString()) ?? 0, withRp: true),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      color: priceColor,
                    ),
                  ),
                ),
                AutoSizeText(
                  barang.merk,
                  minFontSize: 6,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 10,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
