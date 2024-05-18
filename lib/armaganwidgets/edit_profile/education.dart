import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Eğitim Durumu',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedEducationLevel,
                onChanged: (newValue) {
                  setState(() {
                    _selectedEducationLevel = newValue;
                  });
                },
                items: <String>[
                  'Lisans',
                  'Ön Lisans',
                  'Yüksek Lisans',
                  'Doktora'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Seçiniz',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              Text('Üniversite',
                  style: Theme.of(context).textTheme.titleMedium),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: _universityController,
                  decoration: const InputDecoration(
                    labelText: 'Kampüs 365',
                    contentPadding: EdgeInsets.all(4),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Bölüm', style: Theme.of(context).textTheme.titleMedium),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    labelText: 'Yazılım',
                    contentPadding: EdgeInsets.all(4),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

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
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(153, 51, 255, 1),
                ),
                child: const Text("Kaydet",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
