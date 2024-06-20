import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/constants/utilities.dart';
import 'package:tobeto/src/domain/repositories/experience_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/experience_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/widgets/edit_experience_dialog.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/purple_button.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

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

  List<Map<String, String>> _cities = [];
  String? _selectedCityId;
  String? _selectedCityName;

  @override
  void initState() {
    super.initState();
    _loadCityData();
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

  Future<void> _loadCityData() async {
    // Verileri yükleme kodu burada olacak
    final cities = await PersonalInfoUtil.loadCityData();
    setState(() {
      _cities = cities;
    });
  }

  void _onCitySelected(String? newCityId) {
    setState(() {
      _selectedCityId = newCityId;
      _selectedCityName =
          _cities.firstWhere((city) => city["id"] == newCityId)["name"];
    });
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

  // void _saveExperience() async {
  //   UserModel? user = await UserRepository().getCurrentUser();

  //   try {
  //     ExperienceModel newExperience = ExperienceModel(
  //       experienceId: '',
  //       userId: user!.userId,
  //       companyName: _companyController.text,
  //       experiencePosition: _positionController.text,
  //       experienceType: _selectedExperienceType ?? '',
  //       experienceSector: _sectorController.text,
  //       experienceCity: _selectedCityName ?? '',
  //       startDate: _selectedStartDate!,
  //       endDate: _isCurrentlyWorking ? DateTime.now() : _selectedEndDate!,
  //       isCurrentlyWorking: _isCurrentlyWorking,
  //       jobDescription: _jobdescrbController.text,
  //     );

  //     print('New Experience Data: ${newExperience.toMap()}');

  //     await ExperienceRepository().addExperience(newExperience);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Experience added successfully')),
  //     );
  //   } catch (e, stackTrace) {
  //     print('Failed to add experience: $e');
  //     print(stackTrace);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to add experience: $e')),
  //     );
  //     return;
  //   }
  // }

  // Future<void> _deleteExperience(String experienceId) async {
  //   try {
  //     await ExperienceRepository().deleteExperience(experienceId);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Experience deleted successfully')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to delete experience: $e')),
  //     );
  //   }
  // }

//  Widget _buildEditExperienceDialog(ExperienceModel experience) {
//     DateTime? startDate = experience.startDate;
//     DateTime? endDate = experience.endDate;

//     return StatefulBuilder(
//       builder: (BuildContext context, StateSetter setState) {
//         return AlertDialog(
//           title: const Text("Deneyimi Düzenle"),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: _companyController..text = experience.companyName,
//                   decoration: const InputDecoration(
//                     labelText: "Kurum Adı",
//                     contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
//                   ),
//                 ),
//                   TextField(
//                   controller: _positionController..text = experience.experiencePosition,
//                   decoration: const InputDecoration(
//                     labelText: "Pozisyon",
//                     contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
//                   ),
//                 ),
                
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: PopupMenuButton<String>(
//                     initialValue: _selectedExperienceType ?? experience.experienceType,
//                     itemBuilder: (BuildContext context) {
//                       return ['Tam Zamanlı', 'Yarı Zamanlı', 'Staj']
//                           .map((String value) {
//                         return PopupMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList();
//                     },
//                     onSelected: (String? newValue) {
//                       setState(() {
//                         _selectedExperienceType = newValue;
//                       });
//                     },
//                     child: ListTile(
//                       title: Text(_selectedExperienceType ?? 'Deneyim Türünü Seçin'),
//                       trailing: const Icon(Icons.arrow_drop_down),
//                       contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
//                     ),
//                   ),
//                 ),
//                 TextField(
//                   controller: _sectorController..text = experience.experienceSector,
//                   decoration: const InputDecoration(
//                     labelText: "Sektör",
//                     contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
//                   ),
//                 ),
              
//                 PopupMenuButton<String>(
//                   initialValue: _selectedCityId ?? experience.experienceCity,
//                   itemBuilder: (BuildContext context) {
//                     return _cities.map((city) {
//                       return PopupMenuItem<String>(
//                         value: city["id"],
//                         child: Text(city["name"]!),
//                       );
//                     }).toList();
//                   },
//                   onSelected: (String? newValue) {
//                     setState(() {
//                       _selectedCityId = newValue;
//                       _selectedCityName = _cities.firstWhere((city) => city["id"] == newValue)["name"];
//                     });
//                   },
//                   child: ListTile(
//                     title: Text(_selectedCityName ?? 'Şehir Seçiniz'),
//                     trailing: const Icon(Icons.arrow_drop_down),
//                     contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () async {
//                           final selectedDate = await ExperienceUtil.selectStartDate(context);
//                           if (selectedDate != null) {
//                             setState(() {
//                               startDate = selectedDate;
//                             });
//                           }
//                         },
//                         child: AbsorbPointer(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               labelText: startDate != null
//                                   ? DateFormat('dd/MM/yyyy').format(startDate!)
//                                   : 'Başlangıç Tarihi',
//                               contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: _isCurrentlyWorking
//                             ? null
//                             : () async {
//                                 final selectedDate = await ExperienceUtil.selectEndDate(context);
//                                 if (selectedDate != null) {
//                                   setState(() {
//                                     endDate = selectedDate;
//                                   });
//                                 }
//                               },
//                         child: AbsorbPointer(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               labelText: _isCurrentlyWorking
//                                   ? 'Devam Ediyor'
//                                   : endDate != null
//                                       ? DateFormat('dd/MM/yyyy').format(endDate!)
//                                       : 'Bitiş Tarihi',
//                               contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 TextField(
//                   controller: _jobdescrbController..text = experience.jobDescription!,
//                   decoration: const InputDecoration(
//                     labelText: "İş Tanımı / Açıklama",
//                     contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("İptal"),
//             ),
//             TextButton(
//               onPressed: () {
//                 ExperienceModel updatedExperience = ExperienceModel(
//                   experienceId: experience.experienceId,
//                   userId: experience.userId,
//                   companyName: _companyController.text,
//                   experiencePosition: _positionController.text,
//                   experienceType: _selectedExperienceType ?? '',
//                   experienceSector: _sectorController.text,
//                   experienceCity: _selectedCityName ?? '',
//                   startDate: startDate ?? experience.startDate,
//                   endDate: _isCurrentlyWorking ? DateTime.now() : endDate ?? experience.endDate,
//                   isCurrentlyWorking: _isCurrentlyWorking,
//                   jobDescription: _jobdescrbController.text,
//                 );
//                 Navigator.pop(context, updatedExperience);
//               },
//               child: const Text("Kaydet"),
//             ),
//           ],
//         );
//       },
//     );
//   }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    ? BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is Authenticated) {
                            UserModel currentUser = state.userModel;

                            return ListView.builder(
                              itemCount: currentUser.experiencesList!.length,
                              itemBuilder: (context, index) {
                                ExperienceModel experience =
                                    currentUser.experiencesList![index];
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
                                          onPressed: () async {
                                            final updatedExperience =
                                                await showDialog<
                                                    ExperienceModel>(
                                              context: context,
                                              builder: (context) =>
                                                  EditExperienceDialog(
                                                      experience:experience),
                                            );
                                            if (updatedExperience != null) {
                                              String result =
                                                  await ExperienceRepository()
                                                      .updateExperience(
                                                updatedExperience,
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(result),
                                                ),
                                              );
                                              setState(() {
                                               
                                              });
                                            }
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title:
                                                    const Text("Deneyimi sil"),
                                                content: const Text(
                                                    "Bu deneyimi silmek istediğinizden emin misiniz?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text("İptal"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      print(
                                                          "Silmek istediğim fonksiyon: ${experience.experienceId}");
                                                      // await _deleteExperience(
                                                      //     experience
                                                      //         .experienceId);

                                                      String result =
                                                          await ExperienceRepository()
                                                              .deleteExperience(
                                                                  experience);

                                                      print(result);
                                                    },
                                                    child: const Text('Sil'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      )
                    : const SizedBox.shrink(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "Kurum Adı",
                  controller: _companyController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "Pozisyon",
                  controller: _positionController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  initialValue: _selectedExperienceType,
                  itemBuilder: (BuildContext context) {
                    return ['Tam Zamanlı', 'Yarı Zamanlı', 'Staj']
                        .map((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList();
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedExperienceType = newValue;
                    });
                  },
                  child: ListTile(
                    title:
                        Text(_selectedExperienceType ?? 'Deneyim Türünü Seçin'),
                    trailing: const Icon(Icons.arrow_drop_down),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "Sektör",
                  controller: _sectorController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
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
                    title: Text(_selectedCityName ?? 'Şehir Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "İş Tanımı",
                  controller: _jobdescrbController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: () async {
                  UserModel? userModel =
                      await UserRepository().getCurrentUser();

                  ExperienceModel experienceModel = ExperienceModel(
                    experienceId: const Uuid().v1(),
                    userId: userModel!.userId,
                    companyName: _companyController.text,
                    experiencePosition: _positionController.text,
                    experienceType: _selectedExperienceType.toString(),
                    experienceSector: _sectorController.text,
                    experienceCity: _selectedCityName.toString(),
                    startDate: _selectedStartDate!,
                    endDate: _isCurrentlyWorking ? DateTime.now() : _selectedEndDate!,
                    isCurrentlyWorking: _isCurrentlyWorking,
                    jobDescription: _jobdescrbController.text,
                  );

                  String sonuc = await ExperienceRepository()
                      .addExperience(experienceModel);

                  print(sonuc);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
