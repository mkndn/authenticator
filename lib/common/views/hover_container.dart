import 'package:flutter/material.dart';
import 'package:authenticator/common/enums.dart';

class HoverContainer extends StatelessWidget {
  const HoverContainer({
    required this.hoverMode,
    this.containerColor,
    this.hoverIcon,
    this.hoverIconLeft,
    this.hoverIconRight,
    this.size,
    this.align,
    this.child,
    super.key,
  })  : assert(
            (hoverMode == HoverMode.around &&
                (child != null &&
                    (hoverIconLeft != null || hoverIconRight != null))),
            'Child, hoverIconLeft/hoverIconRight/both required when around hover is used'),
        assert(
            (hoverMode == HoverMode.contained &&
                (containerColor != null &&
                    hoverIcon != null &&
                    size != null &&
                    align != null)),
            'containerColor, hoverIcon, size, align required when contained hoverMode is used');

  final HoverMode hoverMode;
  final Color? containerColor;
  final Widget? hoverIcon;
  final Widget? hoverIconLeft;
  final Widget? hoverIconRight;
  final double? size;
  final Alignment? align;
  final Widget? child;

  static HoverIconContained contained({
    required Color containerColor,
    required Widget hoverIcon,
    required double size,
    required Alignment align,
  }) {
    return HoverIconContained(
      containerColor: containerColor,
      hoverIcon: hoverIcon,
      size: size,
      align: align,
    );
  }

  static HoverIconAround around({
    Widget? hoverIconLeft,
    Widget? hoverIconRight,
    required Widget child,
  }) {
    return HoverIconAround(
      hoverIconLeft: hoverIconLeft,
      hoverIconRight: hoverIconRight,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return hoverMode == HoverMode.contained
        ? HoverIconContained(
            align: align!,
            containerColor: containerColor!,
            hoverIcon: hoverIcon!,
            size: size!,
          )
        : HoverIconAround(
            hoverIconLeft: hoverIconLeft!,
            hoverIconRight: hoverIconRight!,
            child: child!,
          );
  }
}

class HoverIconContained extends StatefulWidget {
  const HoverIconContained({
    required this.containerColor,
    required this.hoverIcon,
    required this.size,
    required this.align,
    super.key,
  });

  final Color containerColor;
  final Widget hoverIcon;
  final double size;
  final Alignment align;

  @override
  State<HoverIconContained> createState() => _HoverIconContainedState();
}

class _HoverIconContainedState extends State<HoverIconContained> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => hovered = true),
      onExit: (event) => setState(() => hovered = false),
      child: Stack(
        alignment: widget.align,
        children: [
          Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
                color: widget.containerColor, shape: BoxShape.circle),
          ),
          if (hovered) widget.hoverIcon
        ],
      ),
    );
  }
}

class HoverIconAround extends StatefulWidget {
  const HoverIconAround({
    this.hoverIconLeft,
    this.hoverIconRight,
    required this.child,
    super.key,
  }) : assert((hoverIconLeft != null || hoverIconRight != null),
            'hoverIconLeft or hoverIconRIght or both required for around hover');

  final Widget? hoverIconLeft;
  final Widget? hoverIconRight;
  final Widget child;

  @override
  State<HoverIconAround> createState() => _HoverIconAroundState();
}

class _HoverIconAroundState extends State<HoverIconAround> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => hovered = true),
      onExit: (event) => setState(() => hovered = false),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (hovered && widget.hoverIconLeft != null) widget.hoverIconLeft!,
          widget.child,
          if (hovered && widget.hoverIconRight != null) widget.hoverIconRight!,
        ],
      ),
    );
  }
}
