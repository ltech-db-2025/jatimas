import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/widgets/customtext.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/provider/models/transaksi/transaksi.dart';
import 'package:ljm/tools/env.dart';

class RincianPembayaran extends StatefulWidget {
  final TRANSAKSI data;

  const RincianPembayaran(this.data, {super.key});

  @override
  State<RincianPembayaran> createState() => _RincianPembayaranState();
}

class _RincianPembayaranState extends State<RincianPembayaran> {
  TRANSAKSI data = TRANSAKSI();
  @override
  void initState() {
    data = widget.data;
    data.detailkas ??= [];
    initData();
    super.initState();
  }

  initData() async {
    var sql = '';

    sql = """
    SELECT 
    p.id, p.nobukti, p.tanggal, p.idkontak, 
    p.pegawai, 
    p.operator, 
    p.kontak, 
    p.namakontak, 
    p.rek_kas, 
    r.akun AS akunkas, 
    p.nilaitotal,
    p.operator AS dibuat,
     concat('[',(
        SELECT 
            GROUP_CONCAT(
                CONCAT('{"id": "', d.refidtrans, '", "refnotrans": "', pj.notrans, '", "tanggal": "', pj.tanggal, '", "rek": "', d.rek, '", "nilai": "', d.nilai, '"}')
                ORDER BY d.refidtrans
                SEPARATOR ','
            )
        FROM 
            kas d 
        LEFT JOIN 
            transaksi pj ON pj.id = d.refidtrans
        WHERE 
            d.idtrans = p.id
    ),']') AS detailkas
FROM 
    transaksi p 
    left join    rekening r ON r.kode = p.rek_kas
    
where p.id = ${widget.data.id}

      """;
    var res = await executeSql(sql);

    if (res.isNotEmpty) {
      data = TRANSAKSI.fromMap(res.first);
      setState(() {});
    } else {
      Get.back();
      showErrorDlg('Data tidak ditemukan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextStandard(
          text: 'Rincian Pembayaran',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                showDragHandle: true,
                backgroundColor: Colors.white,
                context: context,
                builder: (BuildContext context) {
                  return Wrap(
                    children: [
                      ListTile(
                        leading: GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.cancel)),
                        title: const CustomTextStandard(text: 'Lainnya', fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.print),
                        title: const Text('Cetak'),
                        onTap: () {
                          // Implementasi untuk mencetak
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.chat),
                        title: const Text('WhatsApp'),
                        onTap: () {
                          // Implementasi untuk berbagi ke WhatsApp
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.share),
                        title: const Text('Bagikan'),
                        onTap: () {
                          // Implementasi untuk berbagi
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Ubah'),
                        onTap: () {
                          // Implementasi untuk mengubah
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Hapus'),
                        onTap: () {
                          // Implementasi untuk menghapus
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 40, // Sesuaikan dengan ukuran yang Anda inginkan
                backgroundColor: Colors.grey, // Atur warna latar belakang sesuai kebutuhan
                child: Icon(
                  Icons.person,
                  size: 60, // Sesuaikan dengan ukuran ikon yang Anda inginkan
                  color: Colors.white, // Atur warna ikon sesuai kebutuhan
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(8.0), child: CustomTextStandard(text: data.kontak ?? '', fontSize: 14, fontWeight: FontWeight.bold)),
            Padding(padding: const EdgeInsets.all(8.0), child: CustomTextStandard(text: data.kontak ?? '', color: Colors.grey)),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(child: CustomTextStandard(text: 'Nomor Pembayaran', color: Colors.grey)),
                  Expanded(child: CustomTextStandard(text: ': ${data.id}')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(child: CustomTextStandard(text: 'Tanggal Transaksi', color: Colors.grey)),
                  Expanded(child: CustomTextStandard(text: ': ${formattanggal(data.tanggal)}')),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: CustomTextStandard(text: 'Metode Pembayaran', color: Colors.grey)),
                  Expanded(child: CustomTextStandard(text: ': Tunai/Lainnya')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(child: CustomTextStandard(text: 'Akun Kas', color: Colors.grey)),
                  Expanded(child: CustomTextStandard(text: ': ${data.akunkas}')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(child: CustomTextStandard(text: 'Jumlah Pembayaran', color: Colors.grey)),
                  Expanded(child: CustomTextStandard(text: ': ${formatuang(data.nilaitotal)}', fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(child: CustomTextStandard(text: 'Dibuat Oleh', color: Colors.grey)),
                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              showDragHandle: true,
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      title: const CustomTextStandard(text: 'Dibuat Oleh', fontSize: 16, fontWeight: FontWeight.bold),
                                      trailing: GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.cancel)),
                                    ),
                                    const Divider(),
                                    ListTile(
                                      title: const CustomTextStandard(text: 'Nama Pengguna', color: Colors.grey),
                                      trailing: CustomTextStandard(text: data.operator ?? ''),
                                    ),
                                    ListTile(
                                      title: const CustomTextStandard(text: 'Tanggal', color: Colors.grey),
                                      trailing: CustomTextStandard(text: formattanggal(data.created, 'EEEE, dd MMMM yyyy HH:mm')),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: CustomTextStandard(text: ': ${data.pegawai ?? ''}', color: Colors.red))),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    backgroundColor: Colors.white,
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
                              text: 'Lampiran',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(),
                          const ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: CustomTextStandard(text: 'Camera'),
                          ),
                          const ListTile(
                            leading: Icon(Icons.image_outlined),
                            title: CustomTextStandard(text: 'Galeri'),
                          ),
                          const ListTile(
                            leading: Icon(Icons.note),
                            title: CustomTextStandard(text: 'Dokumen'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Row(
                  children: [Icon(Icons.attachment_outlined), CustomTextStandard(text: ' + Lampiran', fontSize: 14, color: Colors.red)],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomTextStandard(text: '${data.detailkas!.length} Invoice', fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(padding: EdgeInsets.all(8.0), child: Divider()),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.detailkas!.length,
              itemBuilder: (context, index) {
                final detail = data.detailkas![index];
                return ListTile(
                  title: CustomTextStandard(text: detail.refnotrans.toString(), fontSize: 14),
                  subtitle: CustomTextStandard(text: formattanggal(detail.tanggal, 'EEEE, dd MMMM yyyy HH:mm'), fontSize: 12, color: Colors.grey),
                  trailing: CustomTextStandard(text: formatuang(detail.nilai), fontSize: 14),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
