import 'package:authenticator/common/classes/typedefs.dart';
import 'package:flutter/material.dart';

class TextFieldConfig {
  final FocusNode focusNode;
  TextEditingController controller;

  TextFieldConfig({
    required this.focusNode,
    required this.controller,
  });
}

class PinInput extends StatefulWidget {
  const PinInput({
    required this.onComplete,
    required this.controller,
    this.isReset = false,
    this.autoClose = false,
    this.validator,
    this.numOfDigits = 5,
    this.obscureDigits = true,
    this.obscureChar,
    super.key,
  });

  final int numOfDigits;
  final Func<String?, String?>? validator;
  final TextEditingController controller;
  final ValueChanged<String> onComplete;
  final bool obscureDigits;
  final String? obscureChar;
  final bool autoClose;
  final bool isReset;

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  List<String> code = [];
  final FocusNode focusNode = FocusNode();
  Map<int, TextFieldConfig> configByIndex = {};

  bool isLast(int index) {
    return index == configByIndex.length - 1;
  }

  bool hasNext(int currentIndex) {
    return currentIndex < configByIndex.length - 1 &&
        configByIndex[currentIndex + 1] != null;
  }

  void loadConfigByIndex() {
    List.generate(
      widget.numOfDigits,
      (int index) => configByIndex.putIfAbsent(
        index,
        () => TextFieldConfig(
          focusNode: FocusNode(),
          controller: TextEditingController(),
        ),
      ),
    );
  }

  void updateControls() {
    List<String> values = widget.controller.text.isEmpty
        ? List.filled(configByIndex.length, '')
        : widget.controller.text.split('');
    for (var element in configByIndex.entries) {
      element.value.controller.text = values.elementAt(element.key);
    }
  }

  bool pinComplete() {
    return configByIndex.entries
            .any((element) => element.value.controller.text.isEmpty) ==
        false;
  }

  @override
  void initState() {
    super.initState();
    loadConfigByIndex();
    widget.controller.addListener(() {
      updateControls();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Wrap(
        spacing: 8.0,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: configByIndex.entries
            .map(
              (entry) => SizedBox(
                width: 50.0,
                height: 50.0,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: widget.obscureDigits,
                  controller: entry.value.controller,
                  focusNode: entry.value.focusNode,
                  autofocus: true,
                  decoration: const InputDecoration(
                    counter: Offstage(),
                    errorStyle: TextStyle(fontSize: 0, height: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                  textInputAction: isLast(entry.key)
                      ? TextInputAction.done
                      : TextInputAction.next,
                  maxLength: 1,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      code.insert(entry.key, value);
                      entry.value.focusNode.unfocus();
                      if (hasNext(entry.key)) {
                        FocusScope.of(context).requestFocus(
                            configByIndex[entry.key + 1]!.focusNode);
                      }
                      if (isLast(entry.key) && pinComplete()) {
                        widget.controller.text = configByIndex.values
                            .map((e) => e.controller.text)
                            .join();
                      }
                    }
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  void dispose() {
    for (var element in configByIndex.values) {
      element.focusNode.dispose();
      element.controller.dispose();
    }
    super.dispose();
  }
}
