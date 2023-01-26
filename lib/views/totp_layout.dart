import 'dart:ui';

import 'package:authenticator/common/classes/alert.dart';
import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:authenticator/common/classes/typedefs.dart';
import 'package:authenticator/mixins/totp_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/services/hive_service.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/services/totp.dart';
import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/views/totp_layout_card.dart';
import 'package:authenticator/common/views/abscured_text.dart';
import 'package:objectid/objectid.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TotpLayout extends StatefulWidget {
  const TotpLayout({
    required this.onDelete,
    required this.data,
    required this.settings,
    super.key,
  });

  final TotpData data;
  final SettingsModel settings;
  final Consumer<ObjectId> onDelete;

  @override
  State<TotpLayout> createState() => _TotpLayoutState();
}

class _TotpLayoutState extends State<TotpLayout>
    with TickerProviderStateMixin, WidgetsBindingObserver, TotpMixin {
  String? totpCode;
  bool codeRevealed = true;
  final HiveService hiveService = HiveService.instance();

  void refreshTotpCode() {
    setState(() {
      totpCode = TOTP.generateTOTPCode(
          widget.data.secret!, DateTime.now().millisecondsSinceEpoch);
    });
  }

  void showQrCodeDialog(Uint8List imageContent) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('QRCode for ${widget.data.label}'),
            content: Container(
              alignment: Alignment.center,
              child: Image(
                image: MemoryImage(imageContent),
              ),
            ),
          );
        });
  }

  @override
  void didUpdateWidget(TotpLayout old) {
    super.didUpdateWidget(old);
    codeRevealed = widget.settings.display.tapToReveal;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setState(() {
      codeRevealed = widget.settings.display.tapToReveal;
      totpCode = TOTP.generateTOTPCode(
          widget.data.secret!, DateTime.now().millisecondsSinceEpoch);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.data.label ?? '',
          ),
        ),
        subtitle: Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Column(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TotpLayoutCard(
                    animationTimeoutCallback: refreshTotpCode,
                    progressColor: context.colors.primary,
                    strokeWidth: 3.0,
                    totpWidget: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: codeRevealed
                            ? AbscuredText(
                                digits: totpCode?.length ?? 6,
                              )
                            : Text(
                                totpCode ?? '',
                                style: context.titleLarge!
                                    .copyWith(letterSpacing: 25.0),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  children: [
                    CircleAvatar(
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () async {
                          final image = await QrPainter(
                            data: totpUrl(widget.data),
                            version: QrVersions.auto,
                            gapless: false,
                            color: context.colors.onSurface,
                          ).toImage(300);
                          final qrImageData = await image.toByteData(
                              format: ImageByteFormat.png);
                          if (qrImageData != null) {
                            showQrCodeDialog(qrImageData.buffer.asUint8List());
                          }
                        },
                        icon: const Icon(
                          Icons.qr_code,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () => context.goNamed(
                          AppRoute.editEntry.name,
                          params: {'eid': widget.data.id.hexString},
                        ),
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          hiveService.removeItem(widget.data.id);
                          widget.onDelete(widget.data.id);
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          if (widget.settings.display.tapToReveal) {
            setState(() {
              codeRevealed = !codeRevealed;
            });
          }
        },
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: totpCode));
          Alert.showAlert(context, 'Totp code copied');
        },
      ),
    );
  }
}
