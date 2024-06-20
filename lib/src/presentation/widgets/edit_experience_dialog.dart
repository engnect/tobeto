import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/common/constants/utilities.dart';
import 'package:tobeto/src/models/experience_model.dart';

class EditExperienceDialog extends StatefulWidget {
  final ExperienceModel experience;

  const EditExperienceDialog({super.key, required this.experience});

  @override
  State<EditExperienceDialog> createState() => _EditExperienceDialogState();
}

class _EditExperienceDialogState extends State<EditExperienceDialog> {
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

    
    _companyController.text = widget.experience.companyName;
    _positionController.text = widget.experience.experiencePosition;
    _sectorController.text = widget.experience.experienceSector;
    _cityController.text = widget.experience.experienceCity;
    _jobdescrbController.text = widget.experience.jobDescription!;
    _selectedExperienceType = widget.experience.experienceType;
    _selectedStartDate = widget.experience.startDate;
    _selectedEndDate = widget.experience.endDate;
    _isCurrentlyWorking = widget.experience.isCurrentlyWorking!;
    _selectedCityId = widget.experience.experienceCity;  
    _selectedCityName = widget.experience.experienceCity;
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
    final cities = await PersonalInfoUtil.loadCityData();
    setState(() {
      _cities = cities;
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Deneyimi Düzenle"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _companyController,
              decoration: const InputDecoration(
                labelText: "Kurum Adı",
                contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
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
                  title: Text(_selectedExperienceType ?? 'Deneyim Türünü Seçin'),
                  trailing: const Icon(Icons.arrow_drop_down),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                ),
              ),
            ),
            TextField(
              controller: _sectorController,
              decoration: const InputDecoration(
                labelText: "Sektör",
                contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              ),
            ),
            TextField(
              controller: _positionController,
              decoration: const InputDecoration(
                labelText: "Pozisyon",
                contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              ),
            ),
            PopupMenuButton<String>(
              initialValue: _selectedCityId,
              itemBuilder: (BuildContext context) {
                return _cities.map((city) {
                  return PopupMenuItem<String>(
                    value: city["id"],
                    child: Text(city["name"]!),
                  );
                }).toList();
              },
              onSelected: (String? newValue) {
                setState(() {
                  _selectedCityId = newValue;
                  _selectedCityName = _cities.firstWhere((city) => city["id"] == newValue)["name"];
                });
              },
              child: ListTile(
                title: Text(_selectedCityName ?? 'Şehir Seçiniz'),
                trailing: const Icon(Icons.arrow_drop_down),
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final selectedDate = await ExperienceUtil.selectStartDate(context);
                      if (selectedDate != null) {
                        setState(() {
                          _selectedStartDate = selectedDate;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: _selectedStartDate != null
                              ? DateFormat('dd/MM/yyyy').format(_selectedStartDate!)
                              : 'Başlangıç Tarihi',
                          contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: _isCurrentlyWorking
                        ? null
                        : () async {
                            final selectedDate = await ExperienceUtil.selectEndDate(context);
                            if (selectedDate != null) {
                              setState(() {
                                _selectedEndDate = selectedDate;
                              });
                            }
                          },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: _isCurrentlyWorking
                              ? 'Devam Ediyor'
                              : _selectedEndDate != null
                                  ? DateFormat('dd/MM/yyyy').format(_selectedEndDate!)
                                  : 'Bitiş Tarihi',
                          contentPadding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _jobdescrbController,
              decoration: const InputDecoration(
                labelText: "İş Tanımı / Açıklama",
                contentPadding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              ),
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
            ExperienceModel updatedExperience = ExperienceModel(
              experienceId: widget.experience.experienceId,
              userId: widget.experience.userId,
              companyName: _companyController.text,
              experiencePosition: _positionController.text,
              experienceType: _selectedExperienceType ?? '',
              experienceSector: _sectorController.text,
              experienceCity: _selectedCityName ?? '',
              startDate: _selectedStartDate ?? widget.experience.startDate,
              endDate: _isCurrentlyWorking ? DateTime.now() : _selectedEndDate ?? widget.experience.endDate,
              isCurrentlyWorking: _isCurrentlyWorking,
              jobDescription: _jobdescrbController.text,
            );
            Navigator.pop(context, updatedExperience);
          },
          child: const Text("Kaydet"),
        ),
      ],
    );
  }
}
