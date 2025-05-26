part of '../page.dart';

Widget _top10(DBSalesController controller, {Axis arah = Axis.horizontal}) {
  return FlutterCarousel(
    options: FlutterCarouselOptions(showIndicator: false, scrollDirection: arah, reverse: true, autoPlay: true, autoPlayInterval: const Duration(seconds: 20), disableCenter: true, viewportFraction: 1.0, height: 400),
    items: <Widget>[
      Container(margin: const EdgeInsets.all(5), height: 200, child: OmsetSales(controller, controller.dechart, touchedGroupIndex: controller.tgIndex.value)),
      Obx(() => _widgetTop10('Top 10 Item', controller.dtop10item)),
      Obx(() => _widgetTop10('Top 10 Customer', controller.dtop10customer)),
      Obx(() => _widgetTop10('Top 10 Wilayah', controller.dtop10kabupaten)),
    ],
  );
}

Widget _widgetTop10(String judul, List<Top10> data) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
    child: Column(
      children: [
        Text(judul, style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(5),
                  height: 25,
                  color: index.isEven ? Colors.white.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data[index].nama!, textScaler: const TextScaler.linear(.8)),
                      Container(alignment: Alignment.centerRight, child: Text(formatangka(data[index].total!.toString()), textScaler: const TextScaler.linear(.8))),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
