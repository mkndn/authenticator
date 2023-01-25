import 'package:authenticator/common/classes/extensions.dart';
import 'package:flutter/material.dart';

class AbscuredText extends StatelessWidget {
  const AbscuredText({this.digits = 6, super.key});

  final int digits;

  @override
  Widget build(BuildContext context) {
    final range = List<int>.generate(digits, (index) => index + 1);
    return Wrap(
      spacing: 5.0,
      children: range
          .map((e) => Container(
                constraints: BoxConstraints(
                  maxWidth: context.isMobile
                      ? context.dimen.width * 0.05
                      : context.dimen.width * 0.04,
                  maxHeight: context.isMobile
                      ? context.dimen.height * 0.05
                      : context.dimen.height * 0.04,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: context.colors.primary),
              ))
          .toList(),
    );
  }
}
