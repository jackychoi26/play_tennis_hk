import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_detail_card.dart';

class PartnerDetailScreen extends StatelessWidget {
  const PartnerDetailScreen({
    required this.tennisMatchDetailCard,
    super.key,
  });

  final TennisMatchDetailCard tennisMatchDetailCard;

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
            child: tennisMatchDetailCard,
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.username),
            subtitle: const Text("JackyChoi"),
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.ustaLevel),
            subtitle: const Text("3.5"),
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.district),
            subtitle: CustomText(District.north.toLocalizedName("zh")),
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.telegram),
            subtitle: const Text("clock3"),
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.whatsapp),
            subtitle: const Text("+852 6769 6351"),
          ),
          ListTile(
            title: CustomText(AppLocalizations.of(context)?.signal),
            subtitle: const Text("+852 6769 6351"),
          ),
        ],
      ),
    );
  }
}
