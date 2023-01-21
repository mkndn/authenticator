import 'package:authenticator/mixins/route_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/common/extensions.dart';
import 'package:authenticator/services/hive_service.dart';
import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/services/totp.dart';
import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/views/totp_layout_animated.dart';
import 'package:authenticator/common/alert.dart';
import 'package:authenticator/common/views/abscured_text.dart';

class TotpLayout extends StatefulWidget {
  const TotpLayout({required this.data, required this.settings, super.key});

  final TotpData data;
  final SettingsModel settings;

  @override
  State<TotpLayout> createState() => _TotpLayoutState();
}

class _TotpLayoutState extends State<TotpLayout>
    with TickerProviderStateMixin, WidgetsBindingObserver, RouteMixin {
  String? totpCode;
  bool codeRevealed = true;
  final HiveService hiveService = HiveService.instance();

  void refreshTotpCode() {
    setState(() {
      totpCode = TOTP.generateTOTPCode(
          widget.data.secret!, DateTime.now().millisecondsSinceEpoch);
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
        isThreeLine: true,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.data.label ?? '',
          ),
        ),
        subtitle: TotpLayoutCard(
          animationTimeoutCallback: refreshTotpCode,
          progressColor: context.colors.inversePrimary,
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
                    ),
            ),
          ),
        ),
        trailing: Wrap(
          spacing: 10.0,
          children: [
            CircleAvatar(
              child: IconButton(
                alignment: Alignment.center,
                onPressed: () => GoRouter.of(context)
                    .go('/edit/${widget.data.id.hexString}'),
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
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
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
