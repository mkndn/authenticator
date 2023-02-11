import 'dart:ui';

import 'package:authenticator/common/classes/alert.dart';
import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:authenticator/common/classes/typedefs.dart';
import 'package:authenticator/common/dialogs/qrcode_share.dart';
import 'package:authenticator/mixins/size_mixin.dart';
import 'package:authenticator/mixins/totp_mixin.dart';
import 'package:authenticator/services/authenticator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/services/hive_service.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/services/totp.dart';
import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/views/totp_layout_card.dart';
import 'package:authenticator/common/views/totp_container.dart';
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
  final Consumer<String> onDelete;

  @override
  State<TotpLayout> createState() => _TotpLayoutState();
}

class _TotpLayoutState extends State<TotpLayout>
    with TickerProviderStateMixin, TotpMixin, SizeMixin {
  String? totpCode;
  bool codeConcealed = true;
  final HiveService hiveService = HiveService.instance();
  final AuthenticatorWidget _authenticatorWidget =
      AuthenticatorWidget.instance();

  void refreshTotpCode() {
    setState(() {
      totpCode = TOTP.generateTOTPCode(
        widget.data.secret!,
        DateTime.now().millisecondsSinceEpoch,
        algorithm: widget.data.algorithm,
        length: widget.data.digits,
      );
    });
  }

  @override
  void didUpdateWidget(TotpLayout old) {
    super.didUpdateWidget(old);
    codeConcealed = widget.settings.display.tapToReveal;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      codeConcealed = widget.settings.display.tapToReveal;
      totpCode = TOTP.generateTOTPCode(
        widget.data.secret!,
        DateTime.now().millisecondsSinceEpoch,
        algorithm: widget.data.algorithm,
        length: widget.data.digits,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: context.colors.primary.withAlpha(50),
            ),
            borderRadius: BorderRadius.circular(25.0),
            shape: BoxShape.rectangle),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.data.label ?? '',
                style: context.titleMedium,
              ),
            ),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: GestureDetector(
                    child: TotpLayoutCard(
                      animationTimeoutCallback: refreshTotpCode,
                      progressColor: context.colors.primary,
                      strokeWidth: 3.0,
                      totpWidget: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: totpCode != null && totpCode!.isNotEmpty
                              ? TotpContainer(
                                  code: totpCode!,
                                  obscureText: codeConcealed,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'Code not available',
                                    style: context.titleSmall!,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (widget.settings.display.tapToReveal) {
                        setState(() {
                          codeConcealed = !codeConcealed;
                        });
                      }
                    },
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: totpCode));
                      Alert.showAlert(context, 'Totp code copied');
                    },
                  ),
                ),
                OverflowBar(
                  spacing: 5.0,
                  overflowSpacing: 5.0,
                  children: [
                    CircleAvatar(
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () async {
                          final image = await QrPainter(
                            data: totpUrl(widget.data),
                            version: QrVersions.auto,
                            gapless: false,
                            color: Colors.black,
                          ).toImage(200);
                          final qrImageData = await image.toByteData(
                              format: ImageByteFormat.png);
                          if (qrImageData != null && mounted) {
                            QRCodeShare.showCustomDialog(
                              context,
                              widget.data,
                              totpUrl(widget.data),
                              qrImageData.buffer.asUint8List(),
                            );
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
                          AppRoute.edit.name,
                          params: {'eid': widget.data.id},
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
                          _authenticatorWidget.updateData(context);
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
            const SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
