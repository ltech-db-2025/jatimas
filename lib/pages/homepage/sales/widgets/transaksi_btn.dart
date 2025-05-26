part of '../page.dart';

class LoadingbtnTrans extends StatelessWidget {
  const LoadingbtnTrans({super.key});

  @override
  Widget build(BuildContext context) {
    int time = 800;
    return Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey[300]!,
        period: Duration(milliseconds: time),
        child: SizedBox(
            height: 70,
            child: ListView(
                // This next line does the trick.
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  isi(),
                  isi(),
                  isi(),
                ])));
  }

  isi() {
    double containerWidth = 280;
    double containerHeight = 20;
    return Card(
        borderOnForeground: false,
        child: ClipPath(
            clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey, width: 2),
                ),
              ),
              child: SizedBox(
                  width: (Get.width - 100) / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: containerHeight, width: containerWidth * 0.15, color: Colors.grey),
                      Container(height: containerHeight, width: containerWidth * 0.15, color: Colors.grey),
                      Container(height: containerHeight, width: containerWidth * 0.15, color: Colors.grey),
                    ],
                  )),
            )));
  }
}
