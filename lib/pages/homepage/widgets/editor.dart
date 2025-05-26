import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:ljm/tools/env.dart';

header(String label) => Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: 40,
      color: Colors.grey,
      child: Text(
        label,
        //style: GoogleFonts. (fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)
      ),
    );
var labelstyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.italic,
);

/* editKelompok() {
  var bk = BrgKelompok();
  return Get.dialog(AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Masukkan Nama Kelompok Barang Baru."),
        const Divider(thickness: 1),
        TextFormField(
          onChanged: (c) => bk.kelompok = c,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Kelompok Baru"),
        ),
      ],
    ),
    actions: <Widget>[
      Row(
        children: <Widget>[
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(
              onPressed: () async {
                if (bk.kelompok.isNotEmpty) {
                  var res = await bk.simpan();
                  if (res is BrgKelompok) {
                    bk = res.copyWith();
                    dbc.mBrgKelompok.add(bk);
                    Get.back(result: bk);
                  }
                } else {
                  Get.back();
                }
              },
              child: const Text("OK"))
        ],
      ),
    ],
  ));
}

editSatuan() {
  var bk = Satuan();
  return Get.dialog(AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Masukkan Nama Satuan Barang Baru."),
        const Divider(thickness: 1),
        TextFormField(
          onChanged: (c) => bk.satuan = c,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Satuan Baru"),
        ),
      ],
    ),
    actions: <Widget>[
      Row(
        children: <Widget>[
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(
              onPressed: () async {
                if (bk.satuan.isNotEmpty) {
                  var res = await bk.simpan();
                  if (res is Satuan) {
                    bk = res.copyWith();
                    dbc.mSatuan.add(bk);
                    Get.back(result: bk);
                  }
                } else {
                  Get.back();
                }
              },
              child: const Text("OK"))
        ],
      ),
    ],
  ));
}

editjenis() {
  var bk = BrgJenis();
  return Get.dialog(AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Masukkan Nama Jenis Barang Baru."),
        const Divider(thickness: 1),
        TextFormField(
          onChanged: (c) => bk.jenis = c,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Jenis Baru"),
        ),
      ],
    ),
    actions: <Widget>[
      Row(
        children: <Widget>[
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(
              onPressed: () async {
                if (bk.jenis.isNotEmpty) {
                  var res = await bk.simpan();
                  if (res is BrgJenis) {
                    bk = res.copyWith();
                    dbc.mBrgJenis.add(bk);
                    Get.back(result: bk);
                  }
                } else {
                  Get.back();
                }
              },
              child: const Text("OK"))
        ],
      ),
    ],
  ));
}

editGolongan() {
  var bk = BrgGolongan();
  return Get.dialog(AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Masukkan Nama Golongan Barang Baru."),
        const Divider(thickness: 1),
        TextFormField(
          onChanged: (c) => bk.nama = c,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Golongan Baru"),
        ),
      ],
    ),
    actions: <Widget>[
      Row(
        children: <Widget>[
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(
              onPressed: () async {
                if (bk.nama != null) {
                  var res = await bk.simpan();
                  if (res is BrgGolongan) {
                    bk = res.copyWith();
                    dbc.mBrgGolongan.add(bk);
                    Get.back(result: bk);
                  }
                } else {
                  Get.back();
                }
              },
              child: const Text("OK"))
        ],
      ),
    ],
  ));
}

editMerk() {
  var bk = BrgMerk();
  return Get.dialog(AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Masukkan Nama Merk Barang Baru."),
        const Divider(thickness: 1),
        TextFormField(
          onChanged: (c) => bk.merk = c,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Merk Baru"),
        ),
      ],
    ),
    actions: <Widget>[
      Row(
        children: <Widget>[
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(
              onPressed: () async {
                var res = await bk.simpan();
                if (res is BrgMerk) {
                  bk = res.copyWith();
                  dbc.mBrgMerk.add(bk);
                  Get.back(result: bk);
                }
              },
              child: const Text("OK"))
        ],
      ),
    ],
  ));
}

editKategori() {
  var bk = BrgKategori();
  return Get.dialog(AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Masukkan Nama Kategori Barang Baru."),
        const Divider(thickness: 1),
        TextFormField(
          onChanged: (c) => bk.kategori = c,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Kategori Baru"),
        ),
      ],
    ),
    actions: <Widget>[
      Row(
        children: <Widget>[
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Get.back(result: false),
          ),
          TextButton(
              onPressed: () async {
                if (bk.kategori.isNotEmpty) {
                  var res = await bk.simpan();
                  if (res is BrgKategori) {
                    bk = res.copyWith();
                    dbc.mBrgKategori.add(bk);
                    Get.back(result: bk);
                  }
                } else {
                  Get.back();
                }
              },
              child: const Text("OK"))
        ],
      ),
    ],
  ));
}
 */
editor2(String label, Widget child) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        child,
        const SizedBox(height: 5),
      ],
    ),
  );
}

editor(BuildContext context, String? initial, {String? Function(String?)? validator, String? label, String? hint, bool enabled = true, double scaleFactor = sf, void Function(String)? onChanged}) {
  final xC = TextEditingController(text: initial);
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label, textScaler: TextScaler.linear(scaleFactor)),
        if (label != null) SizedBox(height: 5 * scaleFactor),
        MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(scaleFactor)),
          child: TextFormField(
            validator: validator,
            enabled: enabled,
            controller: xC,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            onChanged: (value) {
              onChanged!(value);
            },
            onTap: () {
              final TextSelection textSelection = TextSelection(baseOffset: 0, extentOffset: xC.text.length);
              xC.selection = textSelection;
            },
            decoration: InputDecoration(
              hintText: hint,
              isDense: true,
              labelStyle: labelstyle,
              filled: true,
              fillColor: Colors.white,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 8 * scaleFactor),
            ),
          ),
        ),
      ],
    ),
  );
}

class BarcodeEditor extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final Function(String)? onCapture;
  final double scaleFactor;
  const BarcodeEditor(this.label, this.controller, {this.scaleFactor = sf, this.onCapture, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, textScaler: TextScaler.linear(scaleFactor)),
          SizedBox(height: 5 * scaleFactor),
          MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(scaleFactor)),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              enableSuggestions: false,
              controller: controller,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              onChanged: onChanged,
              onTap: () {
                final TextSelection textSelection = TextSelection(
                  baseOffset: 0,
                  extentOffset: controller.text.length,
                );
                controller.selection = textSelection;
              },
              decoration: InputDecoration(
                suffix: SizedBox(
                  height: 40 * scaleFactor,
                  child: IconButton(
                    iconSize: 25 * scaleFactor,
                    padding: EdgeInsets.zero,
                    focusNode: AlwaysDisabledFocusNode(),
                    onPressed: () async {
                      var res = await scanBarcode();
                      if (res != null) {
                        onCapture!(res.rawContent.toString());
                        controller.text = res.rawContent.toString();
                      }
                    },
                    icon: Icon(CupertinoIcons.barcode, size: 25 * scaleFactor),
                  ),
                ),
                labelStyle: labelstyle,
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.only(left: 8),
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get canRequestFocus => false;
}

editorangka(BuildContext context, String label, String? initial, {TextEditingController? editingController, bool autoFocus = false, bool enabled = true, double scaleFactor = sf, void Function(String)? onSubmit, void Function(String)? onChanged}) {
  final xC = editingController ?? TextEditingController(text: initial);

  return Padding(
    padding: EdgeInsets.all(8.0 * scaleFactor),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, textScaler: TextScaler.linear(scaleFactor)),
        SizedBox(height: 5 * scaleFactor),
        DropdownButtonHideUnderline(
          child: MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(scaleFactor)),
            child: TextField(
              autofocus: autoFocus,
              enabled: enabled,
              // style: TextStyle(fontSize: 14 * scaleFactor),
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              controller: xC,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              onSubmitted: onSubmit,
              onChanged: onChanged,
              decoration: InputDecoration(
                isDense: true,
                labelStyle: labelstyle,
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 8 * scaleFactor),
              ), // Atur padding),

              onTap: () {
                /* if (dbc.isKeyboardVisible.value) {
                  Future.delayed(Duration.zero, () {
                    final TextSelection textSelection = TextSelection(
                      baseOffset: 0,
                      extentOffset: xC.text.length,
                    );
                    xC.selection = textSelection;
                  });
                } */
              },
            ),
          ),
        ),
      ],
    ),
  );
}

class EditorUangText extends StatefulWidget {
  final double? initial;
  final double? maxValue;
  final String? label;
  final TextEditingController? controller; // Mengubah ini menjadi nullable
  final double scaleFactor;
  final Function(String)? onChanged;

  EditorUangText({
    this.initial,
    this.maxValue,
    this.label,
    TextEditingController? controller, // Parameter constructor
    this.scaleFactor = 1,
    this.onChanged,
    super.key,
  }) : controller = controller ?? TextEditingController(); // Nilai default di sini

  @override
  State<EditorUangText> createState() => _EditorUangTextState();
}

class _EditorUangTextState extends State<EditorUangText> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(widget.scaleFactor)),
      child: TextField(
        textAlign: TextAlign.right,
        keyboardType: TextInputType.number,
        controller: widget.controller,
        // onEditingComplete: () => FocusScope.of(context).nextFocus(),
        onChanged: (value) {
          var _value = formatangka(value.replaceAll('.', ''));
          double inputValue = double.tryParse(value.replaceAll('.', '')) ?? 0;
          if (widget.maxValue != null && inputValue > widget.maxValue!) {
            // Set nilai ke maxValue jika input melebihi maxValue
            widget.controller!.text = formatangka(widget.maxValue!.toString());
            widget.controller!.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller!.text.length));
            if (widget.onChanged != null) {
              var _value = widget.maxValue.toString().replaceAll('.', ',');
              // dp("value jadi: $_value");
              widget.onChanged!(_value);
            }
            setState(() {});
            return; // Keluar dari fungsi jika sudah diperbaiki
          }
          widget.controller!.value = TextEditingValue(
            text: _value,
            selection: TextSelection.collapsed(offset: value.length),
          );
          setState(() {});
          if (widget.onChanged != null) widget.onChanged!(_value);
        },
        decoration: InputDecoration(
          prefix: const Text('Rp.'),
          //labelStyle: labelstyle,
          //filled: true,
          //fillColor: Colors.white,
          border: InputBorder.none,

          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
          //contentPadding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 8 * scaleFactor),
        ),
        onTap: () {
          final TextSelection textSelection = TextSelection(
            baseOffset: 0,
            extentOffset: widget.controller!.text.length,
          );
          widget.controller!.selection = textSelection;
        },
      ),
    );
  }
}

editoruang(BuildContext context, String label, String? initial, {double scaleFactor = sf, void Function(String)? onChanged}) {
  final xC = TextEditingController(text: initial);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, textScaler: TextScaler.linear(scaleFactor)),
      SizedBox(height: 5 * scaleFactor),
      MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(scaleFactor)),
        child: TextField(
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          controller: xC,
          // onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onChanged: (value) {
            var _value = formatangka(value.replaceAll('.', ''));
            xC.value = TextEditingValue(text: _value /* selection: TextSelection.collapsed(offset: value.length) */);
            if (onChanged != null) onChanged(value);
          },
          decoration: InputDecoration(
            prefix: const Text('Rp.'),
          ),
          onTap: () {
            final TextSelection textSelection = TextSelection(
              baseOffset: 0,
              extentOffset: xC.text.length,
            );
            xC.selection = textSelection;
          },
        ),
      ),
      const SizedBox(height: 5),
    ],
  );
}

editoruangtext(BuildContext context, String label, String? initial, {double scaleFactor = sf, void Function(String)? onChanged}) {
  final xC = TextEditingController(text: initial);

  return MediaQuery(
    data: MediaQueryData(textScaler: TextScaler.linear(scaleFactor)),
    child: TextField(
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
      controller: xC,
      // onEditingComplete: () => FocusScope.of(context).nextFocus(),
      onChanged: (value) {
        var _value = formatangka(value.replaceAll('.', ''));
        /* xC.value = TextEditingValue(
          text: _value,
          selection: TextSelection.collapsed(offset: value.length),
        ); */
        if (onChanged != null) onChanged(_value);
      },
      decoration: InputDecoration(
        prefix: const Text('Rp.'),
        //labelStyle: labelstyle,
        //filled: true,
        //fillColor: Colors.white,
        border: InputBorder.none,

        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isDense: true,
        //contentPadding: EdgeInsets.symmetric(horizontal: 8 * scaleFactor, vertical: 8 * scaleFactor),
      ),
      onTap: () {
        final TextSelection textSelection = TextSelection(
          baseOffset: 0,
          extentOffset: xC.text.length,
        );
        xC.selection = textSelection;
      },
    ),
  );
}

PopupMenuItem<int> itemPopup(int index, String caption, IconData icon) => PopupMenuItem<int>(
      value: index,
      child: Row(
        children: <Widget>[
          Icon(icon),
          const SizedBox(width: 8.0),
          Text(caption),
        ],
      ),
    );

class SwitchButtons extends StatelessWidget {
  final Function(bool)? onChanged;
  final bool isSwitched;
  final EdgeInsets padding;
  const SwitchButtons({super.key, this.onChanged, this.isSwitched = false, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey
              // Lebar garis tepi
              ),
        ),
        child: Center(
          child: Switch(
            value: isSwitched,
            onChanged: (v) {
              onChanged!(v);
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ),
      ),
    );
  }
}

class SwitchWidget extends StatefulWidget {
  final Function(bool)? onChanged;
  final bool isSwitched;
  final EdgeInsets padding;
  final String label;
  final double scaleFactor;
  const SwitchWidget({this.scaleFactor = sf, super.key, this.label = '', this.onChanged, this.isSwitched = false, this.padding = EdgeInsets.zero});

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _isSwitched = false;
  @override
  void initState() {
    _isSwitched = widget.isSwitched;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(widget.scaleFactor)),
      child: Padding(
        padding: widget.padding,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.label,
            ),
            Switch(
              value: _isSwitched,
              onChanged: (value) {
                setState(() {
                  _isSwitched = value;
                  widget.onChanged!(value);
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class DatePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const DatePickerWidget({super.key, required this.selectedDate, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (picked != null && picked != selectedDate) {
          onDateChanged(picked);
        }
      },
      child: const Text(
        'Select Date',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}

class DatePickerTextFieldWidget extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final String label;

  DatePickerTextFieldWidget({super.key, this.label = "Periode", required this.selectedDate, required this.onDateChanged});

  final TextEditingController _datePickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _datePickerController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      enableInteractiveSelection: false,
      canRequestFocus: false,
      controller: _datePickerController,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        isCollapsed: true,
        prefixIconConstraints: const BoxConstraints(maxHeight: 50),
        isDense: true,
        contentPadding: const EdgeInsets.all(5),
        border: const OutlineInputBorder(),
        labelText: label,
        prefixIcon: const Icon(Icons.calendar_month_outlined, color: mainColor),
      ),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (picked != null && picked != selectedDate) {
          onDateChanged(picked);
          _datePickerController.text = DateFormat('dd/MM/yyyy').format(picked);
        }
      },
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

Widget angka(double nominal, String sat) => Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text('Rp. ', textScaler: TextScaler.linear(.8)), Align(alignment: Alignment.centerRight, child: Text(formatangka(nominal.toString()), textScaler: const TextScaler.linear(.8))), Text("/$sat", textScaler: const TextScaler.linear(.8))],
      ),
    );
