import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/presentation/screens/auth/extract_login.dart';

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
  final TextEditingController _aboutmeController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();

  File? _image;
  DateTime? _selectedDate;
  final TextEditingController _emailController = TextEditingController();
  String? _selectedGender;
  String? _selectedMilitaryStatus;
  String? _selectedDisabilityStatus;
  String? _selectedCountry;
  final List<String> _countries = [
    'Türkiye',
    'ABD',
    'Almanya',
    'Fransa',
    'İngiltere'
  ];
  String? _selectedCityId;
  String? _selectedCityName;
  List<Map<String, String>> _cities = [];
  Map<String, List<Map<String, String>>> _cityDistrictMap = {};
  String? _selectedDistrictId;
  String? _selectedDistrictName;

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

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

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    _aboutmeController.dispose();
    _streetController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadCityData() async {
    try {
      final String response =
          await rootBundle.loadString(Assets.filesCitiesJson);
      final List<dynamic> data = json.decode(response);

      setState(() {
        _cities = data
            .map((item) => {
                  "id": item["id"].toString(),
                  "name": item["name"].toString()
                }) // şehir idsi ve ismi
            .toList(); //her bir şehir için map oluşturuyoruz ve bu mapler bir listeye ekleniyor
        _cities.sort((a, b) =>
            a["name"]!.compareTo(b["name"]!)); // alfabetik sıralama  yapıyorum
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
        _cityDistrictMap = {}; // şehir ve ilçe boş olarak oluşturuyoruz
        for (var item in data) {
          String cityId =
              item["il_id"].toString(); //ilçenin ait oldugu şehrin idsi alınır
          if (_cityDistrictMap.containsKey(cityId)) {
            // eğer bu şehir daha önce eklendiyse ilçe şehrin ilçe listesine eklenir
            _cityDistrictMap[cityId]?.add({
              "id": item["id"].toString(),
              "name": item["name"].toString()
            }); // ilçe idsi ve ismi
          } else {
            // eğer ilk defa ekleniyorsa
            _cityDistrictMap[cityId] = [
              // şehrin ilçe listesi olusturulurs
              {"id": item["id"].toString(), "name": item["name"].toString()}
            ];
          }
        }
        _cityDistrictMap.forEach((cityId, districts) {
          districts.sort((a, b) => a["name"]!.compareTo(b["name"]!));
        });
      });
    } catch (e) {
      print('İlçe verileri yüklenirken bir hata oluştu: $e');
    }
  }

  void _onCitySelected(String? newCityId) {
    setState(() {
      _selectedCityId = newCityId;
      _selectedCityName =
          _cities.firstWhere((city) => city["id"] == newCityId)["name"];
      _selectedDistrictId = null;
      _selectedDistrictName = null;
    });
  }

  void _onDistrictSelected(String? newDistrictId) {
    setState(() {
      _selectedDistrictId = newDistrictId;
      _selectedDistrictName = (_cityDistrictMap[_selectedCityId!] ?? [])
          .firstWhere((district) => district["id"] == newDistrictId)["name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Profili'),
      ),
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
                            fit: BoxFit.contain,
                          ),
                        )
                      : Center(
                          child: Image.asset(
                            Assets.imagesDefaultAvatar,
                            width: 120,
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 8),
              TBTInputField(
                hintText: 'Ad',
                controller: _nameController,
                onSaved: (p0) {},
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              TBTInputField(
                hintText: 'Soyad',
                controller: _surnameController,
                onSaved: (p0) {},
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
              ),
              const SizedBox(height: 16),
              TBTInputField(
                  hintText: "E-posta",
                  controller: _emailController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton<String>(
                  initialValue: _selectedGender,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Erkek',
                        child: Text('Erkek'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Kız',
                        child: Text('Kız'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Belirtmek istemiyorum',
                        child: Text('Belirtmek istemiyorum'),
                      ),
                    ];
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  child: ListTile(
                    title: Text(_selectedGender ?? 'Cinsiyet Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton<String>(
                  initialValue: _selectedMilitaryStatus,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Yaptı',
                        child: Text('Yaptı'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Muaf',
                        child: Text('Muaf'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Tecilli',
                        child: Text('Tecilli'),
                      ),
                    ];
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedMilitaryStatus = newValue;
                    });
                  },
                  child: ListTile(
                    title: Text(
                        _selectedMilitaryStatus ?? 'Askerlik Durumu Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton<String>(
                  initialValue: _selectedDisabilityStatus,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Var',
                        child: Text('Var'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Yok',
                        child: Text('Yok'),
                      ),
                    ];
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedDisabilityStatus = newValue;
                    });
                  },
                  child: ListTile(
                    title: Text(_selectedDisabilityStatus ??
                        'Engellilik Durumunu Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton<String>(
                  initialValue: _selectedCountry,
                  itemBuilder: (BuildContext context) {
                    return _countries.map((String country) {
                      return PopupMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList();
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedCountry = newValue;
                    });
                  },
                  child: ListTile(
                    title: Text(_selectedCountry ?? 'Ülke Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton<String>(
                  initialValue: _selectedCityId,
                  itemBuilder: (BuildContext context) {
                    return _cities.map((city) {
                      return PopupMenuItem<String>(
                        value: city["id"]!,
                        child: Text(city["name"]!),
                      );
                    }).toList();
                  },
                  onSelected: _onCitySelected,
                  child: ListTile(
                    title: Text(_selectedCityName ?? 'İl Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedCityId != null
                    ? PopupMenuButton<String>(
                        initialValue: _selectedDistrictId,
                        itemBuilder: (BuildContext context) {
                          return (_cityDistrictMap[_selectedCityId!] ?? [])
                              .map((district) {
                            return PopupMenuItem<String>(
                              value: district["id"]!,
                              child: Text(district["name"]!),
                            );
                          }).toList();
                        },
                        onSelected: _onDistrictSelected,
                        child: ListTile(
                          title: Text(_selectedDistrictName ?? 'İlçe Seçiniz'),
                          trailing: const Icon(Icons.arrow_drop_down),
                        ),
                      )
                    : const ListTile(
                        title: Text('Önce bir il seçiniz'),
                      ),
              ),
              const SizedBox(height: 16),
              TBTInputField(
                hintText: 'Mahalle/Sokak',
                controller: _streetController,
                onSaved: (p0) {},
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              TBTInputField(
                hintText: 'Hakkımda',
                controller: _aboutmeController,
                onSaved: (p0) {},
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
