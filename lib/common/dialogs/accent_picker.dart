import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:authenticator/services/preference_service.dart';
import 'package:flutter/material.dart';

class AccentPicker {
  static Future<AccentColor?> showCustomDialog(BuildContext context) {
    return showDialog<AccentColor>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        backgroundColor: context.colors.primaryContainer,
        insetPadding: const EdgeInsets.symmetric(vertical: 10.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Accent Color'),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
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
