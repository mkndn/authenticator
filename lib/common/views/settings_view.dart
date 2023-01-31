import 'package:authenticator/mixins/size_mixin.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({
    required this.children,
    this.padding,
    super.key,
  });

  final List<Widget> children;
  final EdgeInsets? padding;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with SizeMixin {
  List<Widget> listViewItems = [];

  @override
  void initState() {
    super.initState();
    listViewItems.addAll(widget.children);
  }

  @override
  void didUpdateWidget(SettingsView old) {
    super.didUpdateWidget(old);
    setState(() {
      listViewItems.clear();
      listViewItems.addAll(widget.children);
      listViewItems.add(const SizedBox(
        height: 10.0,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (builder, constraints) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          constraints: BoxConstraints(
            maxWidth: maxWidth(constraints,
                offsetPercent: 0.7, offsetPercentMobile: 0.9),
            maxHeight: maxHeight(constraints, offsetPercent: 0.7),
          ),
          alignment: Alignment.topCenter,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listViewItems.length,
            itemBuilder: (context, index) => listViewItems[index],
          ),
        ),
      ),
    );
  }
}
