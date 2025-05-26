import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ljm/tools/env.dart';

enum CustomTextFieldFloatingLabelBehavior {
  auto,
  always,
  never,
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool enabled;
  final bool? readOnly;
  final CustomTextFieldFloatingLabelBehavior floatingLabelBehavior;
  final Color? labelColor;
  final TextAlign textAlign;
  final int? maxlines;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly,
    this.floatingLabelBehavior = CustomTextFieldFloatingLabelBehavior.auto,
    this.labelColor,
    this.textAlign = TextAlign.left,
    this.maxlines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
            enabled: enabled,
            obscureText: isPassword,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            textAlign: textAlign,
            readOnly: readOnly ?? false,
            maxLines: maxlines,
            style: GoogleFonts.poppins(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              labelText: label,
              hintText: hint,
              floatingLabelBehavior: _getFloatingLabelBehavior(),
              labelStyle: GoogleFonts.poppins(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: labelColor ?? Colors.grey, // Use labelColor or default to grey
              ),
              prefixIcon: prefixIcon != null
                  ? Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      child: Icon(
                        prefixIcon,
                        size: 20,
                      ),
                    )
                  : null,
              //suffixIconConstraints: const BoxConstraints(maxHeight: 14),
              suffixIcon: suffixIcon != null
                  ? Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      child: Icon(
                        suffixIcon,
                        color: Tema().background,
                        size: 20,
                      ),
                    )
                  : null,
              // border: const UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  FloatingLabelBehavior _getFloatingLabelBehavior() {
    switch (floatingLabelBehavior) {
      case CustomTextFieldFloatingLabelBehavior.always:
        return FloatingLabelBehavior.always;
      case CustomTextFieldFloatingLabelBehavior.never:
        return FloatingLabelBehavior.never;
      case CustomTextFieldFloatingLabelBehavior.auto:
        return FloatingLabelBehavior.auto;
    }
  }
}

class TextInputUang extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? ktype;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  const TextInputUang({
    super.key,
    required this.controller,
    required this.label,
    this.ktype,
    this.inputFormatters,
    this.onChanged,
  });

  State<TextInputUang> createState() => TextInputUangState();
}

class TextInputUangState extends State<TextInputUang> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Menambahkan listener untuk focusNode
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Ketika TextField mendapatkan fokus, kita pilih seluruh teks
        widget.controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: widget.controller.text.length,
        );
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Jangan lupa untuk membuang focusNode
    super.dispose();
  }

  void _onChanged(String value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        focusNode: _focusNode,
        controller: widget.controller,
        keyboardType: widget.ktype ?? TextInputType.text,
        onChanged: _onChanged,
        inputFormatters: widget.inputFormatters ?? [],
        decoration: InputDecoration(
          isDense: true,
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.normal, color: warnaLabel),
        ),
        style: GoogleFonts.poppins(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
    );
  }
}

// Custom InputFormatter untuk menambahkan "Rp" di depan dan format angka
class _RpInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    // Menyimpan posisi kursor sebelum memformat

    // Jika input pertama kali kosong, lanjutkan tanpa mengubahnya
    if (newText.isEmpty) return newValue;

    // Menghapus karakter selain angka dan koma
    newText = newText.replaceAll(RegExp(r'[^0-9,]'), '');

    // Memisahkan bagian integer dan desimal (jika ada)
    List<String> parts = newText.split(',');

    // Format bagian integer dengan titik sebagai pemisah ribuan
    if (parts.isNotEmpty) {
      parts[0] = _formatRibuan(parts[0]);
    }

    // Menyusun kembali bagian integer dan desimal
    newText = parts.join(',');

    // Mengembalikan hasil dengan menambahkan "Rp" di depan
    final newTextValue = 'Rp $newText';

    // Mengembalikan TextEditingValue dengan posisi kursor di akhir
    return TextEditingValue(
      text: newTextValue,
      selection: TextSelection.collapsed(offset: newTextValue.length),
    );
  }

  // Fungsi untuk menambahkan titik sebagai pemisah ribuan
  String _formatRibuan(String text) {
    // Menghapus semua titik yang ada untuk format baru
    String cleanedText = text.replaceAll('.', '');

    // Memformat angka menjadi ribuan dengan titik setiap 3 digit
    String formattedText = cleanedText.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );

    return formattedText;
  }
}

Widget inputHargaBeli({
  required TextEditingController controller,
  required String label,
  Function(String)? onChanged,
}) {
  return TextInputUang(
    controller: controller,
    label: label,
    ktype: TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      _RpInputFormatter(),
    ],
    onChanged: onChanged,
  );
}

Widget inputHargaSales({
  required TextEditingController controller,
  required String label,
  Function(String)? onChanged,
}) {
  return TextInputUang(
    controller: controller,
    label: label,
    ktype: TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      _RpInputFormatter(),
    ],
    onChanged: onChanged,
  );
}

Widget inputHargaSpesial({
  required TextEditingController controller,
  required String label,
  Function(String)? onChanged,
}) {
  return TextInputUang(
    controller: controller,
    label: label,
    ktype: TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      _RpInputFormatter(),
    ],
    onChanged: onChanged,
  );
}

Widget inputHargaPartai({
  required TextEditingController controller,
  required String label,
  Function(String)? onChanged,
}) {
  return TextInputUang(
    controller: controller,
    label: label,
    ktype: TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      _RpInputFormatter(),
    ],
    onChanged: onChanged,
  );
}

Widget inputHargaEceran({
  required TextEditingController controller,
  required String label,
  Function(String)? onChanged,
}) {
  return TextInputUang(
    controller: controller,
    label: label,
    ktype: TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      _RpInputFormatter(),
    ],
    onChanged: onChanged,
  );
}

Widget inputAngka({
  required TextEditingController controller,
  required String label,
  Function(String)? onChanged,
}) {
  return TextInputUang(
    controller: controller,
    label: label,
    ktype: TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
    ],
    onChanged: onChanged,
  );
}
