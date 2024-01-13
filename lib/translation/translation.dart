import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/translation/arabic.dart';
import 'package:way_to_doctor_doctor/translation/english.dart';
import 'package:way_to_doctor_doctor/translation/turkish.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": en,
        "ar": ar,
        "tr": tr,
      };
}
