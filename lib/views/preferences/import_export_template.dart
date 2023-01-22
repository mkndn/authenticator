import 'dart:io';

import 'package:authenticator/common/classes/alert.dart';
import 'package:authenticator/common/classes/enums.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:authenticator/mixins/security_mixin.dart';
import 'package:authenticator/services/hive_service.dart';
import 'package:authenticator/services/import_export.dart';

class ImportExportTemplate extends StatefulWidget {
  const ImportExportTemplate({required this.mode, super.key});

  final String mode;

  @override
  State<ImportExportTemplate> createState() => _ImportExportTemplateState();
}

class _ImportExportTemplateState extends State<ImportExportTemplate>
    with SecurityMixin {
  final _formKey = GlobalKey<FormState>();
  final HiveService _hiveService = HiveService.instance();
  bool encrypt = false;
  String? path;

  bool get isImport => widget.mode == ImportExportSettings.import.title;

  Future<String> selectfile() async {
    String path = Directory.current.path;
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.any);
    Directory.current = path;
    return result?.files[0].path ?? '';
  }

  void postImportCheck(String path) {
    AlertDialog(
      content: const Text(
        'Delete export file?',
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final fileToDelete = File(path);
            if (await fileToDelete.exists()) {
              fileToDelete.delete().then(
                    (value) => Alert.showAlert(
                        context, 'File $path deleted successfully'),
                    onError: (error) => Alert.showAlert(context,
                        '$error error while trying to delete file $path'),
                  );
            }
          },
          child: const Text(
            'Yes',
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Text(
            'No',
          ),
        ),
      ],
    );
  }

  void importData(String path, String key) {
    ImportExport.instance().importData(path, key).then(
      (data) {
        for (var element in data) {
          _hiveService.addItem(element);
        }
      },
    ).whenComplete(() {
      Alert.showAlert(context, 'Totp data imported successfully');
    });
  }

  void exportData(String path, String key) {
    ImportExport.instance()
        .exportData(path, key, _hiveService.getAllItems())
        .whenComplete(
          () => Alert.showAlert(context, 'Totp data imported successfully'),
        );
  }

  @override
  Widget build(BuildContext context) {
    final filePathFieldController = TextEditingController(text: path);
    final passwordFieldController = TextEditingController();
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(15.0),
        width: constraints.maxWidth,
        height: constraints.maxHeight * 0.7,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: constraints.maxWidth * 0.7,
                child: GestureDetector(
                    child: TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Select ${widget.mode} path',
                      ),
                      enabled: false,
                      controller: filePathFieldController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a ${widget.mode} path';
                        }
                        return null;
                      },
                    ),
                    onTap: () async {
                      final selectedPath = (isImport
                              ? await selectfile()
                              : await FilePicker.platform.getDirectoryPath()) ??
                          '';
                      setState(() => path = selectedPath);
                    }),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8.0,
                children: [
                  Text(
                    isImport ? 'Encrypted?' : 'Encrypt?',
                  ),
                  Switch(
                    value: encrypt,
                    onChanged: (value) => setState(
                      () => encrypt = value,
                    ),
                  ),
                ],
              ),
              if (encrypt)
                SizedBox(
                  width: constraints.maxWidth * 0.7,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter backup key',
                    ),
                    controller: passwordFieldController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Backup key is required';
                      }
                      if (!meetsRequirement(value) && isImport) {
                        passwordFieldController.clear();
                        return 'Please choose a stronger password. Password should contain letters, numbers and symbols';
                      }
                      return null;
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      (isImport)
                          ? importData(
                              filePathFieldController.text,
                              passwordFieldController.text,
                            )
                          : exportData(
                              filePathFieldController.text,
                              passwordFieldController.text,
                            );
                      filePathFieldController.clear();
                      passwordFieldController.clear();
                      encrypt = false;
                      path = null;
                      Alert.showAlert(context, '${widget.mode} in progress');
                    }
                  },
                  child: Text(widget.mode),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
