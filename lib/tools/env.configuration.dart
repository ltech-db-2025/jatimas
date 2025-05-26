part of 'env.dart';

class SettingForm {
  bool autofetchonedit;
  bool autofetchonview;
  bool onlyActive;
  SettingForm({this.autofetchonedit = false, this.autofetchonview = true, this.onlyActive = true});
}

var settingFormEditMerk = SettingForm();
var settingFormEditJenis = SettingForm();
var settingFormEditKelompok = SettingForm();
var settingFormEditKategori = SettingForm();
var settingFormEditSatuan = SettingForm();
