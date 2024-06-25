import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/utilities/utilities.dart';
import 'package:tobeto/src/models/education_model.dart';

class EditEducationDialog extends StatefulWidget {
  final EducationModel education;

  const EditEducationDialog({super.key, required this.education});

  @override
  State<EditEducationDialog> createState() => _EditEducationDialogState();
}

class _EditEducationDialogState extends State<EditEducationDialog> {
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  String? _selectedEducationLevel;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  bool _isCurrentlyStudied = false;

  @override
  void initState() {
    super.initState();
    _universityController.text = widget.education.schoolName;
    _departmentController.text = widget.education.schoolBranch;
    _selectedEducationLevel = widget.education.educationLevel;
    _selectedStartDate = widget.education.schoolStartDate;
    _selectedEndDate = widget.education.schoolEndDate;
    _isCurrentlyStudied = widget.education.isCurrentlyStuding ?? false;
  }

  @override
  void dispose() {
    _universityController.dispose();
    _departmentController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Eğitimi Düzenle"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<String>(
              initialValue: _selectedEducationLevel,
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Lisans',
                    child: ListTile(
                      title: Text('Lisans'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Ön Lisans',
                    child: ListTile(
                      title: Text('Ön Lisans'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Yüksek Lisans',
                    child: ListTile(
                      title: Text('Yüksek Lisans'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Doktora',
                    child: ListTile(
                      title: Text('Doktora'),
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
                ),
                trailing: const Icon(Icons.arrow_drop_down),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              ),
            ),
            TextField(
              controller: _universityController,
              decoration: const InputDecoration(
                labelText: "Üniversite",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              ),
            ),
            TextField(
              controller: _departmentController,
              decoration: const InputDecoration(
                labelText: "Bölüm",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectStartDate(context),
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: _selectedStartDate != null
                              ? DateFormat('dd/MM/yyyy')
                                  .format(_selectedStartDate!)
                              : 'Başlangıç Tarihi',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                        ),
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
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: _isCurrentlyStudied
                              ? 'Devam Ediyor'
                              : _selectedEndDate != null
                                  ? DateFormat('dd/MM/yyyy')
                                      .format(_selectedEndDate!)
                                  : 'Bitiş Tarihi',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("İptal"),
        ),
        TextButton(
          onPressed: () {
            EducationModel updatedEducation = EducationModel(
              educationId: widget.education.educationId,
              userId: widget.education.userId,
              schoolName: _universityController.text,
              schoolBranch: _departmentController.text,
              educationLevel: _selectedEducationLevel ?? '',
              schoolStartDate:
                  _selectedStartDate ?? widget.education.schoolStartDate,
              schoolEndDate:
                  _isCurrentlyStudied ? DateTime.now() : _selectedEndDate!,
              isCurrentlyStuding: _isCurrentlyStudied,
            );
            Navigator.pop(context, updatedEducation);
          },
          child: const Text("Kaydet"),
        ),
      ],
    );
  }
}
