import 'package:flutter/material.dart';
import 'package:tobeto/src/models/certificate_model.dart';
import 'package:tobeto/src/common/utilities/tbt_utilities.dart';
import 'package:tobeto/src/presentation/widgets/tbt_input_field.dart';

class EditCertificateDialog extends StatefulWidget {
  final CertificateModel certificateModel;

  const EditCertificateDialog({super.key, required this.certificateModel});

  @override
  State<EditCertificateDialog> createState() => _EditCertificateDialogState();
}

class _EditCertificateDialogState extends State<EditCertificateDialog> {
  final TextEditingController _certificateNameController =
      TextEditingController();
  DateTime? _selectedYear;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _certificateNameController.text = widget.certificateModel.certificateName;
    _selectedYear = widget.certificateModel.certificateYear;
    _filePath = widget.certificateModel.certificateFileUrl;
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await Utilities.datePicker(context);
    if (picked != null && picked != _selectedYear) {
      setState(() {
        _selectedYear = picked;
      });
    }
  }

  Future<void> _pickPDF() async {
    final String? path = await Utilities.pickPDF();
    if (path != null) {
      setState(() {
        _filePath = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text("Sertifika Düzenle", 
       style: TextStyle(color: Theme.of(context).colorScheme.primary),),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TBTInputField(
                hintText: "Sertifika Adı",
                controller: _certificateNameController,
                onSaved: (p0) {},
                keyboardType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                 style: TextStyle(color: Theme.of(context).colorScheme.primary),
                controller: TextEditingController(
                  text: _selectedYear != null ? '${_selectedYear!.year}' : '',
                ),
                decoration:  InputDecoration(
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                  labelText: 'Alınan Tarih',
                  hintText: 'Yıl Seçin',
                  contentPadding: const EdgeInsets.all(8),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  _selectYear(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'PDF Yükle',
                 style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _pickPDF();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8.0),
                ),
                child:  Text('PDF Yükle', 
                 style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            if (_filePath != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Seçilen Dosya: $_filePath'),
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
            CertificateModel updatedCertificate = CertificateModel(
              certificateId: widget.certificateModel.certificateId,
              userId: widget.certificateModel.userId,
              certificateYear: _selectedYear!,
              certificateName: _certificateNameController.text,
              certificateFileUrl: _filePath!,
            );
            Navigator.pop(context, updatedCertificate);
          },
          child: const Text("Kaydet"),
        ),
      ],
    );
  }
}
