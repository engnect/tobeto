import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field2/country_picker_dialog.dart';
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/firebase_storage_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import '../../../widgets/tbt_input_field.dart';
import '../../../widgets/tbt_purple_button.dart';
import 'package:tobeto/src/models/user_model.dart';

class EditPersonalInfoTab extends StatefulWidget {
  const EditPersonalInfoTab({super.key});

  @override
  State<EditPersonalInfoTab> createState() => _EditPersonalInfoTabState();
}

class _EditPersonalInfoTabState extends State<EditPersonalInfoTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _aboutmeController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();

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

  Future<void> _loadUserData() async {
    UserModel? user = await UserRepository().getCurrentUser();
    if (user != null) {
      setState(() {
        _nameController.text = user.userName;
        _surnameController.text = user.userSurname;
        _emailController.text = user.userEmail;
        _githubController.text = user.github ?? '';
        _phoneController.text = user.userPhoneNumber ?? '';
        _dateController.text = user.userBirthDate != null
            ? DateFormat('dd/MM/yyyy').format(user.userBirthDate!)
            : '';
        _aboutmeController.text = user.aboutMe ?? '';
        _streetController.text = user.address ?? '';
        _selectedGender = user.gender;
        _selectedMilitaryStatus = user.militaryStatus;
        _selectedDisabilityStatus = user.disabilityStatus;
        _selectedCountry = user.country;
        _selectedCityName = user.city;
        _selectedDistrictName = user.district;
      });
    } else {
      if (kDebugMode) {
        print("getUser returned null");
      }
    }
  }

  Future<void> _getImageFromGallery() async {
    final image = await Utilities.getImageFromGallery();
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final selectedDate = await Utilities.datePicker(context);
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  Future<void> _loadCityData() async {
    final cities = await Utilities.loadCityData();
    setState(() {
      _cities = cities;
    });
  }

  Future<void> _loadDistrictData() async {
    final cityDistrictMap = await Utilities.loadDistrictData();
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

  Future<String> _updateUser(File? image) async {
    UserModel? usermodel = await UserRepository().getCurrentUser();

    String userAvatarUrl = await FirebaseStorageRepository()
        .getDefaultAvatarUrl(userId: usermodel!.userId, image: image);

    UserModel updatedUser = usermodel.copyWith(
      userName: _nameController.text,
      userSurname: _surnameController.text,
      userEmail: _emailController.text,
      github: _githubController.text,
      userPhoneNumber: _phoneController.text,
      userBirthDate: _selectedDate,
      gender: _selectedGender,
      militaryStatus: _selectedMilitaryStatus,
      disabilityStatus: _selectedDisabilityStatus,
      aboutMe: _aboutmeController.text,
      address: _streetController.text,
      country: _selectedCountry,
      city: _selectedCityName,
      district: _selectedDistrictName,
      userAvatarUrl: userAvatarUrl,
    );
    String result = await UserRepository().addOrUpdateUser(updatedUser);

    _loadUserData();

    return result;
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
            children: [
              InkWell(
                onTap: () {
                  _getImageFromGallery();
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(),
                  child: _image != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(_image!),
                        )
                      : BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is Authenticated) {
                              return CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  state.userModel.userAvatarUrl!,
                                ),
                              );
                            }
                            return Center(
                              child: Image.asset(
                                Assets.imagesDefaultAvatar,
                                width: 120,
                                height: 120,
                                fit: BoxFit.contain,
                              ),
                            );
                          },
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
                      pickerDialogStyle: PickerDialogStyle(
                          backgroundColor:
                              Theme.of(context).colorScheme.background),
                      dropdownTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                      decoration: InputDecoration(
                        labelText: 'Telefon Numaranız',
                        labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      initialCountryCode: 'TR',
                      onChanged: (phone) {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                        : '',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Doğum Tarihi',
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    hintText: 'Doğum Tarihi Seçiniz',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
                child: TBTInputField(
                  hintText: "Github adresi",
                  controller: _githubController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.url,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  color: Theme.of(context).colorScheme.background,
                  initialValue: _selectedGender,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Erkek',
                        child: Text(
                          'Erkek',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Kız',
                        child: Text(
                          'Kız',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Belirtmek istemiyorum',
                        child: Text(
                          'Belirtmek istemiyorum',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ];
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  child: ListTile(
                    title: Text(
                      _selectedGender ?? 'Cinsiyet Seçiniz',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  color: Theme.of(context).colorScheme.background,
                  initialValue: _selectedMilitaryStatus,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Yaptı',
                        child: Text(
                          'Yaptı',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Muaf',
                        child: Text('Muaf',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary)),
                      ),
                      PopupMenuItem<String>(
                        value: 'Tecilli',
                        child: Text('Tecilli',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary)),
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
                      _selectedMilitaryStatus ?? 'Askerlik Durumu Seçiniz',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  color: Theme.of(context).colorScheme.background,
                  initialValue: _selectedDisabilityStatus,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Yok',
                        child: Text(
                          'Yok',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Var',
                        child: Text(
                          'Var',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
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
                      _selectedDisabilityStatus ?? 'Engel Durumu Seçiniz',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  color: Theme.of(context).colorScheme.background,
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
                    title: Text(
                      _selectedCountry ?? 'Ülke Seçiniz',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  color: Theme.of(context).colorScheme.background,
                  initialValue: _selectedCityId,
                  itemBuilder: (BuildContext context) {
                    return _cities.map((city) {
                      return PopupMenuItem<String>(
                        value: city["id"],
                        child: Text(
                          city["name"]!,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      );
                    }).toList();
                  },
                  onSelected: _onCitySelected,
                  child: ListTile(
                    title: Text(
                      _selectedCityName ?? 'İl Seçiniz',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  color: Theme.of(context).colorScheme.background,
                  initialValue: _selectedDistrictId,
                  itemBuilder: (BuildContext context) {
                    return (_cityDistrictMap[_selectedCityId] ?? [])
                        .map((district) {
                      return PopupMenuItem<String>(
                        value: district["id"],
                        child: Text(
                          district["name"]!,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      );
                    }).toList();
                  },
                  onSelected: _onDistrictSelected,
                  child: ListTile(
                    title: Text(
                      _selectedDistrictName ?? 'İlçe Seçiniz',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
                  onPressed: () async {
                    String result = await _updateUser(_image);
                    if (!context.mounted) return;
                    Utilities.showSnackBar(
                        snackBarMessage: result, context: context);
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
