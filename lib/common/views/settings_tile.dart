import 'package:flutter/material.dart';
import 'package:authenticator/common/extensions.dart';

class SettingsTile extends StatefulWidget {
  const SettingsTile({
    required this.title,
    this.subTitle,
    this.leading = const [],
    this.trailing = const [],
    this.spacing = 8.0,
    this.alignment,
    this.overflowBarAlignment = OverflowBarAlignment.center,
    this.onClick,
    super.key,
  });

  final List<Widget> leading;
  final List<Widget> trailing;
  final VoidCallback? onClick;
  final Widget title;
  final Widget? subTitle;
  final MainAxisAlignment? alignment;
  final OverflowBarAlignment overflowBarAlignment;
  final double spacing;

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onClick,
      leading: Wrap(
        spacing: 5.0,
        runSpacing: 5.0,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: widget.leading,
      ),
      title: widget.title,
      subtitle: widget.subTitle,
      trailing: Wrap(
        spacing: 5.0,
        runSpacing: 5.0,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: widget.trailing,
      ),
    );
  }
}
