import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/utilities.dart';
import 'package:tobeto/src/domain/repositories/auth_repository.dart';
import 'package:tobeto/src/domain/repositories/experience_repository.dart';
import 'package:tobeto/src/models/experience_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/screens/profile/padded_widget';
import '../../../widgets/input_field.dart';
import '../../../widgets/purple_button.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({Key? key}) : super(key: key);

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _jobdescrbController = TextEditingController();

  String? _selectedExperienceType;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  bool _isCurrentlyWorking = false;
  bool isSelect = false;

  late Future<List<ExperienceModel>> _experiencesFuture;

  @override
  void initState() {
    super.initState();
    _fetchExperiences();
    _experiencesFuture = _loadExperiences();
  }

  Future<List<ExperienceModel>> _loadExperiences() async {
    UserModel? user = await AuthRepository().getCurrentUser();
    if (user != null) {
      return await ExperienceRepository().getUserExperiences(user.userId);
    }
    return [];
  }

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _sectorController.dispose();
    _cityController.dispose();
    _jobdescrbController.dispose();
    super.dispose();
  }

  Future<void> _fetchExperiences() async {
    UserModel? user = await AuthRepository().getCurrentUser();
    if (user != null) {
      setState(() {
        _experiencesFuture =
            ExperienceRepository().getUserExperiences(user.userId);
      });
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final selectedDate = await ExperienceUtil.selectStartDate(context);
    if (selectedDate != null) {
      setState(() {
        _selectedStartDate = selectedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final selectedDate = await ExperienceUtil.selectEndDate(context);
    if (selectedDate != null) {
      setState(() {
        _selectedEndDate = selectedDate;
      });
    }
  }

  void _saveExperience() async {
    UserModel? user = await AuthRepository().getCurrentUser();

    try {
      ExperienceModel newExperience = ExperienceModel(
        experienceId: '',
        userId: user.userId,
        companyName: _companyController.text,
        experiencePosition: _positionController.text,
        experienceType: _selectedExperienceType ?? '',
        experienceSector: _sectorController.text,
        experienceCity: _cityController.text,
        startDate: _selectedStartDate!,
        endDate: _isCurrentlyWorking ? DateTime.now() : _selectedEndDate!,
        isCurrentlyWorking: _isCurrentlyWorking,
        jobDescription: _jobdescrbController.text,
      );

      print('New Experience Data: ${newExperience.toMap()}');

      await ExperienceRepository().addExperience(newExperience);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Experience added successfully')),
      );

      _fetchExperiences(); 
    } catch (e, stackTrace) {
      print('Failed to add experience: $e');
      print(stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add experience: $e')),
      );
      return;
    }
  }

 Future<void> _deleteExperience(String experienceId) async {
  try {
    await ExperienceRepository().deleteExperience(experienceId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Experience deleted successfully')),
    );
    _fetchExperiences(); 
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete experience: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PaddedWidget(
          padding: 16.0,
          child: Column(
            children: [
              TBTPurpleButton(
                buttonText: "Düzenle",
                onPressed: () {
                  setState(() {
                    isSelect = !isSelect;
                  });
                },
              ),
              AnimatedContainer(
                decoration: BoxDecoration(
                  borderRadius: isSelect
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                      : null,
                  border: Border(
                    bottom: BorderSide(
                      width: isSelect ? 7 : 0,
                      color: const Color.fromARGB(255, 153, 51, 255),
                    ),
                  ),
                ),
                height: isSelect ? 600 : 0,
                duration: const Duration(seconds: 1),
                child: isSelect
                    ? FutureBuilder<List<ExperienceModel>>(
                        future: _experiencesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Hata: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('Henüz bir deneyim eklenmedi.'));
                          } else {
                            List<ExperienceModel> experiences = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: experiences.length,
                              itemBuilder: (context, index) {
                                ExperienceModel experience = experiences[index];
                                return Card(
                                  child: ListTile(
                                    title: Text(experience.companyName),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(experience.experiencePosition),
                                        Text(
                                          'Başlangıç Tarihi: ${DateFormat('dd/MM/yyyy').format(experience.startDate)}',
                                        ),
                                        Text(
                                          experience.isCurrentlyWorking!
                                              ? 'Devam Ediyor'
                                              : 'Bitiş Tarihi: ${DateFormat('dd/MM/yyyy').format(experience.endDate)}',
                                        ),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            // Düzenleme işlemleri burada yapılabilir
                                            // Örneğin, seçilen experience'ı form alanlarına doldurabilirsiniz
                                            setState(() {
                                              _companyController.text =
                                                  experience.companyName;
                                              _positionController.text =
                                                  experience.experiencePosition;
                                              _selectedExperienceType =
                                                  experience.experienceType;
                                              _sectorController.text =
                                                  experience.experienceSector;
                                              _cityController.text =
                                                  experience.experienceCity;
                                              _selectedStartDate =
                                                  experience.startDate;
                                              _selectedEndDate = experience.endDate;
                                              _isCurrentlyWorking =
                                                  experience.isCurrentlyWorking!;
                                              _jobdescrbController.text =
                                                  experience.jobDescription!;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            showDialog(
                                              context: context, 
                                              builder: (context) => AlertDialog(
                                                title: const Text("Deneyimi sil"),
                                                content: const Text("Bu dneyimi silmek istediğinizden emin msiniz?"),
                                                actions: [ 
                                                  TextButton(onPressed: () => Navigator.pop(context), child: const Text("İptal"),
                                                  ), 
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      print("Silmek istediğim fonks: ${experience.experienceId}");
                                                      await _deleteExperience(
                                                          "kJSDjJXEpmsOEfyyPasX");
                                                    },
                                                    child: const Text('Sil'),
                                                  ),
                                                ],

                                              )
                                              );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )
                    : const SizedBox.shrink(),
              ),
              PaddedWidget(
                child: TBTInputField(
                  hintText: "Kurum Adı",
                  controller: _companyController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              PaddedWidget(
                child: TBTInputField(
                  hintText: "Pozisyon",
                  controller: _positionController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              PaddedWidget(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    underline: const SizedBox(),
                    isExpanded: true,
                    value: _selectedExperienceType,
                    hint: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Deneyim Türünü Seçin'),
                    ),
                    items: <String>['Tam Zamanlı', 'Yarı Zamanlı', 'Staj']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedExperienceType = newValue;
                      });
                    },
                  ),
                ),
              ),
              PaddedWidget(
                child: TBTInputField(
                  hintText: "Sektör",
                  controller: _sectorController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              PaddedWidget(
                child: TBTInputField(
                  hintText: "Şehir",
                  controller: _cityController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              PaddedWidget(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _selectStartDate(context),
                                child: AbsorbPointer(
                                  child: TBTInputField(
                                    hintText: _selectedStartDate != null
                                        ? DateFormat('dd/MM/yyyy')
                                            .format(_selectedStartDate!)
                                        : 'Başlangıç Tarihi',
                                    controller: TextEditingController(
                                      text: _selectedStartDate != null
                                          ? DateFormat('dd/MM/yyyy')
                                              .format(_selectedStartDate!)
                                          : '',
                                    ),
                                    onSaved: (p0) {},
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: _isCurrentlyWorking
                                    ? null
                                    : () => _selectEndDate(context),
                                child: AbsorbPointer(
                                  child: TBTInputField(
                                    hintText: _isCurrentlyWorking
                                        ? 'Devam Ediyor'
                                        : _selectedEndDate != null
                                            ? DateFormat('dd/MM/yyyy')
                                                .format(_selectedEndDate!)
                                            : 'Bitiş Tarihi',
                                    controller: TextEditingController(
                                      text: _isCurrentlyWorking
                                          ? 'Devam Ediyor'
                                          : _selectedEndDate != null
                                              ? DateFormat('dd/MM/yyyy')
                                                  .format(_selectedEndDate!)
                                              : '',
                                    ),
                                    
                                    onSaved: (p0) {},
                                    keyboardType: TextInputType.datetime,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              PaddedWidget(
                child: Row(
                  children: [
                    Checkbox(
                      value: _isCurrentlyWorking,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isCurrentlyWorking = newValue!;
                        });
                      },
                    ),
                    const Text('Çalışmaya devam ediyorum.'),
                  ],
                ),
              ),
              PaddedWidget(
                child: TBTInputField(
                  hintText: "İş Tanımı",
                  controller: _jobdescrbController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: _saveExperience,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
