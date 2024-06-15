import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto/src/common/constants/assets.dart';


class CommonUtil {
  static Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    return picked;
  }

  static List<Map<String, String>> sortByName(List<Map<String, String>> list) {
    list.sort((a, b) => a["name"]!.compareTo(b["name"]!));
    return list;
  }
}


class CertificateUtil {
  
  static Future<DateTime?> selectYear(BuildContext context, DateTime? selectedYear) async {
    return await CommonUtil.selectDate(context);
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
}


class PersonalInfoUtil {
  static Future<File?> getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  static Future<DateTime?> selectDate(BuildContext context) async {
    return await CommonUtil.selectDate(context);
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
    return CommonUtil.sortByName(cities);
  }

  
  static Future<Map<String, List<Map<String, String>>>> loadDistrictData() async {
    final String response = await rootBundle.loadString(Assets.filesDistrictJson);
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
      CommonUtil.sortByName(districts);
    });
    return cityDistrictMap;
  }
}


class EducationUtil {
  
  static Future<DateTime?> selectStartDate(BuildContext context) async {
    return await CommonUtil.selectDate(context);
  }

  static Future<DateTime?> selectEndDate(BuildContext context) async {
    return await CommonUtil.selectDate(context);
  }
}

class ExperienceUtil {

  static Future<DateTime?> selectStartDate(BuildContext context) async {
    return await CommonUtil.selectDate(context);
  }

  static Future<DateTime?> selectEndDate(BuildContext context) async {
    return await CommonUtil.selectDate(context);
  }
}
