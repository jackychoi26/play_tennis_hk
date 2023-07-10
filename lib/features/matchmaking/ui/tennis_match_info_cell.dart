import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/core/extensions/date_time_formatter.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/region.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/partner_detail_screen.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_detail_card.dart';

class TennisMatchInfoCell extends StatelessWidget {
  const TennisMatchInfoCell({
    required this.startDateTime,
    required this.endDateTime,
    required this.district,
    required this.court,
    required this.ustaLevelRange,
    this.remarks,
    super.key,
  });

  final DateTime startDateTime;
  final DateTime endDateTime;
  final District district;
  final String court;
  final List<num> ustaLevelRange;
  final String? remarks;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PartnerDetailScreen(
              tennisMatchDetailCard: TennisMatchDetailCard(
                startDateTime: startDateTime,
                endDateTime: endDateTime,
                district: district,
                court: court,
                ustaLevelRange: ustaLevelRange,
                remarks: remarks,
                shouldShowAllRemarks: true,
              ),
            ),
          ),
        );
      },
      child: TennisMatchDetailCard(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        district: district,
        court: court,
        ustaLevelRange: ustaLevelRange,
        remarks: remarks,
      ),
    );
  }
}
