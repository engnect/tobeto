import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  final List<Map<String, dynamic>> _educations = [];

  @override
  void dispose() {
    _universityController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedStartDate != null && pickedStartDate != _selectedStartDate) {
      setState(() {
        _selectedStartDate = pickedStartDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedEndDate != null && pickedEndDate != _selectedEndDate) {
      setState(() {
        _selectedEndDate = pickedEndDate;
      });
    }
  }

  void _addEducation() {
    setState(() {
      _educations.add({
        'university': _universityController.text,
        'department': _departmentController.text,
        'educationLevel': _selectedEducationLevel,
        'startDate': _selectedStartDate,
        'endDate': _isCurrentlyStudied ? null : _selectedEndDate,
        'currentlyStudied': _isCurrentlyStudied,
      });

      _universityController.clear();
      _departmentController.clear();
      _selectedEducationLevel = null;
      _selectedStartDate = null;
      _selectedEndDate = null;
      _isCurrentlyStudied = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eğitim Bilgileri'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PopupMenuButton<String>(
                  initialValue: _selectedEducationLevel,
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Lisans',
                        child: Text('Lisans'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Ön Lisans',
                        child: Text('Ön Lisans'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Yüksek Lisans',
                        child: Text('Yüksek Lisans'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Doktora',
                        child: Text('Doktora'),
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
                        _selectedEducationLevel ?? 'Eğitim Seviyesi Seçiniz'),
                    trailing: const Icon(Icons.arrow_drop_down),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              TBTInputField(
                  hintText: "Üniversite",
                  controller: _universityController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name),

              const SizedBox(height: 24),
              TBTInputField(
                  hintText: "Bölüm",
                  controller: _departmentController,
                  onSaved: (p0) {},
                  keyboardType: TextInputType.name),
              const SizedBox(height: 24),

              //başlangıç tarihi
              TextFormField(
                controller: TextEditingController(
                  text: _selectedStartDate != null
                      ? DateFormat('dd/MM/yyyy').format(_selectedStartDate!)
                      : '',
                ),
                decoration: InputDecoration(
                  labelText: 'Başlangıç Tarihi',
                  hintText: 'Başlangıç Tarihi Seçiniz',
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
              //bitiş
              TextFormField(
                controller: TextEditingController(
                  text: _selectedEndDate != null
                      ? DateFormat('dd/MM/yyyy').format(_selectedEndDate!)
                      : '',
                ),
                decoration: InputDecoration(
                  labelText: 'Bitiş Tarihi',
                  hintText: 'Bitiş Tarihi Seçiniz',
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly:
                    true, // Kullanıcının manuel olarak tarih girmesini engellemek için
                onTap: () {
                  _selectEndDate(context);
                },
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _isCurrentlyStudied,
                    onChanged: (value) {
                      setState(() {
                        _isCurrentlyStudied = value!;
                        if (value) {
                          _selectedEndDate = null;
                        }
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Devam ediyorum',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: _addEducation,
              ),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _educations.length,
                itemBuilder: (context, index) {
                  final education = _educations[index];
                  return Card(
                    child: ListTile(
                      title: Text(education['university']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(education['department']),
                          Text(education['educationLevel']),
                          Text(
                            'Başlangıç: ${DateFormat('dd/MM/yyyy').format(education['startDate'])}',
                          ),
                          if (education['currentlyStudied'])
                            const Text('Devam ediyor')
                          else if (education['endDate'] != null)
                            Text(
                              'Bitiş: ${DateFormat('dd/MM/yyyy').format(education['endDate'])}',
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
