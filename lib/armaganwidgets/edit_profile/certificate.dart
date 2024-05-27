import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/screens/login_register_screen/widgets/extract_login_widgets.dart';

class CertificatesPage extends StatefulWidget {
  const CertificatesPage({super.key});

  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  final TextEditingController _certificateNameController =TextEditingController();
      
  DateTime? _selectedYear;
  String? _filePath;

  @override
  void dispose() {
    _certificateNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sertifikalar'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
           TBTInputField(
            hintText: "Sertifika Adı", 
            controller: _certificateNameController, 
            onSaved: (p0) {}, 
            keyboardType: TextInputType.name),
            const SizedBox(height: 16),
            const SizedBox(height: 16),

            TextFormField(
              controller: TextEditingController(
                text: _selectedYear != null ? '${_selectedYear!.year}' : '',
              ),
              decoration: const InputDecoration(
                labelText: 'Alınan Tarih',
                hintText: 'Yıl Seçin',
                contentPadding: EdgeInsets.all(8),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly:
                  true, // Kullanıcının manuel olarak tarih girmesini engellemek için
              onTap: () {
                _selectYear(context);
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'PDF Yükle',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _pickPDF();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
              ),
              child: const Text('PDF Yükle'),
            ),
            const SizedBox(height: 8),
            _filePath != null ? Text('Seçilen Dosya: $_filePath') : Container(),
            const SizedBox(height: 16),
            TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: () {},
              )
          ],
        ),
      ),
    );
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedYear) {
      setState(() {
        _selectedYear = picked;
      });
    }
  }

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path!;
      });
    }
  }
}
