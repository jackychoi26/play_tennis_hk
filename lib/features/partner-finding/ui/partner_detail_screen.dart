import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_card.dart';
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
          Container(
            padding: const EdgeInsets.all(12),
            child: CustomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.account_circle,
                          size: 66,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            userProfile.username,
                            fontWeight: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              CustomText(
                                  AppLocalizations.of(context)?.ntrpLevel),
                              const SizedBox(width: 4),
                              CustomText(userProfile.ntrpLevel.toString()),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (userProfile.description?.isNotEmpty == true) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: CustomText(userProfile.description),
                    ),
                  ],
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.place,
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                          userProfile.districts
                                  ?.map(
                                    (district) =>
                                        district.toLocalizedName(context),
                                  )
                                  .toList()
                                  .join(", ") ??
                              "",
                        ),
                      ),
                    ],
                  ),
                  if (userProfile.telegram?.isNotEmpty == true) ...[
                    ListTile(
                      title: CustomText(AppLocalizations.of(context)?.telegram),
                      subtitle: CustomText(userProfile.telegram),
                    ),
                  ],
                  if (userProfile.whatsapp?.isNotEmpty == true) ...[
                    ListTile(
                      title: CustomText(AppLocalizations.of(context)?.whatsapp),
                      subtitle: CustomText(userProfile.whatsapp),
                    ),
                  ],
                  if (userProfile.signal?.isNotEmpty == true) ...[
                    ListTile(
                      title: CustomText(AppLocalizations.of(context)?.signal),
                      subtitle: CustomText(userProfile.signal),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (tennisMatch != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              child: TennisMatchDetailCard(
                tennisMatch: tennisMatch!,
                shouldShowAllRemarks: true,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
