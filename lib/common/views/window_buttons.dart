import 'package:authenticator/common/classes/extensions.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> with WindowListener {
  bool isMaximized = false;

  @override
  void onWindowMaximize() {
    if (mounted) {
      setState(() => isMaximized = true);
    }
  }

  @override
  void onWindowUnmaximize() {
    if (mounted) {
      setState(() => isMaximized = false);
    }
  }

  @override
  void onWindowRestore() {
    if (mounted) {
      setState(() => isMaximized = false);
    }
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.primaryContainer,
      padding: const EdgeInsets.only(right: 10.0),
      child: OverflowBar(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () async => await windowManager.minimize(),
          ),
          isMaximized
              ? Transform.flip(
                  flipY: true,
                  flipX: true,
                  child: IconButton(
                    icon: const Icon(Icons.filter_none),
                    onPressed: () async => await windowManager.restore(),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.square_outlined),
                  onPressed: () async => windowManager.maximize(),
                ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async => windowManager.close(),
          ),
        ],
      ),
    );
  }
}
