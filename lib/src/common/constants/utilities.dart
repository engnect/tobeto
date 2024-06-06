import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:tobeto/src/common/constants/assets.dart';

Future<File?> getImageFromGallery() async {
  final imagePicker = ImagePicker();
  final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  return pickedDate;
}

Future<List<Map<String, String>>> loadCityData() async {
  try {
    final String response = await rootBundle.loadString(Assets.filesCitiesJson);
    final List<dynamic> data = json.decode(response);

    List<Map<String, String>> cities = data
        .map((item) =>
            {"id": item["id"].toString(), "name": item["name"].toString()})
        .toList();
    cities
        .sort((a, b) => a["name"]!.compareTo(b["name"]!)); // alfabetik sıralama
    return cities;
  } catch (e) {
    print('Şehir verileri yüklenirken bir hata oluştu: $e');
    return [];
  }
}

Future<Map<String, List<Map<String, String>>>> loadDistrictData() async {
  try {
    final String response =
        await rootBundle.loadString(Assets.filesDistrictJson);
    final List<dynamic> data = json.decode(response);

    Map<String, List<Map<String, String>>> cityDistrictMap = {};
    for (var item in data) {
      String cityId = item["il_id"].toString();
      if (cityDistrictMap.containsKey(cityId)) {
        cityDistrictMap[cityId]?.add(
            {"id": item["id"].toString(), "name": item["name"].toString()});
      } else {
        cityDistrictMap[cityId] = [
          {"id": item["id"].toString(), "name": item["name"].toString()}
        ];
      }
    }
    cityDistrictMap.forEach((cityId, districts) {
      districts.sort((a, b) => a["name"]!.compareTo(b["name"]!));
    });
    return cityDistrictMap;
  } catch (e) {
    print('İlçe verileri yüklenirken bir hata oluştu: $e');
    return {};
  }
}

//certificate utility

Future<DateTime?> selectYear(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1990),
    lastDate: DateTime.now(),
  );
  return picked;
}

Future<String?> pickPDF() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    return result.files.single.path!;
  }
  return null;
}

//education utils

Future<DateTime?> selectDate2(BuildContext context,
    {required DateTime initialDate}) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  return pickedDate;
}

String formatDate(DateTime? date) {
  return date != null ? DateFormat('dd/MM/yyyy').format(date) : '';
}

//languages util

Widget buildDropdownMenu({
  required BuildContext context,
  required String? selectedValue,
  required List<String> items,
  required String hint,
  required Function(String?) onSelected,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: PopupMenuButton<String>(
      initialValue: selectedValue,
      itemBuilder: (BuildContext context) {
        return items.map<PopupMenuItem<String>>((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();
      },
      onSelected: onSelected,
      child: ListTile(
        title: Text(selectedValue ?? hint),
        trailing: const Icon(Icons.arrow_drop_down),
      ),
    ),
  );
}

//PASSWORD_sETTİNGS UTİLİTY

Widget buildPasswordTextField({
  required TextEditingController controller,
  required String labelText,
  required bool obscureText,
  required VoidCallback toggleObscureText,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
    ),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: const EdgeInsets.all(8),
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleObscureText,
        ),
      ),
    ),
  );
}

//skilss utility

Widget buildSkillInputField({
  required TextEditingController controller,
  required VoidCallback onAddSkill,
}) {
  return Row(
    children: [
      Expanded(
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Yetenek Adı',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      const SizedBox(width: 8),
      ElevatedButton(
        onPressed: onAddSkill,
        child: const Text('Ekle'),
      ),
    ],
  );
}

Widget buildSelectedSkillsChips({
  required List<String> selectedSkills,
  required Function(String) onDeleteSkill,
}) {
  return Wrap(
    spacing: 8,
    children: selectedSkills.map((skill) {
      return Chip(
        label: Text(skill),
        onDeleted: () => onDeleteSkill(skill),
      );
    }).toList(),
  );
}

Widget buildAvailableSkillsDropdown({
  required List<String> availableSkills,
  required Function(String?) onSkillSelected,
}) {
  return DropdownButtonFormField<String>(
    value: null,
    hint: const Text('Mevcut Yetkinlik Seç'),
    items: availableSkills.map((String skill) {
      return DropdownMenuItem<String>(
        value: skill,
        child: Text(skill),
      );
    }).toList(),
    onChanged: onSkillSelected,
  );
}

//scoial media utiltiy

Widget buildSocialMediaDropdown({
  required String? selectedSocialMedia,
  required Function(String?) onSelected,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: PopupMenuButton<String>(
      initialValue: selectedSocialMedia,
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Instagram',
            child: Text('Instagram'),
          ),
          const PopupMenuItem<String>(
            value: 'Twitter',
            child: Text('Twitter'),
          ),
          const PopupMenuItem<String>(
            value: 'LinkedIn',
            child: Text('LinkedIn'),
          ),
          const PopupMenuItem<String>(
            value: 'Dribble',
            child: Text('Dribble'),
          ),
          const PopupMenuItem<String>(
            value: 'Behance',
            child: Text('Behance'),
          ),
          const PopupMenuItem<String>(
            value: 'Diğer',
            child: Text('Diğer'),
          ),
        ];
      },
      onSelected: onSelected,
      child: ListTile(
        title: Text(
          selectedSocialMedia ?? 'Sosyal Medya Hesabı Seçiniz',
        ),
        trailing: const Icon(Icons.arrow_drop_down),
      ),
    ),
  );
}
