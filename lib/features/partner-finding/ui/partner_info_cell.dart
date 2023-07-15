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
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                          return district.toLocalizedName(
                              AppLocalizations.of(context)?.localeName);
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
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(12),
          ),
        ],
      ),
    );
  }
}
