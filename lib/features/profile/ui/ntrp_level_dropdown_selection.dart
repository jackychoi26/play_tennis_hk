import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/ntrp_level.dart';

class NTRPLevelDropdownSelection extends StatefulWidget {
  final ValueChanged<num> onValueChanged;
  final num initialValue;

  const NTRPLevelDropdownSelection({
    Key? key,
    required this.onValueChanged,
    this.initialValue = 1.0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NTRPLevelDropdownSelectionState();
}

class _NTRPLevelDropdownSelectionState
    extends State<NTRPLevelDropdownSelection> {
  late num dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 30),
            child: CustomText(AppLocalizations.of(context)?.ntrpLevel),
          ),
          DropdownButton<num>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            onChanged: (num? value) {
              if (value != null) {
                setState(() {
                  dropdownValue = value;
                });
                widget.onValueChanged(value);
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
      ),
    );
  }
}
