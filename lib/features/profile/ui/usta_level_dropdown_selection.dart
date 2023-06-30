import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class USTALevelDropdownSelection extends StatefulWidget {
  const USTALevelDropdownSelection({super.key});

  @override
  State<StatefulWidget> createState() => _USTALevelDropdownSelectionState();
}

class _USTALevelDropdownSelectionState
    extends State<USTALevelDropdownSelection> {
  double dropdownValue = ustaLevelData.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.only(right: 30),
          child: CustomText(AppLocalizations.of(context)?.ustaLevel),
        ),
        DropdownButton<double>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (double? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          items: ustaLevelData.map<DropdownMenuItem<double>>((double value) {
            return DropdownMenuItem<double>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ]),
    );
  }
}

const List<double> ustaLevelData = <double>[
  1.0,
  1.5,
  2.0,
  2.5,
  3.0,
  3.5,
  4.0,
  4.5,
  5.0,
  5.5,
  6.0,
  6.5,
  7.0,
];
