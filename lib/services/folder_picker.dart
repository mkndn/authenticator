import 'dart:io';
import 'package:file_picker/file_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class FolderPicker {
  static Future<Directory?> _getStorage() async {
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      return getDownloadsDirectory();
    } else if (Platform.isAndroid || Platform.isIOS) {
      return getExternalStorageDirectory();
    } else {
      return getTemporaryDirectory();
    }
  }

  static Future<String?> selectDirectory(Directory? dir) async {
    Directory rootDir = await _getStorage() ?? await getTemporaryDirectory();

    return await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select folder',
      initialDirectory: rootDir.path,
    );
  }

  static Future<FilePickerResult?> selectFiles(
      Directory? dir, List<String> extensionFilter, bool allowMultiple) async {
    Directory rootDir = await _getStorage() ?? await getTemporaryDirectory();
    return await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      allowedExtensions: extensionFilter,
      initialDirectory: rootDir.path,
    );
  }
}
