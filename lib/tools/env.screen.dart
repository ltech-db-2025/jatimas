part of 'env.dart';

double lebar = 0;
double lebarlayar = 0;
double tinggilayar = 0;
double tinggi = 0;
double lebarbarang = 0;

void setUkuranLayar(BuildContext context) {
  late MediaQueryData data = MediaQuery.of(context);
  lebarlayar = data.size.width;
  tinggilayar = data.size.height;
  lebar = lebarlayar - 20;
  lebarbarang = data.size.width - 55;
  tinggi = data.size.height;
}
