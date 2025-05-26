part of 'env.dart';

class MyAutoSizeText extends AutoSizeText {
  const MyAutoSizeText(
    super.data, {
    super.key,
    super.textKey,
    super.style,
    super.strutStyle,
    super.textScaleFactor = skala,
    super.minFontSize = 8,
    super.maxFontSize = double.infinity,
    super.stepGranularity = 1,
    super.presetFontSizes,
    super.group,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.wrapWords = true,
    super.overflow,
    super.overflowReplacement,
    super.maxLines = 1,
    super.semanticsLabel,
  });
}

Widget hKolom(String label, double lbr, double x, {double sf = 1}) {
  return Container(alignment: Alignment(x, 0), width: lbr, child: MyAutoSizeText(label));
}

Widget kolom(String label, double lbr, double x, {double sf = 1, TextStyle st = defst}) {
  return Container(
      alignment: Alignment(x, 0),
      width: lbr,
      child: MyAutoSizeText(
        label,
        maxLines: 1,
        style: st,
      ));
}

button({Text? text, Icon? icon, onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: (icon != null) ? Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[text!, icon]) : text,
  );
}

class LoadingList extends StatelessWidget {
  final Widget? child;
  const LoadingList({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        offset += 5;
        time = 800 + offset;
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Colors.grey[300]!,
              period: Duration(milliseconds: time),
              child: child ?? _list(),
            ));
      },
    );
  }
}

double containerWidth = 280;
double containerHeight = 20;

_list() => Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      child: Card(
        color: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(height: containerHeight, width: containerWidth * 0.10, color: Colors.grey),
            const SizedBox(height: 5),
            Container(height: containerHeight, width: containerWidth * 0.15, color: Colors.grey),
          ]),
          title: Container(),
          /*  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Align(alignment: Alignment.centerLeft, child: Container(height: containerHeight, width: containerWidth * 0.50, color: Colors.grey)),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: containerHeight, width: containerWidth * 0.3, color: Colors.grey),
                Container(height: containerHeight, width: containerWidth * 0.3, color: Colors.grey),
              ],
            ),
          ]), */
          trailing: Container(height: containerHeight, width: containerWidth * 0.2, color: Colors.grey),
        ),
      ),
    );

baris(String label, String nilai, [TextStyle style = const TextStyle()]) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 55, child: MyAutoSizeText(label)),
      const SizedBox(width: 5, child: MyAutoSizeText(': ')),
      SizedBox(
          width: 90,
          child: Align(
            alignment: Alignment.centerRight,
            child: MyAutoSizeText(
              nilai,
              style: style,
            ),
          )),
    ],
  );
}

// ------------------------------------------------
tombol(Text text, Icon icon, onPressed) {
  return TextButton(
    onPressed: () => {onPressed()},
    child: Column(
      mainAxisSize: MainAxisSize.min,
      // Replace with a Row for horizontal icon + text
      children: <Widget>[icon, const Text(''), text],
    ),
  );
}

class TombolMenu extends StatelessWidget {
  final String judulx;
  final Widget child;
  const TombolMenu(this.judulx, this.child, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(children: [child, const SizedBox(width: 12), Text(judulx, textScaler: const TextScaler.linear(skala))]);
  }
}

tombol3(Text text, Icon icon, onPressed) {
  return TextButton(
    onPressed: () => {onPressed()},
    child: Row(
      mainAxisSize: MainAxisSize.min,
      // Replace with a Row for horizontal icon + text
      children: <Widget>[icon, const Text(''), text],
    ),
  );
}

tombol4(Text text, Icon icon, onPressed) {
  return ElevatedButton(
      onPressed: () => onPressed(),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        icon,
        const Text(''),
        text,
      ]));
}

tombol5(Text text, Icon icon, void onPressed) {
  return ElevatedButton(
      onPressed: () => onPressed,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        icon,
        const Text(''),
        text,
      ]));
}
