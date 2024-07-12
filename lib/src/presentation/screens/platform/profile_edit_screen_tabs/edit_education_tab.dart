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

class EditEducationTab extends StatefulWidget {
  const EditEducationTab({super.key});

  @override
  State<EditEducationTab> createState() => _EditEducationTabState();
}

class _EditEducationTabState extends State<EditEducationTab> {
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  String? _selectedEducationLevel;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  bool _isCurrentlyStudied = false;
  bool isSelect = true;

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
    Utilities.showToast(toastMessage: result);
  }

  void _editEducation({
    required EducationModel education,
  }) async {
    final updatedEducation = await showDialog<EducationModel>(
      context: context,
      builder: (context) => EditEducationDialog(education: education),
    );
    if (updatedEducation != null) {
      String result =
          await EducationRepository().updateEducation(updatedEducation);
      Utilities.showToast(toastMessage: result);
    }
  }

  _deleteEducation({
    required EducationModel education,
  }) async {
    Navigator.pop(context);
    String result = await EducationRepository().deleteEducation(education);
    Utilities.showToast(toastMessage: result);
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
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TBTAnimatedContainer(
                    height: 400,
                    infoText: 'Yeni eğitim Bilgisi Ekle!',
                    child: Column(
                      children: [
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                _selectedEducationLevel ??
                                    'Eğitim Seviyesi Seçiniz',
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
                                      readOnly: true,
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
                              onPressed: () {
                                if (_selectedEducationLevel == null) {
                                  Utilities.showToast(
                                      toastMessage:
                                          'Eğitim Seviyesi Alanı Boş Kalamaz!');
                                } else if (_universityController.text.isEmpty) {
                                  Utilities.showToast(
                                      toastMessage:
                                          'Üniversite Alanı Boş Kalamaz!');
                                } else if (_departmentController.text.isEmpty) {
                                  Utilities.showToast(
                                      toastMessage: 'Bölüm Alanı Boş Kalamaz!');
                                } else if (_selectedStartDate == null) {
                                  Utilities.showToast(
                                      toastMessage:
                                          'Başlangıç Tarihi Alanı Boş Kalamaz!');
                                } else if (!_isCurrentlyStudied &&
                                    _selectedEndDate == null) {
                                  Utilities.showToast(
                                      toastMessage:
                                          'Bitiş Tarihi Alanı Boş Kalamaz!');
                                } else {
                                  _saveEducation(
                                    schoolName: _universityController.text,
                                    educationLevel: _selectedEducationLevel!,
                                    schoolBranch: _departmentController.text,
                                    schoolEndDate:
                                        _selectedEndDate ?? DateTime.now(),
                                    schoolStartDate:
                                        _selectedStartDate ?? DateTime.now(),
                                    isCurrentlyStuding: _isCurrentlyStudied,
                                  );
                                }
                              }),
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

                        return currentUser.schoolsList!.isEmpty
                            ? const Center(
                                child: Text(
                                  "Eklenmiş eğitim bulunamadı!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: currentUser.schoolsList!.length,
                                itemBuilder: (context, index) {
                                  EducationModel education =
                                      currentUser.schoolsList![index];
                                  return Card(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
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
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text(
                                                    "Eğitimi sil",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                  ),
                                                  content: Text(
                                                    "Bu eğitimi silmek istediğinizden emin misiniz?",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child:
                                                          const Text("İptal"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          _deleteEducation(
                                                        education: education,
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
