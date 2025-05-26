part of 'env.dart';

class DataResponse {
  bool res;
  String? message;
  String? error;
  dynamic data;
  DataResponse({this.res = false, this.message, this.error, this.data});
}

io.Socket socket = io.io('http://141.136.36.55:3000', {
  'transports': ['websocket'],
  'autoConnect': false,
});

String appcap = 'Lucky Jaya Motorindo';
var ver = '-';
final Map<String, dynamic> apikey = {"key": Env.APIKEY};
final encoding = Encoding.getByName('utf-8');
final headers = {"Content-Type": "application/x-www-form-urlencoded", 'Authorization': Env.AUTH};
final headers1 = {"Content-Type": "application/x-www-form-urlencoded"};
final headers2 = {"Content-Type": "application/json; charset=utf8"};
// final headers = {"Content-Type": "application/json", "Authorization": auth};
String persen = '';

final urlExec = "$urlBase/exec.php"; // body: {"cmd": }

final urlGetOpr = '$urlBase/opr/';
String urlGoogleGetContact = 'https://people.googleapis.com/v1/people/me/connections?requestMask.includeField=person.names';
String urlBase = Env.homebase;
String homepage = Env.homepage;

String homepageimg = Env.homepageimg;

String urlHome2 = Env.homepage2;
String urlMsg = "https://fcm.googleapis.com/fcm/send";
final urlOpname = "$urlBase/barang/opname.php"; // body: {$idbarang, $idlokasi, $opr, $selisih, $idkontak}
final urlPermintaanAdd = "$urlBase/permintaan/tambah.php"; // body: {"idtrans":, "idbarang":, "proses":}
final urlPermintaanSts = "$urlBase/permintaan/setstsread.php"; // body: {"id":, "sts":}
final urlPindahpeletakan = "$urlBase/barang/peletakan/pindah.php"; // body: {"idlama", "id":, "kode":}
final urlTambahpeletakan = "$urlBase/barang/peletakan/letakbaru.php"; // body: {"id":, "idbarang":}
final urlHapuspeletakan = "$urlBase/barang/peletakan/hapus.php"; // body: {"id":, "idbarang"}
final urlTransaksiSts = "$urlBase/setstsread.php"; // body: {"id":, "sts":}
final urlKontakRekap = "$urlBase/kontak/rekapkontak/";

final urlVerifiakasiMutasi = "$urlBase/transaksi/permintaan/permintaantomutasi.php";
Future<dynamic> postResponse(String url, Map<String, dynamic> data, {String contentType = 'application/x-www-form-urlencoded', Map<String, String>? aheaders}) async {
  var netService = GetConnect(allowAutoSignedCert: true, timeout: const Duration(seconds: 60), maxRedirects: 100, maxAuthRetries: 2);
  try {
    // aheaders ??= headers;
    if (data['key'] == null) data.addAll(apikey);
    Response<dynamic> res;
    if (contentType == 'multipart/form-data') {
      res = await netService.post(url, FormData(data), contentType: contentType, headers: aheaders);
    } else {
      res = await netService.post(url, data, contentType: contentType, headers: aheaders);
    }
    switch (res.statusCode) {
      case 200:
        if (res.body.runtimeType == String) dp("postResponse($url, $data, contentType = $contentType, $aheaders}) => ${res.body}");
        return res;
      case 408:
        pesan = 'Koneksi ke Server Habis';
        doError(pesan);
        return;
      case 415:
        dp("post: $url");
        dp("data: $data");
        dp("status: ${res.statusCode}");
        dp("postResponse($url, $data, contentType = $contentType, $aheaders})");

        doError('Kesalahan jaringan, coba sekali lagi,\nRestart Jaringan jika diperlukan');
        return;
      case null:
        dp("postResponse($url, $data, contentType = $contentType, $aheaders})");
        doError('status code NULL\nKesalahan jaringan, tidak terhubung jaringan Internet');
        return;
      default:
        dp("postResponse($url, $data, contentType = $contentType, $aheaders})");

        dp("status: ${res.statusCode}");
        dp("body: ${res.body}");

        return;
    }
  } on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    pesanError('Kesalahan jaringan, tidak terhubung jaringan Internet');
    rethrow;
  }
}

Future<DataResponse> apiPost(String url, Map<String, dynamic> data, {String contentType = 'application/x-www-form-urlencoded', Map<String, String>? aheaders}) async {
  var netService = GetConnect(allowAutoSignedCert: true, timeout: const Duration(seconds: 60), maxRedirects: 100, maxAuthRetries: 2);
  var res = DataResponse();
  try {
    // aheaders ??= headers;
    if (data['key'] == null) data.addAll(apikey);
    Response<dynamic> resApi;
    if (contentType == 'multipart/form-data') {
      resApi = await netService.post(url, FormData(data), contentType: contentType, headers: aheaders);
    } else {
      resApi = await netService.post(url, data, contentType: contentType, headers: aheaders);
    }
    if (resApi.body == null) {
      res.error = 'Body Null';
      dp("postResponse($url, $data, contentType = $contentType, $aheaders})");
      dp(res.error ?? '');
      pesanError1("Kesalahan pada Respons Server");
      return res;
    }
    Map<String, dynamic> json = (resApi.body.runtimeType == String) ? jsonDecode(resApi.body) : resApi.body;
    switch (resApi.statusCode) {
      case 200:
        if (json["status"] == 'BERHASIL') {
          res.res = true;
          res.message = json["message"] ?? 'Berhasil';
        } else {
          res.message = json["message"] ?? 'Gagal';
        }
      default:
        res.res = false;
        res.message = json["message"] ?? 'Gagal';
        res.error = json["error"] ?? 'error';
    }
  } on SocketException catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    res.res = false;
    res.message = _.message;
    res.error = _.message;
  }
  return res;
}

Future<String> getCacheDirectory() async {
  final directory = await getTemporaryDirectory();
  // dp("cachedir: ${directory.path}");
  return directory.path;
}

imagetoThumbs(String file) {
  if (file.trim() == '') return '';
  return "${path.dirname(file)}/thumbs/${path.basename(file)}";
}

void deleteThumb(String imageUrl, String dataname, String data) async {
  var filedir = '$dataname/uploads/$data/thumbs';
  var filePath = "$pathExtData$filedir${path.basename(imageUrl)}";
  final file = File(filePath);
  // dp('delete $filePath');
  if (await file.exists()) {
    await file.delete();
  }
}

void deleteImage(String imageUrl, String dataname, String data) async {
  var filedir = '$dataname/uploads/$data/';
  var filePath = "$pathExtData$filedir${path.basename(imageUrl)}";
  final file = File(filePath);
  //dp('delete $filePath');
  if (await file.exists()) {
    await file.delete();
  }
}

Future<String> loadCacheThumbDownload(String imageUrl, String dataname, String data, [bool replace = false]) async {
  try {
    var filedir = '$dataname/uploads/$data';
    var newFile = "$pathExtData$filedir/thumbs${path.basename(imageUrl)}";
    final newDir = Directory("$pathExtData$filedir");
    if (!newDir.existsSync()) {
      newDir.createSync(recursive: true);
    }
    final file = File(newFile);
    if (replace == false) {
      if (file.existsSync()) return file.path;
    }

    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    } else {
      dp('gagal unduh gambar\n$imageUrl');
      return '';
    }
  } catch (e) {
    dp("loadCacheThumbDownload \n e$e");
    return '';
  }
}

Future<String?> loadCacheDownload(String imageUrl, String filename, String dataname, [bool replace = false]) async {
  var filedir = path.dirname(filename);
  var newFile = "$pathExtData$dataname/$filename";
  final newDir = Directory("$pathExtData$dataname/$filedir");
  if (!newDir.existsSync()) {
    newDir.createSync(recursive: true);
  }
  final file = File(newFile);
  if (replace == false) {
    if (file.existsSync()) {
      // dp("loadCacheDownload: exists: ${file.path}");
      return file.path;
    }
  }
  final response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode == 200) {
    await file.writeAsBytes(response.bodyBytes);
    // dp("loadCacheDownload: ${file.path}");
    return file.path;
  } else {
    dp('Gagal mengunduh gambar');
    return null;
  }
}

void deleteImageFromCache(ImageProvider provider) {
  final cache = PaintingBinding.instance.imageCache;
  cache.evict(provider);
}

Future<void> deleteCachedImage(String imagePath, String data) async {
  final cacheDirectory = await getCacheDirectory();
  final filePath = '$cacheDirectory/$data/$imagePath';

  final file = File(filePath);
  if (await file.exists()) {
    await file.delete();
  }
}

Future getResponse(String url, Map<String, dynamic> data, {String contentType = 'application/x-www-form-urlencoded', Map<String, String>? aheaders}) async {
  var netService = GetConnect(allowAutoSignedCert: true, timeout: const Duration(seconds: 1000), maxRedirects: 100, maxAuthRetries: 2);
  data = {...data, ...apikey};
  dp("netService.get($url, $data)");
  try {
    Response<dynamic> res;
    if (contentType == 'multipart/form-data') {
      res = await netService.get(url, query: data, contentType: contentType, headers: aheaders);
    } else {
      res = await netService.get(url, query: data, contentType: contentType, headers: aheaders);
      //res = await netService.get(url, query: data, contentType: contentType);
    }
    switch (res.statusCode) {
      case 200:
        return res;
      case 408:
        pesan = 'Koneksi ke Server Habis';
        doError(pesan);
        return;
      case 415:
        dp("post: $url");
        dp("data: $data");
        dp("status: ${res.statusCode}");
        dp("getResponse($url, $data, contentType = $contentType, $aheaders})");

        pesanError('Kesalahan jaringan, coba sekali lagi,\nRestart Jaringan jika diperlukan');
        return;
      case null:
        dp("getResponse($url, $data, contentType = $contentType, $aheaders})");
        doError('status code NULL\nKesalahan jaringan, tidak terhubung jaringan Internet');
        return;
      default:
        dp("status: ${res.statusCode}");
        dp("body: ${res.body}");
        pesanError("status: ${res.statusCode}\nbody: ${res.body}");

        return;
    }
  } catch (_) {
    // make it explicit that a SocketException will be thrown if the network connection fails
    pesanError('Kesalahan jaringan, tidak terhubung jaringan Internet\n$_\ndata: $data');

    rethrow;
  }
}

Future getResponse3(String url, Map<String, dynamic> data, {String contentType = 'application/x-www-form-urlencoded', Map<String, String>? aheaders}) async {
  String addUrl = "";
  var netService = GetConnect(allowAutoSignedCert: true, timeout: const Duration(seconds: 60));
  data.addEntries(apikey.entries);
  if (data.isNotEmpty) {
    data.forEach((key, value) {
      if (addUrl == "") {
        addUrl = "?$key=$value";
      } else {
        addUrl = "$addUrl&$key=$value";
      }
    });
  }

  url = "$url$addUrl";
  Response<dynamic> res = await netService.get(url, contentType: contentType, headers: aheaders);

  switch (res.statusCode) {
    case 200:
      if (res.body.runtimeType == String) {
        // dp("getResponses($url, $data, contentType = $contentType, $aheaders}) => ${res.body}");
      }
      return res;
    case 408:
      pesan = 'Koneksi ke Server Habis';
      doError(pesan);
      return;
    case 415:
      dp("get: $url");
      dp("status: ${res.statusCode}");
      dp("body: ${res.body}");
      dp("getResponse($url, contentType = $contentType, $aheaders})");
      if (Get.isSnackbarOpen) Get.closeAllSnackbars();
      Get.snackbar(
        'Kesalahan',
        'Kesalahan jaringan, coba sekali lagi,\nRestart Jaringan jika diperlukan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 10),
        isDismissible: true,
        margin: const EdgeInsets.all(10),
      );
      //doError('Kesalahan Jaringan 415');
      return;

    default:
      doError('status: ${res.statusCode}');
      dp("status: ${res.statusCode}");
      dp("body: ${res.body}");

      return;
  }
}
