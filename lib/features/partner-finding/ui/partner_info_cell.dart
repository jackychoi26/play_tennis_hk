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
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              "${AppLocalizations.of(context)?.username}: ${userProfile.username}"),
          CustomText(
              "${AppLocalizations.of(context)?.district}: ${userProfile.districts?.map((district) => district.toLocalizedName("zh")).toList().join(", ") ?? ""}"),
          CustomText(
              "${AppLocalizations.of(context)?.ustaLevel}: ${userProfile.ustaLevel.toString()}"),
          CustomText(
            "${AppLocalizations.of(context)?.personalDescription}: ${userProfile.description ?? ""}",
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
