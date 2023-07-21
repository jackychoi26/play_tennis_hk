import 'package:flutter/material.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';
import 'package:play_tennis_hk/features/partner-finding/ui/partner_detail_screen.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/tennis_match_detail_card.dart';

class TennisMatchInfoCell extends StatelessWidget {
  const TennisMatchInfoCell({
    required TennisMatch tennisMatch,
    super.key,
  }) : _tennisMatch = tennisMatch;

  final TennisMatch _tennisMatch;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PartnerDetailScreen(
              tennisMatch: _tennisMatch,
              userProfile: _tennisMatch.poster!,
            ),
          ),
        );
      },
      child: TennisMatchDetailCard(
        tennisMatch: _tennisMatch,
        shouldShowAllRemarks: false,
      ),
    );
  }
}
