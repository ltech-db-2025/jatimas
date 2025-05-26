part of 'env.dart';

String formattanggal(String? tgl, [String format = "dd/MM/yy"]) {
  if (tgl == null) return '-';
  try {
    final tanggal = DateTime.tryParse(tgl) ?? DateTime.now();
    return DateFormat(format).format(tanggal);
  } catch (e) {
    dp("formattanggal(e): $e");
    return "-";
  }
}

String formattanggal2(String? tanggal) {
  if (tanggal == null) return '';
  if (DateTime.tryParse(tanggal) == null) return '';
  return "${DateTime.parse(tanggal).day} ${namaBulan(DateTime.parse(tanggal).month)} ${DateTime.parse(tanggal).year}";
}

makeStr(d) => (d == null)
    ? null
    : (d == 'null')
        ? null
        : d.toString();
int? makeInt(d) => (int.tryParse(d.toString()));
double? makeDouble(d) => (double.tryParse(d.toString()));
double? makeDouble2(d) => double.tryParse(d.toString().replaceAll(',', '.').replaceAll('.', '')) ?? 0;
bool? makeBool(d) => ((d is bool) ? d : bool.tryParse(d.toString()) ?? false);
bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }
  return num.tryParse(s) != null;
}

String emailToFileName(String email) {
  // Menghilangkan karakter "@" dan "."
  String sanitizedEmail = email.replaceAll(RegExp(r'[@.]'), '_');

  // Membatasi panjang nama file
  if (sanitizedEmail.length > 50) {
    sanitizedEmail = sanitizedEmail.substring(0, 50);
  }

  // Menghasilkan hash MD5 atau SHA-1 jika diperlukan
  // Anda dapat menggunakan paket kriptografi untuk ini

  return sanitizedEmail;
}

String addWhere(String baseSql, String? whereCondition) {
  if (baseSql.isEmpty) {
    throw ArgumentError('Base SQL query cannot be empty');
  }

  String dynamicQuery = baseSql.trim();
  bool hasWhereClause = dynamicQuery.toUpperCase().contains('WHERE');
  if (whereCondition != null && whereCondition.isNotEmpty) {
    if (hasWhereClause) {
      dynamicQuery = dynamicQuery.replaceFirst('where', 'WHERE');
      dynamicQuery = dynamicQuery.replaceFirst('WHERE', 'WHERE $whereCondition AND');
    } else {
      dynamicQuery += ' WHERE $whereCondition';
    }
  }
  return dynamicQuery;
}

final CurrencyTextInputFormatter uangformatter = CurrencyTextInputFormatter.currency(locale: 'id', decimalDigits: 0, symbol: 'Rp. ');
final CurrencyTextInputFormatter angkaformatter = CurrencyTextInputFormatter.currency(locale: 'id', decimalDigits: 0, symbol: "");
formatangka(a) => angkaformatter.formatDouble(double.tryParse(a.toString().replaceAll(",", "")) ?? 0);
formatuang(a) => uangformatter.formatDouble(double.tryParse(a.toString().replaceAll(",", "")) ?? 0);

dp([String? str]) {
  str ??= prosestxt;
  if (kDebugMode) {
    debugPrint(str);
  }
}

String mapToQueryString(Map<String, dynamic> data) {
  List<String> queryParameters = [];
  data.forEach((key, value) {
    String encodedKey = Uri.encodeComponent(key);
    String encodedValue = Uri.encodeComponent(value.toString());
    queryParameters.add("$encodedKey=$encodedValue");
  });
  return "?${queryParameters.join("&")}";
}

DateTime lastDate([DateTime? current]) {
  current ??= DateTime.now();
  var th = (current.month == 12) ? current.year + 1 : current.year;
  var bln = (current.month == 12) ? 1 : current.month + 1;
  return DateTime(th, bln, 0);
}

DateTime firstDate([DateTime? current]) {
  current ??= DateTime.now();
  return DateTime(current.year, current.month, 1);
}

Future<void> getAppDir() async {
  dp("initial Directori");

  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
  } else if (Platform.isWindows) {
    directory = await getApplicationDocumentsDirectory();
  }
  pathExtData = '${directory!.path}/';

  final appDoc = await getApplicationDocumentsDirectory();
  final dirTemp = await getTemporaryDirectory();
  pathData = '${appDoc.path}/';
  pathTemp = '${dirTemp.path}/';
}

// ignore: avoid_positional_boolean_parameters
bool verify(bool? condition, {String? message}) {
  message ??= 'verify failed';
  final kondisi = condition ?? false;
  expect(kondisi, true, reason: message);
  return kondisi;
}

double multidikson(double nilai, String diskon) {
  double kases(String opr, double n1, double n2) {
    dp('kases: $opr, $n1, $n2');
    switch (opr) {
      case '+':
        return n2 + n1;
      case '-':
        return n2 - n1;
      case '*':
        return n2 * n1;
      case '/':
        return n2 / n1;
      case ':':
        return n2 / n1;
      default:
        return 0;
    }
  }

  int ix = 0;
  int minplus;
  String oprator = '';
  String tempstr;
  double n1 = 0;
  double n2 = 0;
  double n3;
  minplus = 1;
  final List<String> angka = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', ','];
  final List<String> tanda = ['.', ','];
  final List<String> tanda2 = ['+', '-', '*', '/', ':', '=', '%'];
  if (diskon.trim() != '') {
    n1 = 0;
    n2 = 0;
    n3 = nilai;
    oprator = '';
    if (diskon.isNotEmpty) {
      ix = 0;
      tempstr = '';
      oprator = '';
      if (diskon.substring(0, 1) == '-') {
        minplus = -1;
        ix = 1;
      }
      do {
        final String achar = diskon.substring(ix, ix + 1);
        // dp('achar $ix: $achar');
        if (angka.contains(achar)) {
          if (tanda.contains(achar)) {
            tempstr = '$tempstr.';
          } else {
            tempstr = '$tempstr$achar';
          }
        }
        if (tanda2.contains(achar) || ix >= diskon.length - 1) {
          oprator = tanda2.contains(achar) ? achar : '';
          // dp('tempstr: $tempstr opr:$oprator');
          if (tempstr != '') {
            if (oprator == '') {
              n1 = n3 * ((double.tryParse(tempstr) ?? 0) / 100);
              n2 = n2 + n1;
              n3 = n3 - n1;
              // dp('n1: $n3 x ${((double.tryParse(tempstr) ?? 0) / 100)} tempstr: $tempstr');

              tempstr = '';
            } else {
              n1 = n3 * ((double.tryParse(tempstr) ?? 0) / 100);
              // dp('n2: $n3 x ${((double.tryParse(tempstr) ?? 0) / 100)} tempstr: $tempstr');
              n2 = kases(oprator, n1, n2);
              n3 = nilai - n2;
            }
            tempstr = '';
          }
          oprator = achar;
        }
        ix++;
      } while (ix < diskon.length);
    }
    //  -- set n2 = n2 - nilai;
    //  -- return minplus * n2;
    return n2 * minplus;
  } else {
    return 0;
  }
}

T tryCast<T>(dynamic x, T fallback) {
  try {
    return x as T;
  } catch (e) {
    dp('CastError when trying to cast $x to $T!');
    return fallback;
  }
}

String tryGetStatusFromJson(res) {
  try {
    final body = res.body;
    final String status = body['status'] as String;
    return status;
  } catch (e) {
    dp("tryGetStatusFromJson($res)");
    dp('response.body: ${res.body}\n$e');
    return 'GAGAL';
  }
}

final NumberFormat formatter = NumberFormat('#,##0.00', 'id_ID');
String mapToWhere(Map<String, dynamic>? data) {
  String res = '';
  String periode = '';
  if (data == null) return '';
  for (final type in data.keys) {
    if (type == 'periode') {
      periode = "(strftime('%Y', date(tanggal)) = strftime('%Y', current_date) and strftime('%m', date(tanggal)) = strftime('%m', current_date))";
      res = (res == '') ? periode : "$res and $periode";
    } else if (type == 'before' || type == "xidlokasi") {
      // periode = "nobukt";
      //  res = (res == '') ? periode : "$res and $periode";
    } else if (type == 'yoy') {
      periode = "tanggal >= date('now', '-12 months');";
      res = (res == '') ? periode : "$res and $periode";
    } else if (type == 'tgl1') {
      periode = "(strftime('%d-%m-%Y',tanggal) >= strftime('%d-%m-%Y','${data[type]}'))";
      res = (res == '') ? periode : "$res and $periode";
    } else if (type == 'tgl2') {
      periode = "(strftime('%d-%m-%Y',tanggal) <= strftime('%d-%m-%Y','${data[type]}'))";
      res = (res == '') ? periode : "$res and $periode";
    } else if (type == 'status' || type == 'sts') {
      res = (res == '') ? " $type ${data[type]} " : "$res and $type ${data[type]} ";
    } else if (type == 'lokasi') {
      res = (res == '') ? "(idlokasi = ${data[type]} or idlokasi2 = ${data[type]}) " : "$res  and (idlokasi = ${data[type]} or idlokasi2 = ${data[type]}) ";
    } else if (type == 'kredit') {
      res = (res == '') ? "(saldo > 0)" : "$res and (saldo > 0)";
    } else if (type == 'adastok' || type == 'onlystok') {
      res = (res == '') ? "(stok != 0)" : "$res and (stok != 0)";
    } else if (type == 'updated') {
    } else {
      res = (res == '') ? " $type='${data[type]}'" : "$res and $type='${data[type]}'";
    }
  }

  return res;
}

Future<String> getMimeType(File? file) async {
  var mimeType = lookupMimeType(file!.path);
  if (mimeType == null) {
    var dataHeader = await file.readAsBytes();
    mimeType = lookupMimeType(file.path, headerBytes: dataHeader);
  }
  return mimeType ?? 'application/octet-stream'; // MIME default jika tidak ditemukan
}

String getInitials({String? string, int? limitTo}) {
  try {
    if (string == null) return '';
    var buffer = StringBuffer();
    var split = string.split(' ');
    if (split.isEmpty) return '';
    if (split.length == 1) return split[0][0];
    for (var i = 0; i < (limitTo ?? split.length); i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  } catch (e) {
    return '';
  }
}

filterData(String dicari, Iterable<dynamic> list, List<String> fields) {
  final List<String> kalimat = dicari.split(" ");
  bool cek(dynamic x, int field, int kata) {
    var data = jsonDecode(x.toJson());
    return data[fields[field]].toString().toLowerCase().contains(kalimat[kata].toLowerCase());
  }

  bool cek2(dynamic x, int kata) {
    return x.toString().toLowerCase().contains(kalimat[kata].toLowerCase());
  }

  if (dicari == '') return [];
  // dp("kalimat: ${kalimat.length}, fields: ${fields.length}");
  switch (kalimat.length) {
    case 0:
      switch (fields.length) {
        case -1:
          return list.where((e) => e.toString().toLowerCase().contains(kalimat[0].toLowerCase())).toList();
        case 0:
          return list.where((e) => e.toString().toLowerCase().contains(kalimat[0].toLowerCase())).toList();
        case 1:
          return list.where((e) => cek(e, 0, 0)).toList();
        case 2:
          return list.where((e) => cek(e, 0, 0) || cek(e, 1, 0)).toList();
        case 3:
          return list.where((e) => cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0)).toList();
        case 4:
          return list.where((e) => cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)).toList();
        default:
          return list.where((e) => cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)).toList();
      }
    case 1:
      switch (fields.length) {
        case -1:
          return list.where((e) => cek2(e, 0)).toList();
        case 0:
          return list.where((e) => cek2(e, 0)).toList();
        case 1:
          return list.where((e) => cek(e, 0, 0)).toList();
        case 2:
          return list.where((e) => cek(e, 0, 0) || cek(e, 1, 0)).toList();
        case 3:
          return list.where((e) => cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0)).toList();
        case 4:
          return list.where((e) => cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)).toList();
        default:
          return list.where((e) => cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)).toList();
      }
    case 2:
      switch (fields.length) {
        case -1:
          return list.where((e) => cek2(e, 0) && cek2(e, 1)).toList();
        case 0:
          return list.where((e) => cek2(e, 0) && cek2(e, 1)).toList();
        case 1:
          return list.where((e) => cek(e, 0, 0) && cek(e, 0, 1)).toList();
        case 2:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0)) && (cek(e, 0, 1) || cek(e, 1, 1))).toList();
        case 3:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1))).toList();
        case 4:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1) || cek(e, 3, 1))).toList();
        default:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1) || cek(e, 3, 1))).toList();
      }
    case 3:
      switch (fields.length) {
        case -1:
          return list.where((e) => cek2(e, 0) && cek2(e, 1) && cek2(e, 2)).toList();
        case 0:
          return list.where((e) => cek2(e, 0) && cek2(e, 1) && cek2(e, 2)).toList();
        case 1:
          return list.where((e) => cek(e, 0, 0) && cek(e, 0, 1) && cek(e, 0, 2)).toList();
        case 2:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0)) && (cek(e, 0, 1) || cek(e, 1, 1)) && (cek(e, 0, 2) || cek(e, 1, 2))).toList();
        case 3:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1)) && (cek(e, 0, 2) || cek(e, 1, 2) || cek(e, 2, 2))).toList();
        case 4:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1) || cek(e, 3, 1)) && (cek(e, 0, 2) || cek(e, 1, 2) || cek(e, 2, 2) || cek(e, 3, 2))).toList();
        default:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1) || cek(e, 3, 1))).toList();
      }
    case 4:
      switch (fields.length) {
        case -1:
          return list.where((e) => cek2(e, 0) && cek2(e, 1) && cek2(e, 2) && cek2(e, 3)).toList();
        case 0:
          return list.where((e) => cek2(e, 0) && cek2(e, 1) && cek2(e, 2) && cek2(e, 3)).toList();
        case 1:
          return list.where((e) => cek(e, 0, 0) && cek(e, 0, 1) && cek(e, 0, 2) && cek(e, 0, 3)).toList();
        case 2:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0)) && (cek(e, 0, 1) || cek(e, 1, 1)) && (cek(e, 0, 2) || cek(e, 1, 2)) && (cek(e, 0, 3) || cek(e, 1, 3))).toList();
        case 3:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1)) && (cek(e, 0, 2) || cek(e, 1, 2) || cek(e, 2, 2)) && (cek(e, 0, 3) || cek(e, 1, 3) || cek(e, 2, 3))).toList();
        case 4:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1) || cek(e, 3, 1)) && (cek(e, 0, 2) || cek(e, 1, 2) || cek(e, 2, 2) || cek(e, 3, 2)) && (cek(e, 0, 3) || cek(e, 1, 3) || cek(e, 2, 3) || cek(e, 3, 3))).toList();
        default:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1) || cek(e, 3, 1))).toList();
      }
    default:
      switch (fields.length) {
        case -1:
          return list.where((e) => cek2(e, 0) && cek2(e, 1) && cek2(e, 2) && cek2(e, 3)).toList();
        case 0:
          return list.where((e) => cek2(e, 0) && cek2(e, 1) && cek2(e, 2) && cek2(e, 3)).toList();
        case 1:
          return list.where((e) => cek(e, 0, 0) && cek(e, 0, 1) && cek(e, 0, 2) && cek(e, 0, 3)).toList();
        case 2:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0)) && (cek(e, 0, 1) || cek(e, 1, 1)) && (cek(e, 0, 2) || cek(e, 1, 2)) && (cek(e, 0, 3) || cek(e, 1, 3))).toList();
        case 3:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1)) && (cek(e, 0, 2) || cek(e, 1, 2) || cek(e, 2, 2)) && (cek(e, 0, 3) || cek(e, 1, 3) || cek(e, 2, 3))).toList();
        case 4:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1) || cek(e, 3, 1)) && (cek(e, 0, 2) || cek(e, 1, 2) || cek(e, 2, 2) || cek(e, 3, 2)) && (cek(e, 0, 3) || cek(e, 1, 3) || cek(e, 2, 3) || cek(e, 3, 3))).toList();
        default:
          return list.where((e) => (cek(e, 0, 0) || cek(e, 1, 0) || cek(e, 2, 0) || cek(e, 3, 0)) && (cek(e, 0, 1) || cek(e, 1, 1) || cek(e, 2, 1) || cek(e, 3, 1))).toList();
      }
  }
}

void renameFile(File imageFile, String newFileName) async {
  if (imageFile.existsSync()) {
    // Dapatkan path direktori dari file asli
    final parentDirectory = imageFile.parent;

    // Buat File baru dengan nama yang berbeda
    final newFile = File('${parentDirectory.path}/$newFileName');

    // Lakukan operasi rename
    try {
      imageFile.renameSync(newFile.path);
    } catch (e) {
      dp('Gagal merename file: $e');
    }
  } else {
    dp('File tidak ditemukan');
  }
}

Future<File> changeFileNameOnly(File file, String newFileName) {
  var path = file.path;
  var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
  var newPath = path.substring(0, lastSeparator + 1) + newFileName;
  return file.rename(newPath);
}

String namaBulan(int? bln) {
  if (bln == null) return '';
  switch (bln) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'Mei';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Agu';
    case 9:
      return 'Sep';
    case 10:
      return 'Okt';
    case 11:
      return 'Nov';
    case 12:
      return 'Des';

    default:
      return '';
  }
}

String createWhere(String source, List<String> fields) {
  // Split the source string into individual words
  List<String> words = source.toLowerCase().split(' ');

  // Create a list to hold all groups of conditions
  List<String> groups = [];

  // For each word, create a group of conditions
  for (var word in words) {
    var wordConditions = fields.map((field) => "LOWER($field) LIKE '%$word%'").toList();
    // Join conditions for the current word with OR
    groups.add('(' + wordConditions.join(' OR ') + ')');
  }

  // Join the groups with AND
  return "(${groups.join(' AND ')})";
}

class Encryption {
  final String key; // Kunci enkripsi
  final encrypt.Encrypter encrypter;
  final encrypt.IV iv;

  Encryption(this.key)
      : encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(key))),
        iv = encrypt.IV.fromLength(16); // Panjang IV untuk AES

  // Fungsi untuk mengenkripsi data
  String encryptData(String data) {
    return encrypter.encrypt(data, iv: iv).base64; // Mengembalikan data terenkripsi dalam format base64
  }
}

String encryptData2(dynamic payload) {
  final encryptionKey = '16charsecretkey!';
  final encryption = Encryption(encryptionKey);
  return encryption.encryptData(payload);
}

String encryptData3(String plainText) {
  final keyString = 'my32lengthsupersecretnooneknows1'; // 32 chars
  final ivString = '8bytesiv12345678'; // 16 chars

  // Mengambil key dan iv
  final key = encrypt.Key.fromUtf8(keyString);
  final iv = encrypt.IV.fromUtf8(ivString);

  // Encrypter menggunakan AES dengan CBC
  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

  // Mengenkripsi data
  final encrypted = encrypter.encrypt(plainText, iv: iv);

  // Mengembalikan hasil enkripsi dalam bentuk base64
  return encrypted.base64;
}

String encryptData(String plainText, {String keyString = 'my32lengthsupersecretnooneknows1', String ivString = '8bytesiv12345678'}) {
  // keyString = 32 chars
  // ivString =  16 chars
  final key = encrypt.Key.fromUtf8(keyString);
  final iv = encrypt.IV.fromUtf8(ivString);

  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return encrypted.base64;
}
/* 
Future<void> checkForUpdate(BuildContext context) async {
  // Ambil info versi aplikasi saat ini
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String currentVersion = packageInfo.version;

  // Ambil info versi dari server
  final response = await http.get(Uri.parse('https://leontech.shop/app/check_update.php'));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    String latestVersion = data['version'];
    String apkUrl = data['url'];

    // Bandingkan versi
    if (currentVersion != latestVersion) {
      // Tampilkan dialog atau notifikasi untuk mengunduh APK terbaru
      // Misalnya, menggunakan showDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pembaruan Tersedia'),
            content: Text('Versi terbaru: $latestVersion. Ingin mengunduh?'),
            actions: [
              TextButton(
                child: Text('Ya'),
                onPressed: () async {
                  await downloadApk(apkUrl);
                },
              ),
              TextButton(
                child: Text('Tidak'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } else {
    // Handle error saat mengambil data versi
    print('Failed to check for updates: ${response.statusCode}');
  }
}
 */
/* Future<String> getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
} */

downloadApk([String apkUrl = "https://luckyjayagroup.com/app/lastest/app-release.apk"]) async {
  if (await canLaunchUrl(Uri.parse(apkUrl))) {
    await launchUrl(Uri.parse(apkUrl));
  } else {
    throw 'Could not launch $apkUrl';
  }
}
