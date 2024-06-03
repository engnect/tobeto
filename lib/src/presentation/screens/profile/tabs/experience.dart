import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tobeto/src/presentation/screens/auth/widgets/extract_login_widgets.dart';
import 'package:tobeto/src/presentation/screens/auth/widgets/purple_button.dart';

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
  // String? _selectedSector;
  //String? _selectedCity;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  bool _isCurrentlyWorking = false;

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _sectorController.dispose();
    _cityController.dispose();
    _jobdescrbController.dispose();

    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedStartDate) {
      setState(() {
        _selectedStartDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedEndDate) {
      setState(() {
        _selectedEndDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tecrübe Bilgileri'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //KURUM
              TBTInputField(
                  hintText: "Kurum Adı",
                  controller: _companyController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name),

              const SizedBox(height: 24),
              //POZİSYON
              TBTInputField(
                  hintText: "Pozisyon",
                  controller: _positionController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name),
              const SizedBox(height: 24),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton<String>(
                  initialValue: _selectedExperienceType,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Staj',
                        child: Text('Staj'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Gönüllü Çalışma',
                        child: Text('Gönüllü Çalışma'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Profesyonel Çalışma',
                        child: Text('Profesyonel Çalışma'),
                      ),
                    ];
                  },
                  onSelected: (String? newValue) {
                    setState(() {
                      _selectedExperienceType = newValue;
                    });
                  },
                  child: ListTile(
                    title:
                        Text(_selectedExperienceType ?? 'Deneyim Türü Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              TBTInputField(
                  hintText: "Sektör",
                  controller: _sectorController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name),

              const SizedBox(height: 24),

              TBTInputField(
                  hintText: "Şehir",
                  controller: _cityController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name),

              const SizedBox(height: 16),
              TextFormField(
                controller: TextEditingController(
                  text: _selectedStartDate != null
                      ? DateFormat('dd/MM/yyyy').format(_selectedStartDate!)
                      : '',
                ),
                decoration: InputDecoration(
                  labelText: 'İş Başlangıç Tarihi',
                  hintText: 'Tarih Seçiniz',
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  _selectStartDate(context);
                },
              ),

              const SizedBox(height: 16),
              TextFormField(
                controller: TextEditingController(
                  text: _selectedEndDate != null
                      ? DateFormat('dd/MM/yyyy').format(_selectedEndDate!)
                      : '',
                ),
                decoration: InputDecoration(
                  labelText: 'İş Bitiş Tarihi',
                  hintText: 'Tarih Seçiniz',
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  _selectEndDate(context);
                },
              ),

              //ÇALIŞMAYA DEVAM EDİYORUM
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isCurrentlyWorking,
                    onChanged: (value) {
                      setState(() {
                        _isCurrentlyWorking = value!;
                        if (value) {
                          _selectedEndDate = null;
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Çalışmaya devam ediyorum',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TBTInputField(
                  hintText: "İş Açıklaması",
                  controller: _jobdescrbController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  minLines: 3),
              const SizedBox(height: 8),

              TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
