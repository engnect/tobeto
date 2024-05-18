// ignore_for_file: avoid_print, unused_field

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'package:tobeto/constants/assets.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  File? _image;
  DateTime? _selectedDate;
  final TextEditingController _emailController = TextEditingController();
  String? _selectedGender;
  String? _selectedMilitaryStatus;
  String? _selectedDisabilityStatus;
  final TextEditingController _githubController = TextEditingController();
  String? _selectedCountry;
  final List<String> _countries = [
    'Türkiye',
    'ABD',
    'Almanya',
    'Fransa',
    'İngiltere'
  ];
  String? _selectedCity;
  List<String> _cities = [];
  List<String> _districts = [];
  String? _selectedDistricts;

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Tarih seçiciyi açma fonksiyonu
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCityData();
    _loadDistrictData();
  }

  Future<void> _loadCityData() async {
    try {
      final String response =
          await rootBundle.loadString(Assets.filesCitiesJson);
      print(response);

      final List<dynamic> data = json.decode(response);

      setState(() {
        _cities = data.map((item) => item['name'].toString()).toList();
      });
    } catch (e) {
      print('Şehir verileri yüklenirken bir hata oluştu: $e');
    }
  }

  Future<void> _loadDistrictData() async {
    try {
      final String response =
          await rootBundle.loadString(Assets.filesDistrictJson);

      final List<dynamic> data = json.decode(response);

      setState(() {
        _districts = data.map((item) => item['name'].toString()).toList();
      });
    } catch (e) {
      print('İlçe verileri yüklenirken bir hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  _getImageFromGallery();
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: _image != null
                      ? ClipOval(
                          child: Image.file(
                            _image!,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Center(
                          child: Image.asset(
                            Assets.imagesDefaultAvatar,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),

              Text('Ad', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ad',
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Soyad', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Soyad',
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Telefon numarası alanı
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telefon Numaranız',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    IntlPhoneField(
                      decoration: const InputDecoration(
                        labelText: 'Telefon Numaranız',
                        border: OutlineInputBorder(),
                      ),
                      initialCountryCode: 'TR',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                  ],
                ),
              ),

              // Doğum tarihi seçici alanı
              TextFormField(
                controller: TextEditingController(
                  text: _selectedDate != null
                      ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                      : '',
                ),
                decoration: InputDecoration(
                  labelText: 'Doğum Tarihi',
                  hintText: 'Doğum Tarihi Seçiniz',
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true, //manuel girişi engelledim
                onTap: () {
                  _selectDate(context);
                },
              ),

              const SizedBox(height: 16),
              // E-posta giriş alanı
              Text('E-posta', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'E-posta',
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              const SizedBox(height: 16),
              // Cinsiyet seçici alanı
              Text('Cinsiyet', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                items: <String>['Erkek', 'Kız', 'Belirtmek istemiyorum']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cinsiyet Seçiniz',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),

              //aSKERLİK
              const SizedBox(height: 16),
              Text('Askerlik Durumu',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedMilitaryStatus,
                onChanged: (newValue) {
                  setState(() {
                    _selectedMilitaryStatus = newValue;
                  });
                },
                items: <String>['Yaptı', 'Muaf', 'Tecilli']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Askerlik Durumu Seçiniz',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              Text('Engellilik Durumu',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedDisabilityStatus,
                onChanged: (newValue) {
                  setState(() {
                    _selectedDisabilityStatus = newValue;
                  });
                },
                items: <String>['Var', 'Yok']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Engellilik Durumunu Seçiniz',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              // GitHub adresi giriş alanı
              Text('GitHub Adresi',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'GitHub Adresi',
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Text('Ülke', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCountry = newValue;
                  });
                },
                items:
                    _countries.map<DropdownMenuItem<String>>((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ülke Seçiniz',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              Text('İl', style: Theme.of(context).textTheme.titleMedium),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCity = newValue;
                  });
                },
                items: _cities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'İl Seçiniz',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),

              const SizedBox(height: 16),
              Text('İlçe', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'İlçe',
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                  ),
                  items: _districts.map((String district) {
                    return DropdownMenuItem<String>(
                      value: district,
                      child: Text(district),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {});
                  },
                ),
              ),

              const SizedBox(height: 16),
              Text('Mahalle/Sokak',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  maxLines: null, // Birden fazla satır girilebilmesini sağlıyo
                  keyboardType: TextInputType
                      .multiline, // Birden fazla satır girebilmesi için gerekli olan klavye türü
                  decoration: const InputDecoration(
                    labelText: 'Mahalle/Sokak',
                    contentPadding: EdgeInsets.all(40),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Hakkımda', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Hakkımda',
                    contentPadding: EdgeInsets.all(40),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // PersonalInfo personalInfo = PersonalInfo(
                  //   name: _nameController.text,
                  //   surname: _surnameController.text,
                  //   phoneNumber: _phoneController.text,
                  //   email: _emailController.text,
                  //   gender: _selectedGender,
                  //   militaryStatus: _selectedMilitaryStatus,
                  //   disabilityStatus: _selectedDisabilityStatus,
                  //   github: _githubController.text,
                  //   country: _selectedCountry,
                  //   city: _selectedCity,
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(153, 51, 255, 1),
                ),
                child: const Text("Kaydet",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
