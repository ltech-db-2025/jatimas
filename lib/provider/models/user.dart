// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:ljm/provider/models/kontak.dart';
import 'package:ljm/provider/models/users/akseskas.dart';
import 'package:ljm/provider/models/users/akseslokasi.dart';
import 'package:ljm/tools/env.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

String _urlGambar = "user/img/";
String _namatabel = 'user';
String _namaview = 'user';
String _urlRaw = 'perusahaan/user/index.php';
String _urlUpdate = 'perusahaan/user/update.php';
String _urlHapus = 'perusahaan/user/hapus.php';
String _caption = 'Daftar User';

class User {
  int? idkontak;
  int? idlokasi;
  String? nama;
  String? email;
  String? imageurl;
  List<AksesLokasi>? akseslokasi;
  List<AksesKas>? akseskas;
  KONTAK? kontak;
  int tipe;
  String? gambar;
  String? fileGambar;
  String? fileThumb;

  User({this.idkontak, this.idlokasi, this.nama, this.email, this.imageurl, this.tipe = 0, this.akseslokasi, this.akseskas, this.kontak, this.gambar, this.fileGambar, this.fileThumb});
  @override
  String toString() {
    return 'User(idkontak: $idkontak, idlokasi: $idlokasi, nama: $nama, email: $email,  imageurl: $imageurl, tipe: $tipe, kontak:$kontak, akseslokasi: $akseslokasi, akseskas: $akseskas)';
  }

  static Future<User?> byID(String? email) async {
    return null;
  }

  factory User.fromMap(Map<String, dynamic> data) {
    var akseskasData = data['akseskas'];

    List<AksesKas>? _akseskas = (akseskasData == null)
        ? null
        : (akseskasData is String ? (json.decode(akseskasData) as List<dynamic>) : akseskasData as List<dynamic>).map((e) {
            if (e is String) {
              return AksesKas.fromJson(e);
            } else if (e is Map<String, dynamic>) {
              return AksesKas.fromMap(e);
            } else {
              dp("e.runtimeType: ${e.runtimeType}");
              throw Exception('Invalid format in akseskas: $e');
            }
          }).toList();
    var akseslokasiData = data['akseslokasi'];
    List<AksesLokasi>? _akseslokasi = (akseslokasiData == null)
        ? null
        : (akseslokasiData is String ? (json.decode(akseslokasiData) as List<dynamic>) : akseslokasiData as List<dynamic>).map((e) {
            if (e is String) {
              return AksesLokasi.fromJson(e);
            } else if (e is Map<String, dynamic>) {
              return AksesLokasi.fromMap(e);
            } else {
              dp("e.runtimeType: ${e.runtimeType}");
              throw Exception('Invalid format in akseslokasi: $e');
            }
          }).toList();

    //List<AksesLokasi>? _akseslokasi = (akseslokasiData == null) ? null : (akseslokasiData is String ? (json.decode(akseslokasiData) as List<dynamic>) : akseslokasiData as List<dynamic>).map((e) => AksesLokasi.fromMap(e as Map<String, dynamic>)).toList();
    return User(
      idkontak: int.tryParse(data['idkontak'].toString()),
      idlokasi: int.tryParse(data['idlokasi'].toString()),
      nama: makeStr(data['nama']),
      email: makeStr(data['email']),
      imageurl: makeStr(data['imageurl']),
      tipe: int.tryParse(data['tipe'].toString()) ?? -1,
      kontak: (data['kontak'] != null) ? KONTAK.fromJson(data['kontak']) : null,
      akseslokasi: _akseslokasi,
      akseskas: _akseskas,
    );
  }

  Map<String, dynamic> toMap() => {
        'idkontak': idkontak,
        'idlokasi': idlokasi,
        'nama': nama,
        'email': email,
        'imageurl': imageurl,
        'tipe': tipe,
        'kontak': kontak,
        'akseslokasi': akseslokasi,
        'akseskas': akseskas,
        'fileGambar': (gambar != null && gambar != "null") ? "$homepageimg$_urlGambar$gambar" : null,
        'fileThumb': (gambar != null && gambar != "null") ? "$homepageimg$_urlGambar${imagetoThumbs(gambar ?? '')}" : null,
      };
  Map<String, dynamic> toPost() => {
        'idkontak': idkontak.toString(),
        'idlokasi': idlokasi.toString(),
        'nama': nama.toString(),
        'email': email.toString(),
        'imageurl': imageurl.toString(),
        'tipe': tipe.toString(),
      };
  factory User.fromJson(String data) {
    return User.fromMap(jsonDecode(data) as Map<String, dynamic>);
  }
  String toJson() => json.encode(toMap());
  String getTableName() => _namatabel;
  String getViewName() => _namaview;
  String getUrlRaw() => _urlRaw;
  String getUrlSimpan() => _urlUpdate;
  String getCaption() => _caption;
  String getUrlHapus() => _urlHapus;
  String getWhere() => 'email=$email';
  Map<String, dynamic> keyMap() => {'email': email.toString()};

  Future simpanGambar(File file) async {
    var url = '$homepageimg${_urlGambar}update.php';
    try {
      var uri = Uri.parse(url);
      var stream = http.ByteStream(DelegatingStream(file.openRead()));
      var length = await file.length();
      var mt = await getMimeType(file);
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile(
        "gbr",
        stream,
        length,
        filename: basename(file.path),
        contentType: MediaType.parse(mt),
      );
      request.files.add(multipartFile);
      request.fields['email'] = email.toString();
      var respond = await request.send();
      var res = await http.Response.fromStream(respond);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data['status'] == "OK") {
          gambar = data['data'];
          fileGambar = "$homepageimg$_urlGambar$gambar";
          fileThumb = "$homepageimg$_urlGambar${imagetoThumbs(gambar ?? '')}";
          //await simpanLocal();
          dp("Image Uploaded: ${data['data']}");
          return true;
        } else {
          dp("Simpan Gambar res.body == KOSONG : $url");
        }
      } else {
        dp("basename(file.path):${basename(file.path)}");
        dp(url);
        dp("kode: ${res.statusCode}");
        dp('body:${res.body}');
      }
    } catch (e) {
      dp("_url=$url");
      dp('kesalahan: $e');
      return false;
    }
  }

  User copyWith({
    int? idkontak,
    int? idlokasi,
    String? nama,
    String? email,
    String? imageurl,
    List<AksesLokasi>? akseslokasi,
    List<AksesKas>? akseskas,
    KONTAK? kontak,
    int? tipe,
    String? gambar,
    String? fileGambar,
    String? fileThumb,
  }) {
    return User(
      idkontak: idkontak ?? this.idkontak,
      idlokasi: idkontak ?? this.idlokasi,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      imageurl: imageurl ?? this.imageurl,
      akseslokasi: akseslokasi ?? this.akseslokasi,
      akseskas: akseskas ?? akseskas,
      kontak: kontak ?? kontak,
      tipe: tipe ?? this.tipe,
      gambar: gambar ?? gambar,
      fileGambar: fileGambar ?? fileGambar,
    );
  }
}

class TipeUser {
  int? id;
  String? nama;

  TipeUser({
    this.id,
    this.nama,
  });

  factory TipeUser.fromJson(Map<String, dynamic> data) {
    return TipeUser(
      id: int.tryParse(data['id'].toString()),
      nama: data['nama'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
    };
  }
}

var listTipe = <TipeUser>[
  TipeUser(id: 0, nama: 'none'),
  TipeUser(id: 1, nama: 'Sales'),
  TipeUser(id: 2, nama: 'Gudang'),
  TipeUser(id: 3, nama: 'Admin'),
  TipeUser(id: 4, nama: 'Direksi'),
  TipeUser(id: 5, nama: 'Customer'),
  TipeUser(id: 6, nama: 'Umum'),
];

/* var listUser = <User>[
  User(id: 1, nama: 'umum', email: 'pengguna123@example.com', imageurl: 'https://scontent.fsub8-2.fna.fbcdn.net/v/t39.30808-6/375048262_6935866899777876_6556533709515743737_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGuvZTH45_biPd9IFmX7wW5SJPqE_KTXYBIk-oT8pNdgMLYaOQop35xe8g50JqYGJ1jCzCU3UZ2XzaHoOpgdMAk&_nc_ohc=O-evEZyQ0qsAX9ja8Go&_nc_ht=scontent.fsub8-2.fna&oh=00_AfBUs_PRgyeuscjBJSiMTHnPEgeAut5ZGVh7BEIymkSNEg&oe=6540C8EC', tipe: 0),
  User(id: 2, nama: 'sales', email: 'renbang.turenindah@gmail.com', tipe: 1, imageurl: 'https://lh3.googleusercontent.com/a/ACg8ocI21vlPiqqGAYFSXNuLQPjvs6RMjSig51y-QpsWX-QxDwY=s288-c-no'),
  User(id: 3, nama: 'gudang', email: 'aremacronous0002@gmail.com', tipe: 2, imageurl: "https://lh3.googleusercontent.com/a/ACg8ocJlggOzUNku1dS5rTCuVSgf7uwN5q_KHuXpvlofAHrsDQ=s288-c-no"),
  User(id: 4, nama: 'admin', email: 'naysaabidah@gmail.com', tipe: 3, imageurl: "https://lh3.googleusercontent.com/a/ACg8ocIsYOnpFcFB6CnbSBILap3zsrwo8CB-6EqZe6aeNHk5=s288-c-no"),
  User(id: 5, nama: 'knavinkids', email: 'knavinkids@gmail.com', tipe: 4, imageurl: 'https://lh3.googleusercontent.com/a/ACg8ocLlwZTpCPRlHk2kNOVL9DDCIJSXaNq_8sFWrhPJnDvia_0=s288-c-no'),
  User(id: 6, nama: 'customer', email: 'neysaentertain@gmail.com', tipe: 5, imageurl: "https://lh3.googleusercontent.com/a/ACg8ocIk-N80mK32omdNJjlmtJttEqvvnyqhJAICCAQ2z_Fe-Q=s288-c-no"),
];
 */