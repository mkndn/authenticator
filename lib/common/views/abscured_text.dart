import 'package:flutter/material.dart';

class AbscuredText extends StatelessWidget {
  const AbscuredText(
      {this.digits = 6, this.decorColor = Colors.blue, super.key});

  final int digits;
  final Color decorColor;

  @override
  Widget build(BuildContext context) {
    final range = List<int>.generate(digits, (index) => index + 1);
    return Wrap(
      spacing: 5.0,
      children: range
          .map((e) => Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: decorColor.withAlpha(175)),
              ))
          .toList(),
    );
  }
}
