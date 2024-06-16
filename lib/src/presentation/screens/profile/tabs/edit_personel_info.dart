import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/constants/utilities.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/purple_button.dart';
import 'package:tobeto/src/models/user_model.dart';

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
  final TextEditingController _emailController = TextEditingController();

  File? _image;
  DateTime? _selectedDate;
  String? _selectedGender;
  String? _selectedMilitaryStatus;
  String? _selectedDisabilityStatus;
  String? _selectedCountry;
  String? _selectedCityId;
  String? _selectedCityName;
  String? _selectedDistrictId;
  String? _selectedDistrictName;

  List<Map<String, String>> _cities = [];
  Map<String, List<Map<String, String>>> _cityDistrictMap = {};

  final List<String> _countries = [
    'Türkiye',
    'ABD',
    'Almanya',
    'Fransa',
    'İngiltere'
  ];

  final UserRepository _userRepository = UserRepository();

  Future<void> _loadUserData() async {
    UserModel? user = await UserRepository().getCurrentUser();
    if (user != null) {
      setState(() {
        _nameController.text = user.userName;
        _surnameController.text = user.userSurname;
        _emailController.text = user.userEmail;
        _phoneController.text = user.userPhoneNumber ?? '';
        _dateController.text = user.userBirthDate != null
            ? DateFormat('dd/MM/yyyy').format(user.userBirthDate!)
            : '';
        _aboutmeController.text = user.aboutMe ?? '';
        _selectedGender = user.gender;
        _selectedMilitaryStatus = user.militaryStatus;
        _selectedDisabilityStatus = user.disabilityStatus;
      });
    } else {
      print("getUser returned null");
    }
  }

  Future<void> _getImageFromGallery() async {
    final image = await PersonalInfoUtil.getImageFromGallery();
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = await PersonalInfoUtil.selectDate(context);
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  Future<void> _loadCityData() async {
    final cities = await PersonalInfoUtil.loadCityData();
    setState(() {
      _cities = cities;
    });
  }

  Future<void> _loadDistrictData() async {
    final cityDistrictMap = await PersonalInfoUtil.loadDistrictData();
    setState(() {
      _cityDistrictMap = cityDistrictMap;
    });
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

  void _updateUser() async {
    UserModel? usermodel = await UserRepository().getCurrentUser();
    try {
      if (usermodel != null) {
        UserModel updatedUser = usermodel.copyWith(
          userName: _nameController.text,
          userSurname: _surnameController.text,
          userEmail: _emailController.text,
          userPhoneNumber: _phoneController.text,
          userBirthDate: _selectedDate,
          gender: _selectedGender,
          militaryStatus: _selectedMilitaryStatus,
          disabilityStatus: _selectedDisabilityStatus,
          aboutMe: _aboutmeController.text,
        );
        await _userRepository.addOrUpdateUser(updatedUser);

        _loadUserData();
      } else {
        throw Exception('Kullanıcı oturumu açmamış.');
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCityData();
    _loadDistrictData();
    _loadUserData();
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: 'Ad',
                  controller: _nameController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: 'Soyad',
                  controller: _surnameController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    IntlPhoneField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Telefon Numaranız',
                      ),
                      initialCountryCode: 'TR',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                        : '',
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Doğum Tarihi',
                    hintText: 'Doğum Tarihi Seçiniz',
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "E-posta",
                  controller: _emailController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  initialValue: _selectedDisabilityStatus,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Yok',
                        child: Text('Yok'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Var',
                        child: Text('Var'),
                      ),
                    ];
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedDisabilityStatus = newValue;
                    });
                  },
                  child: ListTile(
                    title: Text(
                        _selectedDisabilityStatus ?? 'Engel Durumu Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  initialValue: _selectedCountry,
                  itemBuilder: (BuildContext context) {
                    return _countries.map((country) {
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  initialValue: _selectedCityId,
                  itemBuilder: (BuildContext context) {
                    return _cities.map((city) {
                      return PopupMenuItem<String>(
                        value: city["id"],
                        child: Text(city["name"]!),
                      );
                    }).toList();
                  },
                  onSelected: _onCitySelected,
                  child: ListTile(
                    title: Text(_selectedCityName ?? 'İl Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  initialValue: _selectedDistrictId,
                  itemBuilder: (BuildContext context) {
                    return (_cityDistrictMap[_selectedCityId] ?? [])
                        .map((district) {
                      return PopupMenuItem<String>(
                        value: district["id"],
                        child: Text(district["name"]!),
                      );
                    }).toList();
                  },
                  onSelected: _onDistrictSelected,
                  child: ListTile(
                    title: Text(_selectedDistrictName ?? 'İlçe Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: 'Mahalle/Sokak',
                  controller: _streetController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.streetAddress,
                  minLines: 3,
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: 'Hakkımda',
                  controller: _aboutmeController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTPurpleButton(
                  buttonText: 'Kaydet',
                  onPressed: _updateUser,
                ),
              ),
              const SizedBox(
                height: 50, // Bottom Navigation bar Yüksekliği için!
              )
            ],
          ),
        ),
      ),
    );
  }
}
