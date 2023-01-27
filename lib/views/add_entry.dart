import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/mixins/size_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:authenticator/views/edit_entry.dart';
import 'package:authenticator/services/hive_service.dart';
import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/mixins/totp_mixin.dart';
import 'package:objectid/objectid.dart';

String extractTotpValue(String keyValue) => keyValue.split('=')[1];

class AddEntry extends StatefulWidget {
  const AddEntry({
    this.initialValue,
    super.key,
  });

  final String? initialValue;

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> with TotpMixin, SizeMixin {
  SecretAddMode addMode = SecretAddMode.url;
  final HiveService service = HiveService.instance();
  TotpData data = TotpData(id: ObjectId());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isUrlExtracted = false;

  bool validateAndExtractTOTPData(String? urlProvided) {
    if (urlProvided == null || urlProvided.isEmpty) {
      return false;
    }
    String url = Uri.decodeFull(urlProvided);
    bool isValid = extract(url, data);
    if (isValid) {
      setState(() {
        data = data;
      });
      return true;
    }
    return false;
  }

  List<Widget> getChildren(BoxConstraints constraints) {
    final List<Widget> children = List.empty(growable: true);
    children.add(
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: OverflowBar(
          overflowAlignment: OverflowBarAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              constraints: const BoxConstraints(maxWidth: 200.0),
              child: DropdownButtonFormField<SecretAddMode>(
                value: addMode,
                decoration: const InputDecoration(
                  labelText: 'Add mode',
                ),
                items: SecretAddMode.values
                    .map(
                      (e) => DropdownMenuItem<SecretAddMode>(
                        value: e,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    setState(() => addMode = value ?? SecretAddMode.url),
              ),
            ),
          ],
        ),
      ),
    );

    if (addMode == SecretAddMode.secret || isUrlExtracted) {
      children.add(
        EditEntry.emdedded(
          data: data,
          parentFormKey: _formKey,
        ),
      );
    } else {
      children.addAll(
        [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: OverflowBar(
              spacing: 8.0,
              overflowAlignment: OverflowBarAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  constraints:
                      BoxConstraints(maxWidth: constraints.maxWidth * 0.9),
                  child: TextFormField(
                    maxLines: 2,
                    initialValue: widget.initialValue,
                    keyboardType: TextInputType.url,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(
                          r'[0-9,a-z,A-Z,\b,=,&,%,\?,\/,:]')), // <-- Use \b in your regex here so backspace works.
                    ],
                    enableSuggestions: false,
                    decoration: const InputDecoration(
                      labelText: 'Enter OTP Auth URL',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Url is required';
                      }
                      if (!validateAndExtractTOTPData(value)) {
                        return 'Url is invalid';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                  constraints: const BoxConstraints(maxWidth: 200.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        setState(() => isUrlExtracted = true);
                      }
                    },
                    child: const Text(
                      'Proceed',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: OverflowBar(
              spacing: 8.0,
              overflowAlignment: OverflowBarAlignment.end,
              children: [OTPAuthUrlHint(maxWidth: constraints.maxWidth)],
            ),
          ),
        ],
      );
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 15.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: getChildren(constraints),
          ),
        ),
      ),
    );
  }
}

class OTPAuthUrlHint extends StatelessWidget {
  const OTPAuthUrlHint({required this.maxWidth, super.key});

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      constraints: BoxConstraints(maxWidth: maxWidth * 0.75),
      child: const Card(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            'Format: otpauth://totp/{label}?secret={SECRET_CODE}&issuer={ISSUER_NAME}&algorithm={ALGORITHM}&digits={TOTAL_TOTP_DIGITS}&period={CODE_DURATION}\n\n'
            '1. secret and label (email or text) are mandatory\n'
            '2. algorithm (Optional): SHA1(default), SHA256, SHA512\n'
            '3. digits (Optional): 6 (default) or any integer\n'
            '4. period (Optional): 30 (default) or any duration in seconds\n',
            maxLines: null,
          ),
        ),
      ),
    );
  }
}
