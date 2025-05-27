import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/homepage/umum/controller.dart';
// import 'package:ljm/pages/homepage/umum/kategori.dart';

class KategoriFilterBar extends StatefulWidget {
  final Function(Map<String, List<String>>, Map<String, String?>) onFilterApplied;
  final Function()? onOverlayClose;
  const KategoriFilterBar({
    Key? key,
    required this.onFilterApplied,
    this.onOverlayClose,
  }) : super(key: key);

  @override
  State<KategoriFilterBar> createState() => _KategoriFilterBarState();
}

class _KategoriFilterBarState extends State<KategoriFilterBar> {
  final Map<int, GlobalKey> _itemKeys = {};
  final List<String> kategori = ['Kategori', 'Merk', 'Stok', 'Harga'];
  int _selectedKategoriIndex = -1;

  late Map<String, List<String>> selectedFilters;
  late Map<String, String?> singleSelectionFilters;

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    selectedFilters = {
      'Kategori': [],
      'Merk': [],
    };
    singleSelectionFilters = {
      'Harga': null,
      'Stok': null,
    };
  }

  void closeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;

      setState(() {
        _selectedKategoriIndex = -1; // Reset agar semua kategori tidak aktif
      });
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // void _applyFilters() {
  //   widget.onFilterApplied(selectedFilters, singleSelectionFilters);
  // }

  void _showKategoriOverlayAtPosition(BuildContext context, int index, String kategori) {
    final key = _itemKeys[index];
    if (key == null || key.currentContext == null) return;

    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    List<String> options = [];
    switch (kategori) {
      case 'Kategori':
        options = Get.find<BarangUmumController>().brgKategori.map((e) => e.kategori ?? '').toList();
        print('Kategori options: $options');
        break;

      case 'Harga':
        options = ['Harga Tertinggi', 'Harga Terendah'];
        break;
      case 'Stok':
        options = ['Stok Terbanyak', 'Stok Tersedikit'];
        break;
      case 'Merk':
        options = ['Oraimo', 'Olike', 'Baseus', 'Ugreen'];
        break;
      //       case 'Merk':
      // options = Get.find<BarangUmumController>().brgMerk.map((e) => e.nama ?? '').toList();
      // break;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            top: offset.dy + size.height + 1,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _removeOverlay();
                setState(() {
                  _selectedKategoriIndex = -1;
                });
              },
              child: Container(),
            ),
          ),
          Positioned(
            top: offset.dy + size.height + 2,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 250),
                      child: SingleChildScrollView(
                        child: kategori == 'Harga' || kategori == 'Stok'
                            ? Column(
                                children: options.map((option) {
                                  return RadioTheme(
                                    data: RadioThemeData(
                                      fillColor: WidgetStateColor.resolveWith((states) {
                                        if (states.contains(WidgetState.selected)) {
                                          return Colors.blue; // warna lingkaran dalam (yang terisi)
                                        }
                                        return Colors.grey; // warna default
                                      }),
                                      overlayColor: WidgetStateColor.resolveWith((states) {
                                        if (states.contains(WidgetState.selected)) {
                                          return Colors.red.withValues(alpha: 0.2); // efek klik saat dipilih
                                        }
                                        return Colors.transparent;
                                      }),
                                    ),
                                    child: RadioListTile<String>(
                                      title: Text(
                                        option,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      value: option,
                                      groupValue: singleSelectionFilters[kategori],
                                      activeColor: Colors.red, // warna lingkaran luar (border)
                                      onChanged: (value) {
                                        setState(() {
                                          singleSelectionFilters[kategori] = value;
                                        });

                                        final controller = Get.find<BarangUmumController>();

                                        if (kategori == 'Harga') {
                                          controller.setSortByHarga(value ?? '');
                                        } else if (kategori == 'Stok') {
                                          controller.setSortByStok(value ?? '');
                                        }

                                        controller.pagingController.refresh();
                                        _overlayEntry?.markNeedsBuild();
                                      },
                                    ),
                                  );
                                }).toList(),
                              )
                            : LayoutBuilder(
                                builder: (context, constraints) {
                                  double screenWidth = constraints.maxWidth;
                                  double itemWidth = screenWidth < 600 ? (screenWidth - 24) / 2 : 200;

                                  return Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: options.map((option) {
                                      final isSelected = selectedFilters[kategori]!.contains(option);
                                      return Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (isSelected) {
                                                  selectedFilters[kategori]!.remove(option);
                                                } else {
                                                  selectedFilters[kategori]!.add(option);
                                                }

                                                // Ambil ID dari nama kategori yang dipilih
                                                final brgKategori = Get.find<BarangUmumController>().brgKategori;
                                                final match = brgKategori.firstWhereOrNull((e) => e.kategori == option);

                                                if (match != null) {
                                                  // Toggle kategori di controller
                                                  Get.find<BarangUmumController>().kategoriMultiChange(match.id ?? 0);
                                                } else {
                                                  // Kalau option tidak cocok kategori apa-apa, reset filter (tampilkan semua)
                                                  Get.find<BarangUmumController>().kategoriMultiChange(-6);
                                                }

                                                // Jika tidak ada filter yang aktif, reset filter ke semua
                                                if (selectedFilters[kategori]!.isEmpty) {
                                                  Get.find<BarangUmumController>().kategoriMultiChange(-6);
                                                }
                                              });

                                              _overlayEntry?.markNeedsBuild();
                                            },
//    onTap: () {
//   setState(() {
//     if (isSelected) {
//       selectedFilters[kategori]!.remove(option);
//     } else {
//       selectedFilters[kategori]!.add(option);
//     }

//     if (kategori == 'Kategori') {
//       final brgKategori = Get.find<BarangUmumController>().brgKategori;
//       final match = brgKategori.firstWhereOrNull((e) => e.kategori == option);
//       Get.find<BarangUmumController>().kategoriMultiChange(match?.id ?? -6);
//     }
//     // else if (kategori == 'Merk') {
//     //   final brgMerk = Get.find<BarangUmumController>().brgMerk;
//     //   final match = brgMerk.firstWhereOrNull((e) => e.nama == option);
//     //   if (match != null) {
//     //     Get.find<BarangUmumController>().merkMultiChange(match.id ?? 0);
//     //   } else {
//     //     Get.find<BarangUmumController>().merkMultiChange(-6);
//     //   }

//     //   if (selectedFilters[kategori]!.isEmpty) {
//     //     Get.find<BarangUmumController>().merkMultiChange(-6);
//     //   }
//     // }
//   });

//   _overlayEntry?.markNeedsBuild();
// },
                                            child: Container(
                                              width: itemWidth,
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: isSelected ? Colors.grey[200] : Colors.blue[50],
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: isSelected ? Colors.red : Colors.transparent,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                option,
                                                style: TextStyle(fontSize: 10, color: isSelected ? Colors.red : Colors.black),
                                              )),
                                            ),
                                          ),
                                          if (isSelected)
                                            const Positioned(
                                              top: 0,
                                              left: 0,
                                              child: Icon(Icons.check_circle, color: Colors.red, size: 18),
                                            ),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedFilters.forEach((key, value) => value.clear());
                              singleSelectionFilters.updateAll((key, value) => null);
                            });
                            Get.find<BarangUmumController>().resetFilter();
                            // Get.find<BarangUmumController>().resetFilter();
                            _removeOverlay();
                            _selectedKategoriIndex = -1;
                          },
                          child: const Text("Atur Ulang"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kategori.length,
        itemBuilder: (context, index) {
          _itemKeys.putIfAbsent(index, () => GlobalKey());
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            width: 100,
            child: ElevatedButton(
              key: _itemKeys[index],
              onPressed: () {
                setState(() {
                  if (_selectedKategoriIndex == index) {
                    _removeOverlay();
                    _selectedKategoriIndex = -1;
                  } else {
                    _removeOverlay();
                    _selectedKategoriIndex = index;
                    _showKategoriOverlayAtPosition(context, index, kategori[index]);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedKategoriIndex == index ? Colors.purpleAccent : Colors.white,
                foregroundColor: Colors.black,
                elevation: 3,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Text(kategori[index], textAlign: TextAlign.center),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }
}
