import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/blocs/blocs_module.dart';
import 'package:uuid/uuid.dart';
import '../../../../common/export_common.dart';
import '../../../../domain/export_domain.dart';
import '../../../../models/export_models.dart';
import '../../../widgets/export_widgets.dart';
import '../../export_screens.dart';

class EditCertificatesTab extends StatefulWidget {
  const EditCertificatesTab({super.key});

  @override
  State<EditCertificatesTab> createState() => _EditCertificatesTabState();
}

class _EditCertificatesTabState extends State<EditCertificatesTab> {
  final TextEditingController _certificateNameController =
      TextEditingController();
  DateTime? _selectedYear;
  String? _filePath;
  bool isSelect = true;

  @override
  void dispose() {
    _certificateNameController.dispose();
    super.dispose();
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

  _saveCerteficate({
    required String certificateName,
    required DateTime certificateYear,
    required String certificateFileUrl,
    required BuildContext context,
  }) async {
    UserModel? userModel = await UserRepository().getCurrentUser();
    CertificateModel newCertificate = CertificateModel(
      certificateId: const Uuid().v1(),
      userId: userModel!.userId,
      certificateName: certificateName,
      certificateYear: certificateYear,
      certificateFileUrl: certificateFileUrl,
    );
    String result = await CertificateRepository().addCertificate(
      newCertificate,
      certificateFileUrl,
    );
    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  void _editCertificate({
    required CertificateModel certificate,
    required BuildContext context,
  }) async {
    final updatedCertificate = await showDialog<CertificateModel>(
      context: context,
      builder: (context) => EditCertificateDialog(
        certificateModel: certificate,
      ),
    );
    if (updatedCertificate != null) {
      String result = await CertificateRepository().updateCertificate(
        updatedCertificate,
      );
      if (!context.mounted) return;
      Utilities.showSnackBar(snackBarMessage: result, context: context);
    }
  }

  _deleteCertificate({
    required CertificateModel certificate,
    required BuildContext context,
  }) async {
    Navigator.pop(context);
    String result =
        await CertificateRepository().deleteCertificate(certificate);

    if (!context.mounted) return;
    Utilities.showSnackBar(snackBarMessage: result, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TBTAnimatedContainer(
                    height: 375,
                    infoText: 'Yeni Sertefika Ekle!',
                    child: Column(
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
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                            controller: TextEditingController(
                              text: _selectedYear != null
                                  ? '${_selectedYear!.year}'
                                  : '',
                            ),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
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
                                backgroundColor:
                                    const Color.fromARGB(255, 116, 6, 6)),
                            child: Text(
                              'PDF Yükle',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                            onPressed: () => _saveCerteficate(
                              certificateName: _certificateNameController.text,
                              certificateYear: _selectedYear!,
                              certificateFileUrl: _filePath!,
                              context: context,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        UserModel currentUser = state.userModel;
                        return currentUser.certeficatesList!.isEmpty
                            ? const Center(
                                child: Text(
                                  "Eklenmiş sertifika bulunamadı!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
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
                                              _editCertificate(
                                                certificate: certificate,
                                                context: context,
                                              );
                                              setState(() {});
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text(
                                                    "Sertifikayı sil",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                  ),
                                                  content: Text(
                                                    "Bu sertifikayı silmek istediğinizden emin misiniz?",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: Text(
                                                        "İptal",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          _deleteCertificate(
                                                        certificate:
                                                            certificate,
                                                        context: context,
                                                      ),
                                                      child: Text(
                                                        'Sil',
                                                        style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                        ),
                                                      ),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
