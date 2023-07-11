import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/components/custom_text_form_field.dart';

class UsernameTextField extends StatefulWidget {
  const UsernameTextField({
    required this.controller,
    this.enabled = true,
    super.key,
  });

  final TextEditingController controller;
  final bool enabled;

  final TextInputType textInputType = TextInputType.text;
  final int maxLines = 1;
  final String? hintText = "";
  final borderColor = Colors.teal;

  @override
  State<StatefulWidget> createState() => UsernameTextFieldState();
}

class UsernameTextFieldState extends State<UsernameTextField> {
  final TextInputType textInputType = TextInputType.text;
  final int maxLines = 1;
  final String? hintText = "";
  final borderColor = Colors.teal;

  late TextEditingController controller;
  bool _enabled = true;

  bool _shouldShowError = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    _enabled = widget.enabled;
  }

  bool isValid() {
    final usernameValue = controller.text;

    if (usernameValue.length < 4 || usernameValue.length > 12) {
      _shouldShowError = true;
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: controller,
          onChanged: (_) {
            _shouldShowError = false;
          },
          enabled: _enabled,
          labelText: AppLocalizations.of(context)?.username,
          hintText: hintText,
          textInputType: TextInputType.text,
          maxLines: maxLines,
        ),
        Visibility(
          visible: _shouldShowError,
          child: const CustomText("Your username wrong wor"),
        )
      ],
    );
  }
}
