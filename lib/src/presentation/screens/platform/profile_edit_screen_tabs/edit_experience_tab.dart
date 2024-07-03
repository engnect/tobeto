import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:uuid/uuid.dart';
import '../../../../common/export_common.dart';
import '../../../../domain/export_domain.dart';
import '../../../../models/export_models.dart';
import '../../../widgets/export_widgets.dart';
import '../../export_screens.dart';

class EditExperienceTab extends StatefulWidget {
  const EditExperienceTab({super.key});

  @override
  State<EditExperienceTab> createState() => _EditExperienceTabState();
}

class _EditExperienceTabState extends State<EditExperienceTab> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _jobdescrbController = TextEditingController();

  String? _selectedExperienceType;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  bool _isCurrentlyWorking = false;
  bool isSelect = true;

  List<Map<String, String>> _cities = [];
  String? _selectedCityId;
  String? _selectedCityName;

  @override
  void initState() {
    super.initState();
    _loadCityData();
  }

  Future<void> _loadCityData() async {
    final cities = await Utilities.loadCityData();
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
    final selectedDate = await Utilities.datePicker(context);
    if (selectedDate != null) {
      setState(() {
        _selectedStartDate = selectedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final selectedDate = await Utilities.datePicker(context);
    if (selectedDate != null) {
      setState(() {
        _selectedEndDate = selectedDate;
      });
    }
  }

  void _saveExperience({
    required String companyName,
    required String experiencePosition,
    required String experienceType,
    required String experienceSector,
    required String experienceCity,
    required DateTime startDate,
    required DateTime endDate,
    required bool isCurrentlyWorking,
    required String jobDescription,
    required BuildContext context,
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();

    ExperienceModel experienceModel = ExperienceModel(
      experienceId: const Uuid().v1(),
      userId: userModel!.userId,
      companyName: companyName,
      experiencePosition: experiencePosition,
      experienceType: experienceType,
      experienceSector: experienceSector,
      experienceCity: experienceCity,
      startDate: startDate,
      endDate: endDate,
      isCurrentlyWorking: isCurrentlyWorking,
      jobDescription: jobDescription,
    );

    String result = await ExperienceRepository().addExperience(experienceModel);

    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _deleteExperience({
    required ExperienceModel experienceModel,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Deneyimi sil",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        content: Text(
          "Bu deneyimi silmek istediğinizden emin misiniz?",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              String result = await ExperienceRepository()
                  .deleteExperience(experienceModel);
              if (!context.mounted) return;
              Utilities.showSnackBar(
                snackBarMessage: result,
                context: context,
              );
            },
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  void _editExperience({
    required ExperienceModel experienceModel,
    required BuildContext context,
  }) async {
    ExperienceModel? updatedExperience = await showDialog<ExperienceModel>(
      context: context,
      builder: (context) => EditExperienceDialog(experience: experienceModel),
    );
    String result =
        await ExperienceRepository().updateExperience(updatedExperience!);

    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _positionController.dispose();
    _sectorController.dispose();
    _cityController.dispose();
    _jobdescrbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TBTAnimatedContainer(
                    height: 400,
                    infoText: 'Yeni İş Tecrübesi Ekle!',
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TBTInputField(
                            hintText: "Kurum Adı",
                            controller: _companyNameController,
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
                            color: Theme.of(context).colorScheme.background,
                            initialValue: _selectedExperienceType,
                            itemBuilder: (BuildContext context) {
                              return ['Tam Zamanlı', 'Yarı Zamanlı', 'Staj']
                                  .map((String value) {
                                return PopupMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                );
                              }).toList();
                            },
                            onSelected: (String? newValue) {
                              setState(() {
                                _selectedExperienceType = newValue;
                              });
                            },
                            child: ListTile(
                              title: Text(
                                _selectedExperienceType ??
                                    'Deneyim Türünü Seçin',
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
                            color: Theme.of(context).colorScheme.background,
                            initialValue: _selectedCityId,
                            itemBuilder: (BuildContext context) {
                              return _cities.map((city) {
                                return PopupMenuItem<String>(
                                  value: city["id"],
                                  child: Text(
                                    city["name"]!,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            onSelected: _onCitySelected,
                            child: ListTile(
                              title: Text(
                                _selectedCityName ?? 'Şehir Seçiniz',
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
                                      readOnly: true,
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
                                      readOnly: true,
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
                              Text(
                                'Çalışmaya devam ediyorum.',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
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
                          onPressed: () => _saveExperience(
                            companyName: _companyNameController.text,
                            endDate: _isCurrentlyWorking
                                ? DateTime.now()
                                : _selectedEndDate!,
                            startDate: _selectedStartDate!,
                            jobDescription: _jobdescrbController.text,
                            experienceCity: _selectedCityName!,
                            isCurrentlyWorking: _isCurrentlyWorking,
                            experienceType: _selectedExperienceType!,
                            experiencePosition: _positionController.text,
                            experienceSector: _sectorController.text,
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        UserModel currentUser = state.userModel;

                        return currentUser.experiencesList!.isEmpty
                            ? const Center(
                                child: Text(
                                  "Eklenmiş deneyim bulunamadı!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: currentUser.experiencesList!.length,
                                itemBuilder: (context, index) {
                                  ExperienceModel experience =
                                      currentUser.experiencesList![index];
                                  return Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    child: ListTile(
                                      title: Text(
                                        experience.companyName,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            experience.experiencePosition,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          Text(
                                            'Başlangıç Tarihi: ${DateFormat('dd/MM/yyyy').format(experience.startDate)}',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          Text(
                                            experience.isCurrentlyWorking!
                                                ? 'Devam Ediyor'
                                                : 'Bitiş Tarihi: ${DateFormat('dd/MM/yyyy').format(experience.endDate)}',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                            onPressed: () => _editExperience(
                                              experienceModel: experience,
                                              context: context,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary),
                                            onPressed: () => _deleteExperience(
                                              experienceModel: experience,
                                              context: context,
                                            ),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
