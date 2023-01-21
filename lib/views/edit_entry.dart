import 'dart:async';

import 'package:authenticator/mixins/route_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:authenticator/common/alert.dart';
import 'package:authenticator/common/enums.dart';
import 'package:authenticator/common/views/nav/app_title_bar.dart';
import 'package:authenticator/services/hive_service.dart';
import 'package:authenticator/classes/totp_data.dart';

class EditEntry extends StatefulWidget {
  const EditEntry({
    this.title = 'Add Account',
    this.embedded = true,
    this.parentFormKey,
    this.entryId,
    this.data,
    super.key,
  })  : assert((entryId != null || data != null),
            'Either entryId or data parameter required'),
        assert((embedded && parentFormKey != null) || (!embedded),
            'parentFormKey required for embeddeded forms');

  final String title;
  final String? entryId;
  final GlobalKey<FormState>? parentFormKey;
  final TotpData? data;
  final bool embedded;

  @override
  State<EditEntry> createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> with RouteMixin {
  final HiveService service = HiveService.instance();
  TotpData? entryData;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Widget> buildFormControl(BoxConstraints constraints) {
    return [
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: OverflowBar(
          spacing: 5,
          overflowAlignment: OverflowBarAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              constraints: const BoxConstraints(maxWidth: 200.0),
              child: DropdownButtonFormField<Algorithm>(
                value: entryData!.algorithm,
                decoration: const InputDecoration(
                  labelText: 'Algorithm',
                ),
                items: Algorithm.values
                    .map(
                      (value) => DropdownMenuItem<Algorithm>(
                          value: value, child: Text(value.crypto)),
                    )
                    .toList(),
                onChanged: (value) => setState(() {
                  entryData!.algorithm = value ?? Algorithm.sha1Hash;
                }),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.9),
              child: TextFormField(
                onChanged: (value) => entryData!.secret = value,
                initialValue: entryData!.secret,
                decoration: const InputDecoration(
                  labelText: 'Enter your secret',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Secret is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: OverflowBar(
          spacing: 5,
          overflowAlignment: OverflowBarAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.9),
              child: TextFormField(
                onChanged: (value) => entryData!.label = value,
                initialValue: entryData!.label,
                decoration: const InputDecoration(
                  labelText: 'Enter TOTP label',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'TOTP label is required';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              constraints: const BoxConstraints(maxWidth: 100.0),
              child: TextFormField(
                onChanged: (value) => entryData!.digits = value,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                initialValue: entryData!.digits,
                decoration: const InputDecoration(
                  labelText: 'Digits',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'TOTP digits is required';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              constraints: const BoxConstraints(maxWidth: 100.0),
              child: TextFormField(
                onChanged: (value) => entryData!.period = value,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                initialValue: entryData!.period,
                decoration: const InputDecoration(
                  labelText: 'Periods',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'TOTP periods is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: OverflowBar(
          spacing: 5,
          overflowAlignment: OverflowBarAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15.0, left: 15.0),
              constraints: const BoxConstraints(maxWidth: 100.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                    service.addItem(entryData!);
                    Alert.showAlert(context, 'Account added successfully');
                    Timer(const Duration(seconds: 3), () {
                      GoRouter.of(context)
                          .go(parent(GoRouterState.of(context)));
                    });
                  }
                },
                child: const Text(
                  'Save',
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    entryData = widget.data;
    _formKey = widget.embedded ? widget.parentFormKey! : _formKey;
    if (entryData == null && widget.entryId != null) {
      entryData = service.getItem(widget.entryId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (entryData != null) {
      if (widget.embedded) {
        return LayoutBuilder(
          builder: (context, constraints) => Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: buildFormControl(constraints),
            ),
          ),
        );
      } else {
        return AppTitleBar(
          displayMenu: false,
          backButton: true,
          backActionPath: AppRoutes.home.path,
          title: widget.title,
          child: LayoutBuilder(
            builder: (context, constraints) => Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: buildFormControl(constraints),
                ),
              ),
            ),
          ),
        );
      }
    } else {
      return const CircularProgressIndicator();
    }
  }
}
