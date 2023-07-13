import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/components/custom_text_form_field.dart';
import 'package:play_tennis_hk/domain/match_type.dart';

class CreateTennisMatchScreen extends ConsumerStatefulWidget {
  const CreateTennisMatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateTennisMatchScreenState();
}

class CreateTennisMatchScreenState
    extends ConsumerState<CreateTennisMatchScreen> {
  var locationController = TextEditingController();

  MatchType dropdownValue = MatchType.singles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.createMatch,
          textType: CustomTextType.subtitle,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CustomTextFormField(
              controller: locationController,
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
              labelText: AppLocalizations.of(context)?.location,
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
              items:
                  ustaLevelData.map<DropdownMenuItem<double>>((double value) {
                return DropdownMenuItem<double>(
                  value: value,
                  child: CustomText(value.toString()),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
