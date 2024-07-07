import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field2/country_picker_dialog.dart';
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:tobeto/src/domain/export_domain.dart';
import 'package:tobeto/src/models/export_models.dart';
import '../../../../common/export_common.dart';
import '../../../widgets/export_widgets.dart';

class EditPersonalInfoTab extends StatefulWidget {
  const EditPersonalInfoTab({super.key});

  @override
  State<EditPersonalInfoTab> createState() => _EditPersonalInfoTabState();
}

class _EditPersonalInfoTabState extends State<EditPersonalInfoTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _aboutmeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();

  List<Map<String, String>> _cities = [];
  Map<String, List<Map<String, String>>> _cityDistrictMap = {};

  final List<String> _countries = [
    'Türkiye',
    'ABD',
    'Almanya',
    'Fransa',
    'İngiltere'
  ];

  File? _selectedImage;
  DateTime? _selectedDate;
  String? _selectedGender;
  String? _selectedMilitaryStatus;
  String? _selectedDisabilityStatus;
  String? _selectedCountry;
  String? _selectedCityId;
  String? _selectedCityName;
  String? _selectedDistrictName;

  Future<File?> _getImageFromGallery() async {
    final imageFromGallery = await Utilities.getImageFromGallery();
    File? image;
    if (imageFromGallery != null) {
      setState(() {
        image = File(imageFromGallery.path);
      });
    }
    return image;
  }

  Future<String> _updateUser({
    required String? userName,
    required String? userSurname,
    required String? userEmail,
    required String? github,
    required String? userPhoneNumber,
    required DateTime? userBirthDate,
    required String? gender,
    required String? militaryStatus,
    required String? disabilityStatus,
    required String? aboutMe,
    required String? address,
    required String? country,
    required String? city,
    required String? district,
    required File? image,
  }) async {
    UserModel? usermodel = await UserRepository().getCurrentUser();

    RegExp githubRegex = RegExp(
      r'^(https?:\/\/)?(www\.)?github\.com\/[a-zA-Z0-9_-]+$',
    );

    if (_githubController.text.isNotEmpty &&
        !githubRegex.hasMatch(_githubController.text)) {
      return 'Geçersiz GitHub adresi';
    }

    String userAvatarUrl = '';
    if (image == null) {
      userAvatarUrl = usermodel!.userAvatarUrl!;
    } else {
      userAvatarUrl = await FirebaseStorageRepository()
          .updateUserAvatarAndGetUrl(userId: usermodel!.userId, image: image);
    }

    UserModel updatedUser = usermodel.copyWith(
      userName: userName,
      userSurname: userSurname,
      userEmail: userEmail,
      github: github,
      userPhoneNumber: userPhoneNumber,
      userBirthDate: _selectedDate,
      gender: gender,
      militaryStatus: militaryStatus,
      disabilityStatus: disabilityStatus,
      aboutMe: aboutMe,
      address: address,
      country: country,
      city: city,
      district: district,
      userAvatarUrl: userAvatarUrl,
    );

    String result = await UserRepository().addOrUpdateUser(updatedUser);

    return result;
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

  String _onCitySelected(
    String? newCityId,
    List<Map<String, String>> cities,
  ) {
    _selectedCityId = newCityId;
    String? cityName = '';
    cityName = cities.firstWhere((city) => city["id"] == newCityId)["name"];
    _selectedCityId = newCityId;

    return cityName!;
  }

  void _onDistrictSelected(String? newDistrictId) {
    setState(() {
      _selectedDistrictName = (_cityDistrictMap[_selectedCityId!] ?? [])
          .firstWhere((district) => district["id"] == newDistrictId)["name"];
    });
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
    _birthDateController.dispose();
    _aboutmeController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                _nameController.text = authState.userModel.userName;
                _surnameController.text = authState.userModel.userSurname;
                _phoneController.text =
                    authState.userModel.userPhoneNumber ?? '';
                _birthDateController.text = DateFormat('dd/MM/yyyy')
                    .format(authState.userModel.userBirthDate!);
                _aboutmeController.text = authState.userModel.aboutMe ?? '';
                _addressController.text = authState.userModel.address ?? '';
                _emailController.text = authState.userModel.userEmail;
                _githubController.text = authState.userModel.github ?? '';

                _selectedGender ??= authState.userModel.gender;
                _selectedDisabilityStatus ??=
                    authState.userModel.disabilityStatus;
                _selectedMilitaryStatus ??= authState.userModel.militaryStatus;

                _selectedCountry ??= authState.userModel.country;
                _selectedCityName ??= authState.userModel.city;
                _selectedDistrictName ??= authState.userModel.district;

                return Column(
                  children: [
                    // avatar
                    GestureDetector(
                      onTap: () async {
                        _selectedImage = await _getImageFromGallery();
                      },
                      child: _selectedImage != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(_selectedImage!),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                authState.userModel.userAvatarUrl!,
                              ),
                            ),
                    ),
                    // ad
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TBTInputField(
                        hintText: 'Ad',
                        controller: _nameController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    // soyad
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TBTInputField(
                        hintText: 'Soyad',
                        controller: _surnameController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    // telefon
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                            initialCountryCode: 'TR',
                            onChanged: (phone) {},
                          ),
                        ],
                      ),
                    ),
                    // dogum tarihi
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        controller: _birthDateController,
                        decoration: InputDecoration(
                          labelText: 'Doğum Tarihi',
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          border: const UnderlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          _selectedDate = await Utilities.datePicker(context);
                        },
                      ),
                    ),
                    // eposta
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TBTInputField(
                        hintText: "E-posta",
                        controller: _emailController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    // github
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TBTInputField(
                        hintText: "Github adresi",
                        controller: _githubController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.url,
                        isGithubField: true,
                      ),
                    ),
                    // gender
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Kız',
                              child: Text(
                                'Kız',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Belirtmek istemiyorum',
                              child: Text(
                                'Belirtmek istemiyorum',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
                    // military status
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Muaf',
                              child: Text(
                                'Muaf',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Tecilli',
                              child: Text(
                                'Tecilli',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
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
                            _selectedMilitaryStatus ??
                                'Askerlik Durumu Seçiniz',
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
                    // disability
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'Var',
                              child: Text(
                                'Var',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
                    // country
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
                          ),
                          titleTextStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          trailing: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                        ),
                      ),
                    ),
                    // city
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton<String>(
                        color: Theme.of(context).colorScheme.background,
                        initialValue: _selectedCityName,
                        itemBuilder: (BuildContext context) {
                          return _cities.map((city) {
                            return PopupMenuItem<String>(
                              value: city["id"],
                              child: Text(
                                city["name"]!,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            );
                          }).toList();
                        },
                        onSelected: (value) {
                          setState(() {
                            _selectedCityName = _onCitySelected(value, _cities);
                          });
                        },
                        child: ListTile(
                          title: Text(
                            _selectedCityName ?? 'İl Şeçiniz',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                        ),
                      ),
                    ),
                    // ilçe
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton<String>(
                        color: Theme.of(context).colorScheme.background,
                        initialValue: _selectedDistrictName,
                        itemBuilder: (BuildContext context) {
                          if (_selectedCityId == null ||
                              !_cityDistrictMap.containsKey(_selectedCityId)) {
                            return <PopupMenuItem<String>>[];
                          }
                          return (_cityDistrictMap[_selectedCityId] ?? [])
                              .map((district) {
                            return PopupMenuItem<String>(
                              value: district["id"],
                              child: Text(
                                district["name"]!,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            );
                          }).toList();
                        },
                        onSelected: _onDistrictSelected,
                        child: ListTile(
                          title: Text(
                            _selectedDistrictName ?? 'İlçe Seçiniz',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                        ),
                      ),
                    ),
                    // açık adres
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TBTInputField(
                        hintText: 'Açık adresinizi giriniz',
                        controller: _addressController,
                        onSaved: (p0) {},
                        keyboardType: TextInputType.streetAddress,
                        minLines: 3,
                        maxLines: 3,
                      ),
                    ),
                    // hakkımda
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

                    // kaydet
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TBTPurpleButton(
                        buttonText: 'Kaydet',
                        onPressed: () async {
                          String result = await _updateUser(
                            userEmail: _emailController.text.trim(),
                            userName: _nameController.text.trim(),
                            userSurname: _surnameController.text.trim(),
                            userPhoneNumber: _phoneController.text.trim(),
                            country: _selectedCountry,
                            city: _selectedCityName,
                            district: _selectedDistrictName,
                            address: _addressController.text.trim(),
                            aboutMe: _aboutmeController.text.trim(),
                            disabilityStatus: _selectedDisabilityStatus,
                            militaryStatus: _selectedMilitaryStatus,
                            gender: _selectedGender,
                            github: _githubController.text.trim(),
                            userBirthDate: _selectedDate,
                            image: _selectedImage,
                          );

                          Utilities.showToast(toastMessage: result);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
