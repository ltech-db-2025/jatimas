import 'package:flutter/material.dart';
import 'package:ljm/widgets/customtextfield.dart';

class PilihKategori extends StatefulWidget {
  const PilihKategori({super.key});

  @override
  State<PilihKategori> createState() => _PilihKategoriState();
}

class _PilihKategoriState extends State<PilihKategori> {
  var selected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child:
          // widget.child ??
          IgnorePointer(
        child: CustomTextField(
          readOnly: true,
          controller: TextEditingController(text: selected?.nama ?? 'Pilih Kategori'),
          label: 'Kategori',
          suffixIcon: Icons.arrow_forward_ios_outlined,
        ),
      ),
      onTap: () {
        // if (widget.enabled)
        //   showModalBottomSheet(
        //     context: context,
        //     isScrollControlled: true,
        //     builder: (BuildContext context) {
        //       return SizedBox(
        //         height: MediaQuery.of(context).size.height * 0.50,
        //         child: Column(
        //           children: <Widget>[
        //             Container(
        //               padding: const EdgeInsets.all(16.0),
        //               child: const Text('Pilih Merk :', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        //             ),
        //             Expanded(
        //                 child: TablePaginate(
        //                     itemBuilder: (context, itemx, index) {
        //                       var item = HARGA.fromMap(itemx);
        //                       return ListTile(
        //                           selectedTileColor: customTema.appBarTheme.backgroundColor,
        //                           selected: (item.kode == selected?.kode),
        //                           dense: true,
        //                           visualDensity: const VisualDensity(vertical: -4),
        //                           title: Text(item.nama ?? ''),
        //                           onTap: () {
        //                             selected = item;
        //                             widget.onPilih?.call(item);
        //                             setState(() {});
        //                             Get.back(result: item);
        //                           });
        //                     },
        //                     sql: sql)),
        //           ],
        //         ),
        //       );
        //     },
        //   );
      },
    );
  }
}
