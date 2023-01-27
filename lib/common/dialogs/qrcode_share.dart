import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/common/classes/alert.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QRCodeShare {
  static void showCustomDialog(BuildContext parentContext, TotpData data,
      String url, Uint8List content) {
    showDialog(
      useRootNavigator: false,
      context: parentContext,
      builder: (dialogContext) => Scaffold(
        backgroundColor: Colors.transparent,
        body: AlertDialog(
          backgroundColor: dialogContext.colors.background,
          contentPadding: const EdgeInsets.all(10.0),
          title: (data.issuer != null && data.issuer!.isNotEmpty)
              ? Center(child: Text(data.issuer!))
              : null,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 250,
                width: 250,
                color: Colors.white,
                child: Image(image: MemoryImage(content)),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text((data.label != null && data.label!.isNotEmpty)
                  ? data.label!
                  : "No label"),
              const SizedBox(
                height: 20.0,
              ),
              OutlinedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: url));
                  Alert.showAlert(dialogContext, 'Totp url copied to clipboard',
                      width: 350);
                },
                child: const Text('Copy Url'),
              ),
            ],
          ),
          actions: [
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
