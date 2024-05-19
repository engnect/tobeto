import 'package:file_picker/file_picker.dart';

class TBTProjectUtils {
  Future<void> pickPDF(String _filePath) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      _filePath = result.files.single.path!;
    }
  }
}
