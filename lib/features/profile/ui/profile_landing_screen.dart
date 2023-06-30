import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text_field.dart';

class ProfileLandingScreen extends StatefulWidget {
  const ProfileLandingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileLandingScreenState();
}

class _ProfileLandingScreenState extends State<ProfileLandingScreen> {
  var descriptionController = TextEditingController();

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
                print("Hello World");
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
          ),
          CustomTextField(
            controller: descriptionController,
            textInputType: TextInputType.text,
            labelText: AppLocalizations.of(context)?.personalDescription,
            hintText: AppLocalizations.of(context)?.personalDescriptionHint,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
