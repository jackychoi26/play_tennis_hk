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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: locationController,
            textInputType: TextInputType.visiblePassword,
            isPassword: true,
            labelText: AppLocalizations.of(context)?.location,
          ),
          DropdownButton<MatchType>(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (MatchType? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: MatchType.values
                  .map<DropdownMenuItem<MatchType>>((MatchType value) {
                return DropdownMenuItem<MatchType>(
                  value: value,
                  child: Text(value.toLocalizedName(context) ?? ""),
                );
              }).toList()),
        ],
      ),
    );
  }
}
