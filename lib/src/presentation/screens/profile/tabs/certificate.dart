import 'package:flutter/material.dart';
import 'package:tobeto/src/common/constants/utilities.dart';
import 'package:tobeto/src/presentation/screens/profile/padded_widget';
import '../../../widgets/input_field.dart';
import '../../../widgets/purple_button.dart';

class CertificatesPage extends StatefulWidget {
  const CertificatesPage({super.key});

  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  final TextEditingController _certificateNameController =
      TextEditingController();

  DateTime? _selectedYear;
  String? _filePath;

  @override
  void dispose() {
    _certificateNameController.dispose();
    super.dispose();
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked =
        await CertificateUtil.selectYear(context, _selectedYear);
    if (picked != null && picked != _selectedYear) {
      setState(() {
        _selectedYear = picked;
      });
    }
  }

  Future<void> _pickPDF() async {
    final String? path = await CertificateUtil.pickPDF();
    if (path != null) {
      setState(() {
        _filePath = path;
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
            PaddedWidget(
              padding: 8.0,
              child: TBTInputField(
                hintText: "Sertifika Adı",
                controller: _certificateNameController,
                onSaved: (p0) {},
                keyboardType: TextInputType.name,
              ),
            ),
            PaddedWidget(
              padding: 8.0,
              child: TextFormField(
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
                readOnly: true,
                onTap: () {
                  _selectYear(context);
                },
              ),
            ),
            const PaddedWidget(
              padding: 16.0,
              child: Text(
                'PDF Yükle',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            PaddedWidget(
              padding: 8.0,
              child: ElevatedButton(
                onPressed: () {
                  _pickPDF();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                ),
                child: const Text('PDF Yükle'),
              ),
            ),
            if (_filePath != null)
              PaddedWidget(
                padding: 8.0,
                child: Text('Seçilen Dosya: $_filePath'),
              ),
            PaddedWidget(
              padding: 8.0,
              child: TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
