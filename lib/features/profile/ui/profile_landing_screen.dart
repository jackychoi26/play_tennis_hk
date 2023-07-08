import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text_field.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/matches_webservice.dart';
import 'package:play_tennis_hk/features/profile/ui/usta_level_dropdown_selection.dart';

class ProfileLandingScreen extends StatefulWidget {
  const ProfileLandingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileLandingScreenState();
}

class _ProfileLandingScreenState extends State<ProfileLandingScreen> {
  var descriptionController = TextEditingController();
  var telegramController = TextEditingController();
  var whatsappController = TextEditingController();
  var signalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.editProfile,
        ),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                MatchesWebservice().performRequest();
              },
              child: CustomText(
                AppLocalizations.of(context)?.save,
              )),
        ],
      ),
      body: ListView(
        children: [
          CustomTextField(
            controller: descriptionController,
            textInputType: TextInputType.text,
            labelText: AppLocalizations.of(context)?.personalDescription,
            hintText: AppLocalizations.of(context)?.personalDescriptionHint,
            maxLines: 3,
          ),
          const USTALevelDropdownSelection(),
          CustomTextField(
            controller: telegramController,
            textInputType: TextInputType.text,
            labelText:
                "${AppLocalizations.of(context)?.telegram}${AppLocalizations.of(context)?.optional}",
            hintText: AppLocalizations.of(context)?.leaveContact,
          ),
          CustomTextField(
            controller: whatsappController,
            textInputType: TextInputType.text,
            labelText:
                "${AppLocalizations.of(context)?.whatsapp}${AppLocalizations.of(context)?.optional}",
            hintText: AppLocalizations.of(context)?.leaveContact,
          ),
          CustomTextField(
            controller: signalController,
            textInputType: TextInputType.text,
            labelText:
                "${AppLocalizations.of(context)?.signal}${AppLocalizations.of(context)?.optional}",
            hintText: AppLocalizations.of(context)?.leaveContact,
          ),
        ],
      ),
    );
  }
}
