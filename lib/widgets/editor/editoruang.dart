import 'package:flutter/material.dart';
import 'package:ljm/tools/env.dart';

class EditorUang extends StatefulWidget {
  final double? initial;
  final double? maxValue;
  final String? label;
  final TextEditingController? controller; // Mengubah ini menjadi nullable
  final double scaleFactor;
  final Function(String)? onChanged;
  final bool dense;
  EditorUang({
    this.initial,
    this.maxValue,
    this.label,
    TextEditingController? controller, // Parameter constructor
    this.scaleFactor = 1,
    this.onChanged,
    this.dense = false,
    super.key,
  }) : controller = controller ?? TextEditingController();

  @override
  State<EditorUang> createState() => _EditorUangState();
}

class _EditorUangState extends State<EditorUang> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(textScaler: TextScaler.linear(widget.scaleFactor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) Text(widget.label!, textScaler: TextScaler.linear(widget.scaleFactor)),
          if (widget.label != null) SizedBox(height: 5 * widget.scaleFactor),
          MediaQuery(
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
              decoration: InputDecoration(prefix: const Text('Rp.'), isDense: widget.dense),
              onTap: () {
                final TextSelection textSelection = TextSelection(
                  baseOffset: 0,
                  extentOffset: widget.controller!.text.length,
                );
                widget.controller!.selection = textSelection;
              },
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
