import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'KEY1')
  static const String key1 = _Env.key1;
  @EnviedField(varName: 'KEY2')
  static const String key2 = _Env.key2;
  @EnviedField()
  static const String homepage = _Env.homepage;
  @EnviedField()
  static const String homebase = _Env.homebase;
  @EnviedField()
  static const String homepageimg = _Env.homepageimg;
  @EnviedField()
  static const String homepage2 = _Env.homepage2;
  @EnviedField()
  static const String urlexc_base = _Env.urlexc_base;
  @EnviedField()
  static const String homeleontech = _Env.homeleontech;
  @EnviedField()
  static const String urlexc_add2 = _Env.urlexc_add2;
  @EnviedField()
  static const String urlexc_add = _Env.urlexc_add;
  @EnviedField()
  static const String GOOGLESIGNINCLIENTID = _Env.GOOGLESIGNINCLIENTID;
  @EnviedField()
  static const String GOOGLESIGNINWEBCLIENTID = _Env.GOOGLESIGNINWEBCLIENTID;
  @EnviedField()
  static const String AUTH = _Env.AUTH;
  @EnviedField()
  static const String APIKEY = _Env.APIKEY;
  @EnviedField()
  static const String URLKEUANGAN = _Env.URLKEUANGAN;
  @EnviedField()
  static const String DATABASE_HOST = _Env.DATABASE_HOST;
  @EnviedField()
  static const int DATABASE_PORT = _Env.DATABASE_PORT;

  @EnviedField()
  static const String DATABASE_USER = _Env.DATABASE_USER;
  @EnviedField()
  static const String DATABASE_PASSWORD = _Env.DATABASE_PASSWORD;
  @EnviedField()
  static const String DATABASE_NAME = _Env.DATABASE_NAME;
}
