import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/auth/auth_bloc.dart';
import 'package:tobeto/src/common/constants/utilities.dart';
import 'package:tobeto/src/domain/repositories/certificate_repository.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/certificate_model.dart';
import 'package:tobeto/src/models/user_model.dart';
import 'package:uuid/uuid.dart';
import '../../../widgets/input_field.dart';
import '../../../widgets/purple_button.dart';
import '../../../widgets/edit_certificate_dialog.dart';

class CertificatesPage extends StatefulWidget {
  const CertificatesPage({super.key});

  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  final TextEditingController _certificateNameController = TextEditingController();
  DateTime? _selectedYear;
  String? _filePath;
  bool isSelect = false;

  @override
  void dispose() {
    _certificateNameController.dispose();
    super.dispose();
  }

  Future<void> _selectYear(BuildContext context) async {
    final DateTime? picked = await CertificateUtil.selectYear(context, _selectedYear);
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
            TBTPurpleButton(
              buttonText: "Düzenle",
              onPressed: () {
                setState(() {
                  isSelect = !isSelect;
                });
              },
            ),
            AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: isSelect
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                    : null,
                border: Border(
                  bottom: BorderSide(
                    width: isSelect ? 7 : 0,
                    color: const Color.fromARGB(255, 153, 51, 255),
                  ),
                ),
              ),
              height: isSelect ? 600 : 0,
              duration: const Duration(seconds: 1),
              child: isSelect
                  ? BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is Authenticated) {
                          UserModel currentUser = state.userModel;

                          return ListView.builder(
                            itemCount: currentUser.certeficatesList!.length,
                            itemBuilder: (context, index) {
                              CertificateModel certificate =
                                  currentUser.certeficatesList![index];
                              return Card(
                                child: ListTile(
                                  title: Text(certificate.certificateName),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () async {
                                          final updatedCertificate =
                                              await showDialog<CertificateModel>(
                                            context: context,
                                            builder: (context) =>
                                                EditCertificateDialog(
                                                  certificateModel: certificate,
                                                  
                                                ),
                                          );
                                          if (updatedCertificate != null) {
                                            String result =
                                                await CertificateRepository()
                                                    .updateCertificate(
                                              updatedCertificate,
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(result),
                                              ),
                                            );
                                            setState(() {});
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text("Sertifikayı sil"),
                                              content: const Text(
                                                  "Bu sertifikayı silmek istediğinizden emin misiniz?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text("İptal"),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    String result =
                                                        await CertificateRepository()
                                                            .deleteCertificate(
                                                                certificate);
                                                    print(result);
                                                  },
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
                    )
                  : const SizedBox.shrink(),
            ),
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
                controller: TextEditingController(
                  text: _selectedYear != null ? '${_selectedYear!.year}' : '',
                ),
                decoration: const InputDecoration(
                  labelText: 'Alınan Tarih',
                  hintText: 'Yıl Seçin',
                  contentPadding: EdgeInsets.all(8),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  _selectYear(context);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'PDF Yükle',
                style: TextStyle(fontWeight: FontWeight.bold),
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
                child: const Text('PDF Yükle'),
              ),
            ),
            if (_filePath != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Seçilen Dosya: $_filePath'),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TBTPurpleButton(
                buttonText: 'Kaydet',
                onPressed: () async {
                  UserModel? userModel = await UserRepository().getCurrentUser();
                  CertificateModel newCertificate = CertificateModel(
                    certificateId: const Uuid().v1(),
                    userId: userModel!.userId, 
                    certificateName: _certificateNameController.text, 
                    certificateYear: _selectedYear!, 
                    certificateFileUrl: _filePath!
                    );
                  String result =
                      await CertificateRepository().addCertificate(newCertificate, _filePath!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
