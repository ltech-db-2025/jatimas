import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/tools/env.dart';

import 'widget/tab_view_1.dart';
import 'widget/tab_view_2.dart';

class DetailPelanggan extends StatefulWidget {
  final String judul;
  final KONTAK? kontak;
  const DetailPelanggan({super.key, required this.judul, this.kontak});

  @override
  State<DetailPelanggan> createState() => _DetailPelangganState();
}

class _DetailPelangganState extends State<DetailPelanggan> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  KONTAK data = KONTAK();
  @override
  void initState() {
    if (widget.kontak == null) {
      Get.back();
      showErrorDlg('Data Kontak tidak ditemukan');
    }
    data = widget.kontak!.copyWith();
    initData();
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  initData() async {
    var sql = '';

    sql = """
SELECT 
    k.id, 
    k.kode, 
    k.nama, 
    k.alamat, 
    k.desa, 
    k.kecamatan, 
    k.kabupaten, 
    k.provinsi, 
    k.telp,
    pi.jml, 
    pi.piutang, 
    pi.saldoawal, 
    pj.total AS plafon, 
    pj.ratarata, 
    pj.transaksiterakir AS updated
FROM 
    kontak k
LEFT JOIN (
    SELECT 
        idkontak,  
        DATEDIFF(CURRENT_DATE, MIN(tanggal)) AS saldoawal,  
        COUNT(*) AS jml, 
        SUM(saldo) AS piutang 
    FROM 
        transaksi 
    WHERE 
        idkontak = ${widget.kontak!.id}  AND coalesce(saldo,0)>0
    GROUP BY 
        idkontak
) pi ON pi.idkontak = k.id
LEFT JOIN (
    SELECT 
        p.idkontak,
        SUM(CASE WHEN (p.bulan = DATE_FORMAT(CURRENT_DATE, '%Y-%m-01') 
                       AND p.tahun = DATE_FORMAT(CURRENT_DATE, '%Y-01-01')) 
                 THEN perbulan END) AS total, 
        AVG(bulanan_avg) AS ratarata,
        MAX(bulanan_tanggalakhir) AS transaksiterakir
    FROM (
        SELECT 
            idkontak, 
            DATE_FORMAT(tanggal, '%Y-01-01') AS tahun,  
            DATE_FORMAT(tanggal, '%Y-%m-01') AS bulan,  
            MAX(tanggal) AS bulanan_tanggalakhir,
            AVG(nilaitotal) AS bulanan_avg,
            SUM(nilaitotal) AS perbulan
        FROM 
            transaksi 
        WHERE 
            kdtrans = 'PJ' AND idkontak = ${widget.kontak!.id}  	
        GROUP BY 
            idkontak, tahun, bulan
    ) p 
    WHERE 
        p.idkontak = ${widget.kontak!.id}  
    GROUP BY 
        p.idkontak
) pj ON pj.idkontak = k.id
WHERE 
    k.id = ${widget.kontak!.id};
    """;
    final newItems = await executeSql(sql);
    if (newItems.isNotEmpty) {
      data = KONTAK.fromMap(newItems.first);
      setState(() {});
    } else {
      Get.back();
    }
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        indicatorColor: Color(0xFF00b3b0),
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        labelColor: Color(0xFF00b3b0),
        unselectedLabelColor: Colors.grey,
        labelPadding: const EdgeInsets.only(left: 0.0, right: 0.0),

        // indicator: const BoxDecoration(
        //   borderRadius: BorderRadius.only(topLeft: (Radius.circular(0)), topRight: (Radius.circular(20)), bottomLeft: (Radius.circular(20))),
        //   color: Color(0xFF00b3b0), // Warna kuning untuk tab yang terpilih
        // ),
        tabs: [
          Container(
            height: 50,
            color: Colors.transparent,
            width: double.infinity,
            child: const Center(child: Text('Rincian')),
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            child: const Center(child: Text('Piutang')),
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            child: const Center(child: Text('Pembayaran')),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 50), // Sesuaikan tinggi AppBar sesuai kebutuhan
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(widget.judul, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),

          elevation: 0, // Hilangkan shadow AppBar
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: ColoredBox(
              color: Colors.white,
              child: _tabBar,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Fungsi untuk menutup modal
                            },
                            child: const Icon(Icons.cancel),
                          ),
                          title: const CustomTextStandard(
                            text: 'Lainnya',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        const ListTile(
                          leading: Icon(Icons.edit_document),
                          title: CustomTextStandard(text: 'Ubah'),
                        ),
                        const ListTile(
                          leading: Icon(Icons.delete_outlined),
                          title: CustomTextStandard(text: 'Hapus'),
                        ),
                        const ListTile(
                          leading: Icon(Icons.touch_app_outlined),
                          title: CustomTextStandard(text: 'Non Aktifkan'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [TabView1(data), TabView2(data), TabView1(data)],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
