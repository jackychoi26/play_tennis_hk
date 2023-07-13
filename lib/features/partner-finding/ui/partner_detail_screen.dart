import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_detail_card.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class PartnerDetailScreen extends StatelessWidget {
  const PartnerDetailScreen({
    this.tennisMatch,
    required this.userProfile,
    super.key,
  });

  final TennisMatch? tennisMatch;
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.partnerDetail,
          textType: CustomTextType.subtitle,
        ),
      ),
      body: ListView(
        children: [
          if (tennisMatch != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              child: TennisMatchDetailCard(
                tennisMatch: tennisMatch!,
                shouldShowAllRemarks: true,
              ),
            ),
          ],
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.username),
            subtitle: CustomText(userProfile.username),
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.ustaLevel),
            subtitle: CustomText(userProfile.ustaLevel.toString()),
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.district),
            subtitle: CustomText(
              userProfile.districts
                      ?.map((district) => district.toLocalizedName("zh"))
                      .toList()
                      .join(", ") ??
                  "",
            ),
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.telegram),
            subtitle: CustomText(userProfile.telegram),
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.whatsapp),
            subtitle: CustomText(userProfile.whatsapp),
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.signal),
            subtitle: CustomText(userProfile.signal),
          ),
        ],
      ),
    );
  }
}
