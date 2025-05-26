/* import 'pdf_viewer_page.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';

import 'package:ljm/provider/dbprovider.dart';
import 'package:ljm/env.dart';

import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' as material;

reportView(context) async {
  final Document pdf = Document();
  int i = 1;

  pdf.addPage(MultiPage(
      maxPages: 100,
      pageFormat: PdfPageFormat.legal.copyWith(
        marginBottom: 0.5 * PdfPageFormat.cm,
        marginTop: 0.5 * PdfPageFormat.cm,
        marginLeft: 0.5 * PdfPageFormat.cm,
        marginRight: 0.5 * PdfPageFormat.cm,
      ),
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: PdfColors.grey))),
          child: Text('Lucky Jaya Motorindo', style: Theme.of(context).defaultTextStyle.copyWith(color: PdfColors.grey)),
        );
      },
      footer: (Context context) {
        return Container(
          //alignment: Alignment.topLeft,
          margin: const EdgeInsets.all(0.5 * PdfPageFormat.cm),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Halaman ${context.pageNumber} dari ${context.pagesCount}', style: Theme.of(context).defaultTextStyle.copyWith(color: PdfColors.grey)),
            Text(formattanggal(DateTime.now().toString(), format: 'dd/MM/yyyy HH:mm')),
          ]),
        );
      },
      build: (Context context) => [
            Header(level: 0, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text('Lucky Jaya Motorindo'), PdfLogo()])),
            Header(level: 1, text: 'Price List Sparepart'),
            Table(
              children: listbarang.where((element) => element.s > 0).map((item) {
                i++;

                return TableRow(
                  decoration: BoxDecoration(color: (i % 2 == 0) ? PdfColors.grey200 : PdfColors.white /* , border: Border(bottom: BorderSide(color: PdfColors.grey800, width: .5)) */),
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(item.n.toString().5),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(item.k.toString()),
                        Text(item.m.toString()),
                      ])
                    ]),
                    Container(padding: EdgeInsets.only(top: .5 * PdfPageFormat.cm), child: Text(formatangka(item.j2).5), alignment: Alignment(1, 1)),
                  ],
                );
              }).toList(),
            )
          ]));
  //save PDF

  Directory directory;
  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }
  final String path = '${directory.path}/pricelist_ljm.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());
  material.Navigator.of(context).push(
    material.MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path),
    ),
  );
}
 */
