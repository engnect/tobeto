import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field2/country_picker_dialog.dart';
import 'package:intl_phone_field2/intl_phone_field.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:tobeto/src/domain/export_domain.dart';
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
  final TextEditingController _aboutMeController = TextEditingController();
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
    _aboutMeController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _githubController.dispose();
    super.dispose();
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

  Future<File?> _getImageFromGallery() async {
    final imageFromGallery = await Utilities.getImageFromGallery();
    if (imageFromGallery != null) {
      setState(() {
        _selectedImage = File(imageFromGallery.path);
      });
    }
    return _selectedImage;
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
    final usermodel = await UserRepository().getCurrentUser();
    final githubRegex =
        RegExp(r'^(https?:\/\/)?(www\.)?github\.com\/[a-zA-Z0-9_-]+$');

    if (_githubController.text.isNotEmpty &&
        !githubRegex.hasMatch(_githubController.text)) {
      return 'Geçersiz GitHub adresi';
    }

    final userAvatarUrl = image == null
        ? usermodel!.userAvatarUrl!
        : await FirebaseStorageRepository()
            .updateUserAvatarAndGetUrl(userId: usermodel!.userId, image: image);

    final updatedUser = usermodel.copyWith(
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

    return await UserRepository().addOrUpdateUser(updatedUser);
  }

  String _onCitySelected(String? newCityId, List<Map<String, String>> cities) {
    _selectedCityId = newCityId;
    return cities.firstWhere((city) => city["id"] == newCityId)["name"]!;
  }

  void _onDistrictSelected(String? newDistrictId) {
    setState(() {
      _selectedDistrictName = (_cityDistrictMap[_selectedCityId!] ?? [])
          .firstWhere((district) => district["id"] == newDistrictId)["name"];
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int minLines = 1,
    int maxLines = 1,
    bool isGithubField = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TBTInputField(
        hintText: hintText,
        controller: controller,
        onSaved: (value) {},
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        isGithubField: isGithubField,
      ),
    );
  }

  Widget _buildPopupMenu({
    required String? selectedValue,
    required List<String> options,
    required String hintText,
    required void Function(String?) onSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PopupMenuButton<String>(
        color: Theme.of(context).colorScheme.background,
        initialValue: selectedValue,
        itemBuilder: (context) {
          return options.map((option) {
            return PopupMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList();
        },
        onSelected: onSelected,
        child: ListTile(
          title: Text(selectedValue ?? hintText),
          titleTextStyle:
              TextStyle(color: Theme.of(context).colorScheme.primary),
          trailing: Icon(Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.primary),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        ),
      ),
    );
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
                _aboutMeController.text = authState.userModel.aboutMe ?? '';
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
                    GestureDetector(
                      onTap: () async {
                        _selectedImage = await _getImageFromGallery();
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : NetworkImage(authState.userModel.userAvatarUrl!)
                                as ImageProvider,
                      ),
                    ),
                    _buildTextField(
                        controller: _nameController, hintText: 'Ad'),
                    _buildTextField(
                        controller: _surnameController, hintText: 'Soyad'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IntlPhoneField(
                        controller: _phoneController,
                        pickerDialogStyle: PickerDialogStyle(
                            backgroundColor:
                                Theme.of(context).colorScheme.background),
                        dropdownTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        controller: _birthDateController,
                        decoration: InputDecoration(
                          labelText: 'Doğum Tarihi',
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                          contentPadding: const EdgeInsets.all(12),
                          border: const UnderlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        readOnly: true,
                        onTap: () async {
                          _selectedDate = await Utilities.datePicker(context);
                        },
                      ),
                    ),
                    _buildTextField(
                        controller: _emailController,
                        hintText: "E-posta",
                        keyboardType: TextInputType.emailAddress),
                    _buildTextField(
                        controller: _githubController,
                        hintText: "Github adresi",
                        keyboardType: TextInputType.url,
                        isGithubField: true),
                    _buildPopupMenu(
                      selectedValue: _selectedGender,
                      options: ['Erkek', 'Kız', 'Belirtmek istemiyorum'],
                      hintText: 'Cinsiyet Seçiniz',
                      onSelected: (newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                    _buildPopupMenu(
                      selectedValue: _selectedMilitaryStatus,
                      options: ['Yaptı', 'Muaf', 'Tecilli'],
                      hintText: 'Askerlik Durumu Seçiniz',
                      onSelected: (newValue) {
                        setState(() {
                          _selectedMilitaryStatus = newValue;
                        });
                      },
                    ),
                    _buildPopupMenu(
                      selectedValue: _selectedDisabilityStatus,
                      options: ['Yok', 'Var'],
                      hintText: 'Engel Durumu Seçiniz',
                      onSelected: (newValue) {
                        setState(() {
                          _selectedDisabilityStatus = newValue;
                        });
                      },
                    ),
                    _buildPopupMenu(
                      selectedValue: _selectedCountry,
                      options: _countries,
                      hintText: 'Ülke Seçiniz',
                      onSelected: (newValue) {
                        setState(() {
                          _selectedCountry = newValue;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton<String>(
                        color: Theme.of(context).colorScheme.background,
                        initialValue: _selectedCityName,
                        itemBuilder: (context) {
                          return _cities.map((city) {
                            return PopupMenuItem<String>(
                              value: city["id"],
                              child: Text(
                                city["name"]!,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
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
                          title: Text(_selectedCityName ?? 'İl Şeçiniz',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          trailing: Icon(Icons.arrow_drop_down,
                              color: Theme.of(context).colorScheme.primary),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PopupMenuButton<String>(
                        color: Theme.of(context).colorScheme.background,
                        initialValue: _selectedDistrictName,
                        itemBuilder: (context) {
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
                          title: Text(_selectedDistrictName ?? 'İlçe Seçiniz',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          trailing: Icon(Icons.arrow_drop_down,
                              color: Theme.of(context).colorScheme.primary),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                        ),
                      ),
                    ),
                    _buildTextField(
                        controller: _addressController,
                        hintText: 'Açık adresinizi giriniz',
                        keyboardType: TextInputType.streetAddress,
                        minLines: 3,
                        maxLines: 3),
                    _buildTextField(
                        controller: _aboutMeController,
                        hintText: 'Hakkımda',
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 3),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TBTPurpleButton(
                        buttonText: 'Kaydet',
                        onPressed: () async {
                          final result = await _updateUser(
                            userEmail: _emailController.text.trim(),
                            userName: _nameController.text.trim(),
                            userSurname: _surnameController.text.trim(),
                            userPhoneNumber: _phoneController.text.trim(),
                            country: _selectedCountry,
                            city: _selectedCityName,
                            district: _selectedDistrictName,
                            address: _addressController.text.trim(),
                            aboutMe: _aboutMeController.text.trim(),
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
                    const SizedBox(height: 50),
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
