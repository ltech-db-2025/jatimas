import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

Widget kategoriWidget(BuildContext context, BarangUmumController c) => SizedBox(
      width: double.infinity,
      height: 30,
      child: Obx(() => Container(
            color: Colors.white.withAlpha(1),
            child: Row(
              children: [
                // Hidden trigger text (optional)
                Text(c.trigger.toString(), style: const TextStyle(color: Colors.white70, fontSize: 2)),

                // Tombol 'Semua Kategori' sebagai label kategoriCap
                JenisLayanan(
                  c.kategoriCap.value,
                  selectedColor: Colors.deepOrange,
                  isSelected: c.selectedKategoriList.isEmpty || c.selectedKategoriList.contains(-6),
                  onTap: () {
                    List<PopupMenuEntry> menuItems = [
                      PopupMenuItem(
                        height: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Semua Kategori'),
                            if (c.selectedKategoriList.isEmpty || c.selectedKategoriList.contains(-6)) const Icon(Icons.check, size: 12),
                          ],
                        ),
                        onTap: () {
                          c.kategoriMultiChange(-6); // reset semua kategori
                        },
                      )
                    ];

                    // Tambahkan semua kategori
                    for (var kategori in c.brgKategori) {
                      final id = kategori.id ?? 0;
                      menuItems.add(
                        PopupMenuItem(
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(kategori.kategori ?? ''),
                              if (c.selectedKategoriList.contains(id)) const Icon(Icons.check, size: 12),
                            ],
                          ),
                          onTap: () {
                            c.kategoriMultiChange(id); // toggle kategori
                          },
                        ),
                      );
                    }

                    showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(0, 200, 0, 0),
                      items: menuItems,
                    );
                  },
                ),

                // List horizontal kategori
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: c.scrollController.value,
                    scrollDirection: Axis.horizontal,
                    itemCount: c.brgKategori.length,
                    itemBuilder: (context, i) {
                      final id = c.brgKategori[i].id ?? 0;
                      return JenisLayanan(
                        c.brgKategori[i].kategori ?? '',
                        isSelected: c.selectedKategoriList.contains(id),
                        onTap: () {
                          c.kategoriMultiChange(id); // toggle kategori
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );

// Widget kategoriWidget(BuildContext context, BarangUmumController c) => SizedBox(
//     width: double.infinity,
//     height: 30,
//     child: Obx(() => Container(
//           color: Colors.white.withValues(alpha: 1),
//           child: Row(
//             children: [
//               Text(c.trigger.toString(), style: const TextStyle(color: Colors.white70, fontSize: 2)),
//               JenisLayanan(
//                 c.kategoriCap.value,
//                 selectedColor: Colors.deepOrange,
//                 isSelected: true,
//                 onTap: () {
//                   List<PopupMenuEntry> lit = [
//                     PopupMenuItem(
//                       height: 20,
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Semua Kategori'),
//                           if (-6 == c.selectedJenis.value) const Icon(Icons.check, size: 12),
//                         ],
//                       ),
//                       onTap: () {
//                         c.kategoriMultiChange(-6);
//                         //  scrollController.animateTo(double.parse(i.toString()) * lebarkolom, duration: Duration(seconds: 1), curve: Curves.ease);
//                       },
//                     )
//                   ];

//                   for (int n = 0; n < c.brgKategori.length; n++) {
//                     final kategoriId = c.brgKategori[n].id ?? 0;
//                     lit.add(PopupMenuItem(
//                       height: 20,
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(c.brgKategori[n].kategori ?? ''),
//                           if (c.selectedKategoriList.contains(kategoriId)) const Icon(Icons.check, size: 12),
//                         ],
//                       ),
//                       onTap: () {
//                         c.kategoriMultiChange(kategoriId);
//                       },
//                     ));
//                   }
//                   // for (int n = 0; n < c.brgKategori.length; n++) {
//                   //   lit.add(PopupMenuItem(
//                   //     height: 20,
//                   //     padding: const EdgeInsets.symmetric(horizontal: 8),
//                   //     child: Row(
//                   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //       children: [
//                   //         Text(c.brgKategori[n].kategori ?? ''),
//                   //         if (c.brgKategori[n].id == c.selectedJenis.value) const Icon(Icons.check, size: 12),
//                   //       ],
//                   //     ),
//                   //     onTap: () {
//                   //       c.kategoriChange(c.brgKategori[n].id ?? 0);
//                   //       // scrollController.animateTo(double.parse(n.toString()) * lebarkolom, duration: Duration(seconds: 1), curve: Curves.ease);
//                   //     },
//                   //   ));
//                   // }
//                   showMenu(
//                     context: context,
//                     position: const RelativeRect.fromLTRB(0, 200, 0, 0),
//                     items: lit,
//                   );
//                 },
//               ),
//               Expanded(
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       controller: c.scrollController.value,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: c.brgKategori.length,
//                       itemBuilder: (context, i) {
//                         final id = c.brgKategori[i].id ?? 0;
//                         return JenisLayanan(
//                           c.brgKategori[i].kategori.toString(),
//                           isSelected: c.selectedKategoriList.contains(id),
//                           onTap: () {
//                             c.kategoriMultiChange(id);
//                           },
//                         );
//                       }))
//             ],
//           ),
//         )));

class JenisLayanan extends StatelessWidget {
  final String layanan;
  final bool isSelected;
  final Color? selectedColor;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  const JenisLayanan(this.layanan, {this.isSelected = false, required this.onTap, this.onLongPress, this.selectedColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: MaterialButton(
        onLongPress: onLongPress,
        onPressed: onTap,
        color: isSelected ? selectedColor ?? Colors.black54 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        child: Text(layanan, style: TextStyle(fontSize: 10, color: isSelected ? Colors.white : Colors.black45)),
      ),
    );
  }
}
