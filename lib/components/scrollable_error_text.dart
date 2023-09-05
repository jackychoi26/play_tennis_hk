import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScrollableErrorText extends StatelessWidget {
  const ScrollableErrorText({
    this.text,
    super.key,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(),
        Center(
          child: CustomText(
              text ?? AppLocalizations.of(context)?.somethingWentWrong),
        ),
      ],
    );
  }
}
