import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/domain/repositories/education_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/education_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:tobeto/src/presentation/screens/profile/widgets/edit_education_dialog.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/purple_button.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  String? _selectedEducationLevel;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  bool _isCurrentlyStudied = false;
  bool isSelect = false;

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

  void _saveEducation({
    required String schoolName,
    required String schoolBranch,
    required String educationLevel,
    required DateTime schoolStartDate,
    required DateTime schoolEndDate,
    required bool isCurrentlyStuding,
    required BuildContext context,
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    EducationModel newEducation = EducationModel(
      educationId: const Uuid().v4(),
      userId: userModel!.userId,
      schoolName: schoolName,
      schoolBranch: schoolBranch,
      educationLevel: educationLevel,
      schoolStartDate: schoolStartDate,
      schoolEndDate: schoolEndDate,
      isCurrentlyStuding: isCurrentlyStuding,
    );

    String result = await EducationRepository().addEducation(newEducation);
    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _editEducation({
    required EducationModel education,
    required BuildContext context,
  }) async {
    final updatedEducation = await showDialog<EducationModel>(
      context: context,
      builder: (context) => EditEducationDialog(education: education),
    );
    if (updatedEducation != null) {
      String result =
          await EducationRepository().updateEducation(updatedEducation);
      if (!context.mounted) return;
      Utilities.showSnackBar(snackBarMessage: result, context: context);
    }
  }

  _deleteEducation({
    required EducationModel education,
    required BuildContext context,
  }) async {
    Navigator.pop(context);
    String result = await EducationRepository().deleteEducation(education);
    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  @override
  void dispose() {
    _universityController.dispose();
    _departmentController.dispose();
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
                height: isSelect ? 350 : 0,
                duration: const Duration(seconds: 1),
                child: isSelect
                    ? BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is Authenticated) {
                            UserModel currentUser = state.userModel;

                            return ListView.builder(
                              itemCount: currentUser.schoolsList!.length,
                              itemBuilder: (context, index) {
                                EducationModel education =
                                    currentUser.schoolsList![index];
                                return Card(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  child: ListTile(
                                    title: Text(
                                      education.schoolName,
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
                                          education.schoolBranch,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Text(
                                          'Başlangıç Tarihi: ${DateFormat('dd/MM/yyyy').format(education.schoolStartDate)}',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        Text(
                                          education.isCurrentlyStuding!
                                              ? 'Devam Ediyor'
                                              : 'Bitiş Tarihi: ${DateFormat('dd/MM/yyyy').format(education.schoolEndDate)}',
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
                                          onPressed: () async {
                                            _editEducation(
                                              education: education,
                                              context: context,
                                            );
                                            setState(() {});
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title:
                                                    const Text("Eğitimi sil"),
                                                content: const Text(
                                                    "Bu eğitimi silmek istediğinizden emin misiniz?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text("İptal"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        _deleteEducation(
                                                      education: education,
                                                      context: context,
                                                    ),
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
                child: PopupMenuButton<String>(
                  color: Theme.of(context).colorScheme.background,
                  initialValue: _selectedEducationLevel,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Lisans',
                        child: ListTile(
                          title: Text(
                            'Lisans',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Ön Lisans',
                        child: ListTile(
                          title: Text(
                            'Ön Lisans',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Yüksek Lisans',
                        child: ListTile(
                          title: Text(
                            'Yüksek Lisans',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Doktora',
                        child: ListTile(
                          title: Text(
                            'Doktora',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ];
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedEducationLevel = newValue;
                    });
                  },
                  child: ListTile(
                    title: Text(
                      _selectedEducationLevel ?? 'Eğitim Seviyesi Seçiniz',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 10.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "Üniversite",
                  controller: _universityController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTInputField(
                  hintText: "Bölüm",
                  controller: _departmentController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name,
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
                        onTap: _isCurrentlyStudied
                            ? null
                            : () => _selectEndDate(context),
                        child: AbsorbPointer(
                          child: TBTInputField(
                            hintText: _isCurrentlyStudied
                                ? 'Devam Ediyor'
                                : _selectedEndDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(_selectedEndDate!)
                                    : 'Bitiş Tarihi',
                            controller: TextEditingController(
                              text: _isCurrentlyStudied
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
                      value: _isCurrentlyStudied,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isCurrentlyStudied = newValue!;
                        });
                      },
                    ),
                    Text(
                      'Devam ediyorum.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TBTPurpleButton(
                  buttonText: 'Kaydet',
                  onPressed: () => _saveEducation(
                    schoolName: _universityController.text,
                    educationLevel: _selectedEducationLevel!,
                    schoolBranch: _departmentController.text,
                    schoolEndDate: _selectedEndDate ?? DateTime.now(),
                    schoolStartDate: _selectedStartDate ?? DateTime.now(),
                    isCurrentlyStuding: _isCurrentlyStudied,
                    context: context,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
