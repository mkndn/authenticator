import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/services/preference_service.dart';
import 'package:flutter/material.dart';

class AccentPicker {
  static Future<AccentColor?> showCustomDialog(BuildContext context) {
    return showDialog<AccentColor>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Accent Color'),
        children: AccentColor.values
            .map(
              (e) => SimpleDialogOption(
                onPressed: () {
                  PreferenceService.instance().setAccentColor(e.id);
                  Navigator.of(context).pop(e);
                },
                child: Text(e.title),
              ),
            )
            .toList(),
      ),
    );
  }
}
