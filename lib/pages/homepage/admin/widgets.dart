part of 'page.dart';

_btnTransaksi(DBAdminController controller) {
  btntransTemplate(String label, String nilai, int idx, {String? nilai2, String tooltip = '', String icon = "icons/keranjang-belanja.png"}) {
    return InkWell(
        highlightColor: Colors.green.withValues(alpha: 0.5),
        splashColor: Colors.red.withValues(alpha: 0.5),
        onTap: () async {
          switch (idx) {
            case 1:
              //

              Get.toNamed("/penjualan");
              break;
            case 2:
              Get.toNamed("/pelunasan/piutang");

              break;
            case 3:
              //if (await kirimpesan('s111c', 1208, 'Permintaan Mutasi', channelKey: "Mutasi", payload: {"idpengirim": 1309, "idlokasi": 6, "jenis": "result", "status": "diterima"}) == true) pesanSukses('terkirim');
              if (await kirimpesan('s111c', 1208, "Mutasi", payload: {"idpengirim": 1309.toString(), "idlokasi": 6.toString(), "jenis": "request"}) == true) pesanSukses('terkirim');
              //kirimPesan(1208, 'Permintaan Mutasi', 'inibody', 's111c');
              break;
            case 4:
              Get.toNamed("/piutang");
              break;
            case 5:
              Get.toNamed(iDireksi() ? "/saldokasglobal" : "saldokas");
              // Navigator.push(state.context, MaterialPageRoute(builder: (context) => const SaldoKasPage()));

              break;
            default:
              break;
          }
        },
        child: Card(
            elevation: 0,
            borderOnForeground: false,
            child: ClipPath(
                clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
                child: Container(
                  // padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.grey, width: 1)),
                  ),
                  child: SizedBox(
                      width: (Get.width - 50) / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/$icon", height: 64),
                          Text(label, textScaler: const TextScaler.linear(0.6)),
                          Text(nilai, textScaler: const TextScaler.linear(0.7), style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                          if (nilai2 != null)
                            Tooltip(
                              message: tooltip,
                              child: Text(nilai2, textScaler: const TextScaler.linear(0.6), style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            )
                        ],
                      )),
                ))));
  }

  return SizedBox(
    height: 120,
    child: ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Obx(() => btntransTemplate(
              "Penjualan",
              formatangka((controller.ddashb.value.total).toString()),
              1,
              nilai2: formatangka(controller.ddashb.value.retur.toString()),
              tooltip: 'Penjualan',
              icon: "icons/penjualan.png",
            )),
        Obx(() => btntransTemplate(
              "Pelunasan",
              formatangka(controller.ddashb.value.pelunasan.toString()),
              2,
              nilai2: formatangka(controller.ddashb.value.pn.toString()),
              tooltip: 'Potong Nota',
              icon: "icons/payment.png",
            )),
        Obx(() => btntransTemplate(
              "Poin",
              formatangka(controller.ddashb.value.poin.toString()),
              3,
              nilai2: formatangka(controller.ddashb.value.poinbln.toString()),
              tooltip: 'Poin telah dicairkan',
              icon: "icons/poin2.png",
            )),
        Obx(() => btntransTemplate(
              "Tagihan",
              formatangka(controller.ddashb.value.piutang.toString()),
              4,
              nilai2: formatangka(controller.ddashb.value.top.toString()),
              tooltip: 'Jatuh Tempo',
              icon: "icons/paid.png",
            )),
        Obx(() => btntransTemplate(
              "Kas",
              formatangka(controller.ddashb.value.kas.toString()),
              5,
              icon: "icons/PngItem_1850629.png",
              nilai2: formatangka(controller.ddashb.value.kasglobal.toString()),
            )),
      ],
    ),
  );
}
