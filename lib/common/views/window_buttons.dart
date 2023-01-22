import 'package:authenticator/common/classes/extensions.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: context.theme.iconTheme.color,
          ),
        ),
        appWindow.isMaximized
            ? RestoreWindowButton(
                animate: true,
                colors: WindowButtonColors(
                  iconNormal: context.theme.iconTheme.color,
                ),
                onPressed: maximizeOrRestore,
              )
            : MaximizeWindowButton(
                animate: true,
                colors: WindowButtonColors(
                  iconNormal: context.theme.iconTheme.color,
                ),
                onPressed: maximizeOrRestore,
              ),
        CloseWindowButton(
          animate: true,
          colors: WindowButtonColors(
            iconNormal: context.theme.iconTheme.color,
          ),
        ),
      ],
    );
  }
}
