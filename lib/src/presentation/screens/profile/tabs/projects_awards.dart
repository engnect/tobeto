import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectsAndAwardsPage extends StatefulWidget {
  const ProjectsAndAwardsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProjectsAndAwardsPageState createState() => _ProjectsAndAwardsPageState();
}

class _ProjectsAndAwardsPageState extends State<ProjectsAndAwardsPage> {
  final TextEditingController _projectOrAwardNameController =
      TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _projectOrAwardNameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Proje veya Ödül Adı',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                controller: _projectOrAwardNameController,
                decoration: const InputDecoration(
                  labelText: 'Örn.En iyi yazılımcı',
                  contentPadding: EdgeInsets.all(8),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            TextFormField(
              controller: TextEditingController(
                text: _selectedDate != null
                    ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                    : '',
              ),
              decoration: const InputDecoration(
                labelText: 'Tarih Seç',
                hintText: 'gg.aa.yyyy',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly:
                  true, 
              onTap: () {
                _selectDate(context);
              },
            ),
            const SizedBox(height: 16),
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
    );
  }
}
