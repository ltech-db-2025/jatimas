import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:ljm/tools/env.dart';

bool _isDialog = false;

class MyAutocomplete<T extends Object> extends Autocomplete {
  final Iterable<Object> data;
  final List<String>? fielddicari;
  final void Function(T)? onSelect;
  final AutocompleteOptionsViewBuilder<T>? optionsViewBuild;
  final AutocompleteFieldViewBuilder? fieldViewBuild;
  MyAutocomplete({
    super.key,
    required this.data,
    this.fielddicari,
    this.onSelect,
    super.displayStringForOption = RawAutocomplete.defaultStringForOption,
    this.fieldViewBuild,
    super.optionsMaxHeight = 200.0,
    this.optionsViewBuild,
    super.initialValue,
  }) : super(optionsBuilder: (v) => _optionsBuilder(v, data, fielddicari ?? []));
  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<T>(
      displayStringForOption: displayStringForOption,
      fieldViewBuilder: fieldViewBuild ?? _defaultFieldViewBuilder, // fieldViewBuilder,
      initialValue: initialValue,
      optionsBuilder: optionBuilder5,
      optionsViewBuilder: optionsViewBuild ?? _optionsViewBuild,
      onSelected: onSelect ?? onSelected,
    );
  }

  Widget _optionsViewBuild(BuildContext context, AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
    //dp(instanceof(T, Object) ? 'yessss' : 'T is ${T.runtimeType.toString()}');
    return _AutocompleteOptions<T>(
      displayStringForOption: displayStringForOption,
      onSelected: onSelected,
      options: options,
      maxOptionsHeight: optionsMaxHeight,
    );
  }

  FutureOr<Iterable<T>> optionBuilder5(TextEditingValue val) async {
    return await _optionsBuilder5(val, data as Iterable<T>);
  }

  FutureOr<Iterable<T>> _optionsBuilder5(TextEditingValue val, Iterable<T>? data) async {
    if (val.text == '' || _isDialog) return const Iterable.empty();
    final Iterable<T> x = tryCast(await filterData(val.text, data! as Iterable<Object>, fielddicari ?? []), []);
    if (x.length == 1) {
      if (x.first.toString() == val.text) return const Iterable.empty();
    }
    return x;
  }

  Widget _defaultFieldViewBuilder(BuildContext context, TextEditingController textEditingController, FocusNode focusNode, void Function() onFieldSubmitted) {
    // dp('_defaultFieldViewBuilder: ${data.length}}');
    return DefaultViewBuilder<T>(
      dataList: data,
      options: data as Iterable<T>,
      onFieldSubmitted: onFieldSubmitted,
      optionsViewBuild: optionsViewBuild ?? _optionsViewBuild,
      onSelect: onSelect!,
      displayStringForOption: displayStringForOption,
      maxOptionsHeight: optionsMaxHeight,
      textEditingController: textEditingController,
      focusNode: focusNode,
    );
  }
}

class DefaultViewBuilder<T extends Object> extends StatelessWidget {
  final AutocompleteOptionsViewBuilder<T> optionsViewBuild;
  final void Function(T) onSelect;
  final AutocompleteOptionToString<T> displayStringForOption;
  final Iterable<T> options;
  final double maxOptionsHeight;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final VoidCallback onFieldSubmitted;
  final List<String>? fielddicari;
  final Iterable<Object> dataList;

  const DefaultViewBuilder({
    this.fielddicari,
    required this.dataList,
    required this.optionsViewBuild,
    required this.onSelect,
    required this.displayStringForOption,
    required this.options,
    required this.maxOptionsHeight,
    required this.textEditingController,
    required this.focusNode,
    required this.onFieldSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _AutocompleteField(
      dataList: dataList,
      fielddicari: fielddicari,
      optionsViewBuild: optionsViewBuild,
      displayStringForOption: displayStringForOption,
      onSelected: onSelect,
      options: options,
      maxOptionsHeight: maxOptionsHeight,
      focusNode: focusNode,
      textEditingController: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}

class _AutocompleteField<T extends Object> extends StatelessWidget {
  final AutocompleteOptionsViewBuilder<T> optionsViewBuild;
  final AutocompleteOptionToString<T> displayStringForOption;
  final AutocompleteOnSelected<T> onSelected;
  final Iterable<T> options;
  final Iterable<Object> dataList;
  final double? maxOptionsHeight;
  final FocusNode focusNode;
  final VoidCallback onFieldSubmitted;
  final TextEditingController textEditingController;
  final List<String>? fielddicari;
  const _AutocompleteField({
    super.key,
    required this.dataList,
    this.fielddicari,
    required this.optionsViewBuild,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
    required this.maxOptionsHeight,
    required this.focusNode,
    required this.textEditingController,
    required this.onFieldSubmitted,
  });

  Future<void> _cek(BuildContext context) async {
    _isDialog = true;
    final result = await showDialog(
      context: context,
      builder: (context) => _MyDataDialogs(
        //dataList: dataList,
        fielddicari: fielddicari,
        onFieldSubmitted: onFieldSubmitted,
        //textEditingController: textEditingController,
        // mainContext: context,
        optionsViewBuild: optionsViewBuild,
        displayStringForOption: displayStringForOption,
        onSelected: onSelected,
        options: options,
        maxOptionsHeight: maxOptionsHeight!,
      ),
    );
    if (result != null) {
      textEditingController.text = result.toString();
      // ignore: prefer_null_aware_method_calls
      onSelected(result as T);
      onFieldSubmitted();
    }
    _isDialog = false;
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.f1): () {
          _cek(context);
        }
      },
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_drop_down),
            onPressed: () => _cek(context),
          ),
        ),
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
      ),
    );
  }
}

// The default Material-style Autocomplete options.
class _MyDataDialogs<T extends Object> extends StatefulWidget {
  final AutocompleteOptionsViewBuilder<T> optionsViewBuild;
//  final BuildContext mainContext;
  final AutocompleteOptionToString<T> displayStringForOption;
  final AutocompleteOnSelected<T> onSelected;
  final Iterable<T> options;
//  final Iterable<Object> dataList;
  final double maxOptionsHeight;
//  final TextEditingController textEditingController;
  final VoidCallback onFieldSubmitted;
  final List<String>? fielddicari;
  const _MyDataDialogs({
    super.key,
    this.fielddicari,
    // required this.dataList,
    required this.onFieldSubmitted,
//    required this.textEditingController,
//    required this.mainContext,
    required this.optionsViewBuild,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
    required this.maxOptionsHeight,
  });

  @override
  State<_MyDataDialogs> createState() => _MyDataDiagolsState<T>();
}

class _MyDataDiagolsState<T extends Object> extends State<_MyDataDialogs<T>> {
  Iterable<T>? options;

  final TextEditingController _textEditingController = TextEditingController();
  AutocompleteOptionsViewBuilder<T>? optionsViewBuild;
  Timer? _debounce;
  @override
  void initState() {
    isLoading = true;
    optionsViewBuild = widget.optionsViewBuild;
    initData();
    super.initState();
  }

  @override
  dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> initData() async {
    options = widget.options;
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _onCari(String v) async {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      // Lakukan aksi pencarian di sini (contoh: tampilkan hasil di konsol)
      options = (v.trim() == '') ? widget.options : tryCast(await filterData(v, widget.options as Iterable<Object>, widget.fielddicari ?? []), <T>[]);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? showloading()
          : Center(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CallbackShortcuts(
                        bindings: {
                          const SingleActivator(LogicalKeyboardKey.arrowDown): () {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        child: TextFormField(
                          onFieldSubmitted: (x) => widget.onFieldSubmitted(),
                          autofocus: true,
                          controller: _textEditingController,
                          onChanged: _onCari,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(color: Colors.lightGreen, width: 2.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: optionsViewBuild!(
                        context,
                        (v) => Navigator.pop(context, v),
                        options!,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 120,
                        height: 40,
                        child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text('Batal'), Icon(Icons.cancel)])),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class _AutocompleteOptions<T extends Object> extends StatelessWidget {
  const _AutocompleteOptions({
    super.key,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
    required this.maxOptionsHeight,
  });

  final AutocompleteOptionToString<T> displayStringForOption;
  final AutocompleteOnSelected<T> onSelected;
  final Iterable<T> options;
  final double maxOptionsHeight;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4.0,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxOptionsHeight),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: Builder(
                  builder: (BuildContext context) {
                    final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                    if (highlight) {
                      SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
                        Scrollable.ensureVisible(context, alignment: 0.5);
                      });
                    }
                    return Container(
                      color: highlight ? Theme.of(context).focusColor : null,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(displayStringForOption(option)),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

FutureOr<Iterable<Object>> _optionsBuilder(TextEditingValue val, Iterable<Object>? data, List<String> fielddicari) async {
  return const Iterable.empty();
}
