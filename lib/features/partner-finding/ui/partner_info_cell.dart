import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class PartnerInfoCell extends StatelessWidget {
  const PartnerInfoCell({
    super.key,
    required this.userProfile,
  });

  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "${AppLocalizations.of(context)?.username}:  ${userProfile.username}",
            textColor: Colors.black,
          ),
          CustomText(
            "${AppLocalizations.of(context)?.district}:  ${userProfile.districts?.map(
                  (district) {
                    return district.toLocalizedName(context);
                  },
                ).toList().join(", ") ?? ""}",
            textColor: Colors.black,
          ),
          CustomText(
            "${AppLocalizations.of(context)?.ntrpLevel}:  ${userProfile.ntrpLevel.toString()}",
            textColor: Colors.black,
          ),
          if (userProfile.description?.isNotEmpty == true) ...[
            CustomText(
              "${AppLocalizations.of(context)?.personalDescription}: ${userProfile.description ?? ""}",
              textColor: Colors.black,
              maxLines: 1,
            ),
          ]
        ],
      ),
    );
  }
}
