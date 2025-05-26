import 'package:flutter/material.dart';
import 'package:ljm/tools/env.dart';

class PlusMinusButtons extends StatefulWidget {
  final double size;
  final VoidCallback? min;
  final VoidCallback? add;
  final Function(String)? onmanual;
  final double nilai;
  final EdgeInsets padding;
  final Color? textColor;
  final bool readOnly;
  final double width;
  final bool internalminAdd;

  const PlusMinusButtons({
    super.key,
    this.readOnly = false,
    this.width = double.infinity,
    this.textColor,
    this.size = 1,
    required this.add,
    required this.min,
    this.onmanual,
    required this.nilai,
    this.padding = EdgeInsets.zero,
    this.internalminAdd = true,
  });

  @override
  State<PlusMinusButtons> createState() => _PlusMinusButtonsState();
}

class _PlusMinusButtonsState extends State<PlusMinusButtons> {
  double _n = 0;
  double iSize = 20.0;

  bool isReady = false;
  TextEditingController inputController = TextEditingController();
  @override
  void initState() {
    _n = widget.nilai;
    inputController.text = formatangka(_n);
    inputController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: inputController.text.length,
    );
    _initdata();
    super.initState();
  }

  _initdata() async {
    isReady = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return !isReady
        ? showloading()
        : Container(
            padding: widget.padding,
            height: 30 * widget.size,
            width: widget.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (_n <= 0)
                        ? null
                        : () {
                            if (widget.min != null) widget.min!();
                            if (widget.internalminAdd) {
                              setState(() {
                                _n--;
                                inputController.text = _n.toString();
                              });
                            }
                          },
                    icon: Icon(
                      Icons.remove_circle,
                      size: (iSize * widget.size),
                      color: (_n <= 0) ? Colors.grey : Colors.red,
                    )),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    readOnly: widget.readOnly,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: widget.textColor ?? Colors.black, fontSize: 14 * widget.size),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 4 * widget.size),
                    ),
                    controller: inputController,
                    onChanged: (value) {
                      if (widget.onmanual != null) widget.onmanual!(value);
                      _n = double.tryParse(value) ?? 0;
                    },
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (widget.min != null) widget.add!();
                    if (widget.internalminAdd) {
                      setState(() {
                        _n++;
                        // if (widget.onmanual != null) widget.onmanual!(_n.toString());
                        inputController.text = _n.toString();
                      });
                    }
                  },
                  icon: Icon(Icons.add_circle, size: (iSize * widget.size)),
                  color: Colors.green,
                ),
              ],
            ),
          );
  }
}
