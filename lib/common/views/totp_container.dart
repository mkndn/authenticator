import 'package:authenticator/common/classes/extensions.dart';
import 'package:flutter/material.dart';

class TotpContainer extends StatelessWidget {
  const TotpContainer(
      {required this.code, this.obscureText = false, super.key});

  final String code;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final List<String> codeChars = code.split("");
    final range = List<int>.generate(code.length, (index) => index + 1);
    return Wrap(
      spacing: 5.0,
      children: range
          .map(
            (e) => Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                decoration: BoxDecoration(
                  border: !obscureText
                      ? Border.all(color: context.colors.primary)
                      : null,
                  shape: BoxShape.circle,
                  color: obscureText
                      ? context.colors.primary.withAlpha(150)
                      : null,
                ),
                child: !obscureText ? Text(codeChars[e - 1]) : null),
          )
          .toList(),
    );
  }
}
