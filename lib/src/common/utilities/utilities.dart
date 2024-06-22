import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/common/constants/assets.dart';

class Utilities {
  static Future<DateTime?> datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    return picked;
  }

  static List<Map<String, String>> sortListByName(
      List<Map<String, String>> list) {
    list.sort((a, b) => a["name"]!.compareTo(b["name"]!));
    return list;
  }

  static Future<String?> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return result.files.single.path;
    }
    return null;
  }

  static Future<File?> getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  static Future<List<Map<String, String>>> loadCityData() async {
    final String response = await rootBundle.loadString(Assets.filesCitiesJson);
    final List<dynamic> data = json.decode(response);
    final List<Map<String, String>> cities = data.map((item) {
      return {
        "id": item["id"].toString(),
        "name": item["name"].toString(),
      };
    }).toList();
    return Utilities.sortListByName(cities);
  }

  static Future<Map<String, List<Map<String, String>>>>
      loadDistrictData() async {
    final String response =
        await rootBundle.loadString(Assets.filesDistrictJson);
    final List<dynamic> data = json.decode(response);
    final Map<String, List<Map<String, String>>> cityDistrictMap = {};
    for (var item in data) {
      String cityId = item["il_id"].toString();
      if (cityDistrictMap.containsKey(cityId)) {
        cityDistrictMap[cityId]?.add({
          "id": item["id"].toString(),
          "name": item["name"].toString(),
        });
      } else {
        cityDistrictMap[cityId] = [
          {
            "id": item["id"].toString(),
            "name": item["name"].toString(),
          }
        ];
      }
    }
    cityDistrictMap.forEach((cityId, districts) {
      Utilities.sortListByName(districts);
    });
    return cityDistrictMap;
  }

  static void showSnackBar(
      {required String snackBarMessage, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(snackBarMessage)),
    );
  }

  static String errorMessageChecker(String result) {
    if (kDebugMode) {
      print('gelen kod : $result');
    }
    switch (result) {
      case 'success':
        return 'İşlem Başarılı!';
      case 'email-already-in-use':
        return 'Bu e-posta sitemde kayıtlı!';
      case 'invalid-email':
        return 'E-posta formatı hatalı!';
      case 'weak-password':
        return 'Şifre yeterince güçlü değil!';
      case 'account-exists-with-different-credential':
        return 'Bu e-posta sitemde kayıtlı!';
      case 'user-disabled':
        return 'Bu hesap aktif değil!';
      case 'wrong-password':
        return 'Yanlış şifre!';
      case 'user-not-found':
        return 'Böyle bir kullanıcı bulunamadı!';

      default:
        return 'Hata: $result';
    }
  }
}
