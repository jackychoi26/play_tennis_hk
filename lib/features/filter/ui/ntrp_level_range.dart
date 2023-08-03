import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/ntrp_level.dart';
import 'package:play_tennis_hk/features/profile/ui/ntrp_level_dropdown_selection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NtrpLevelRange extends StatelessWidget {
  const NtrpLevelRange({
    required this.lowerNtrpLevel,
    required this.upperNtrpLevel,
    required this.onLowerNtrpLevelChange,
    required this.onUpperNtrpLevelChange,
    Key? key,
  }) : super(key: key);

  final num lowerNtrpLevel;
  final num upperNtrpLevel;

  final void Function(num) onLowerNtrpLevelChange;
  final void Function(num) onUpperNtrpLevelChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NTRPLevelDropdownSelection(
          initialValue: lowerNtrpLevel,
          onValueChanged: (num value) {
            onLowerNtrpLevelChange(value);
          },
        ),
        CustomText("${AppLocalizations.of(context)?.to}     "),
        DropdownButton<num>(
          value: upperNtrpLevel,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (num? value) {
            if (value != null) {
              onUpperNtrpLevelChange(value);
            }
          },
          items: ntrpLevel.map<DropdownMenuItem<num>>((num value) {
            return DropdownMenuItem<num>(
              value: value,
              child: CustomText("${value.toString()} "),
            );
          }).toList(),
        ),
      ],
    );
  }
}
