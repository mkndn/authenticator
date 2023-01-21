import 'package:flutter/material.dart';
import 'package:authenticator/common/views/settings_tile.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({
    this.sectionHeader,
    this.sectionSubHeader,
    required this.children,
    this.padding,
    this.spacing = 5.0,
    this.backgroundColor,
    this.backgroundRadius = 10.0,
    super.key,
  });

  final Widget? sectionHeader;
  final Widget? sectionSubHeader;
  final EdgeInsets? padding;
  final List<SettingsTile> children;
  final double spacing;
  final Color? backgroundColor;
  final double backgroundRadius;

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget.sectionHeader != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: widget.sectionHeader,
            ),
          if (widget.sectionSubHeader != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: widget.sectionSubHeader,
            ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: widget.children
                  .asMap()
                  .entries
                  .map((e) => [
                        e.value,
                        if (e.key < widget.children.length - 1) const Divider()
                      ])
                  .reduce((a, b) {
                a.addAll(b);
                return a;
              }),
            ),
          ),
        ],
      ),
    );
  }
}
