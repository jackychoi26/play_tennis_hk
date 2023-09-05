import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_alert_dialog.dart';
import 'package:play_tennis_hk/components/custom_card.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/core/error_resolver.dart';
import 'package:play_tennis_hk/core/extensions/date_time_formatter.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/match_type.dart';
import 'package:play_tennis_hk/domain/region.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/providers/tennis_matches_provider.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/user_profile_provider.dart';

class TennisMatchDetailCard extends ConsumerWidget {
  TennisMatchDetailCard({
    required TennisMatch tennisMatch,
    this.shouldShowAllRemarks = false,
    super.key,
  })  : _startDateTime = tennisMatch.startDateTime,
        _endDateTime = tennisMatch.endDateTime,
        _district = tennisMatch.district,
        _court = tennisMatch.court,
        _ntrpLevel = tennisMatch.ntrpLevel,
        _matchType = tennisMatch.matchType,
        _remarks = tennisMatch.remarks,
        _userId = tennisMatch.poster?.id,
        _matchId = tennisMatch.id;

  final DateTime _startDateTime;
  final DateTime _endDateTime;
  final District _district;
  final String _court;
  final num _ntrpLevel;
  final MatchType _matchType;
  final String? _remarks;

  final bool shouldShowAllRemarks;

  final int? _userId;
  final int? _matchId;

  bool _isCreatedByCurrentUser(int? currentUserId) {
    if (currentUserId == null) {
      return false;
    }
    return _userId == currentUserId;
  }

  String _getDate(String? localName) {
    return _startDateTime.getLocalizedMonthDayValue(localName);
  }

  String? _getDayOfWeek(BuildContext context) {
    return _startDateTime.getLocalizedDayOfWeekValue(context);
  }

  String _getTime() {
    final startHour = _startDateTime.getHourIn12HoursFormat();
    final endHour = _endDateTime.getHourIn12HoursFormat();
    return "$startHour-$endHour ${_endDateTime.isPm() ? "pm" : "am"}";
  }

  String _getNtrpLevelRange() {
    return _ntrpLevel.toString();
  }

  Color _getBackgroundColor() {
    switch (_district.toRegion()) {
      case Region.hkIsland:
        return Colors.blue;
      case Region.kowloon:
        return Colors.red;
      case Region.newTerritories:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localName = AppLocalizations.of(context)?.localeName;
    final currentUserId = ref.watch(userProfileProvider)?.id;
    final matchId = _matchId;

    return CustomCard(
      color: _getBackgroundColor(),
      positionedChild: Visibility(
        visible: _isCreatedByCurrentUser(currentUserId),
        child: Positioned(
          top: 0,
          right: 0,
          child: IconButton(
              icon: const Icon(Icons.close_sharp),
              onPressed: () {
                if (matchId == null) return;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomAlertDialog(
                      title: AppLocalizations.of(context)
                          ?.confirmdeleteTennisMatch,
                      onConfirm: () async {
                        try {
                          await ref
                              .read(tennisMatchesProvider.notifier)
                              .deleteTennisMatch(matchId);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        } catch (e) {
                          ErrorResolver().resolveError(e, context);
                        }
                      },
                    );
                  },
                );
              }),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                "${AppLocalizations.of(context)?.date}: ${_getDate(localName)} - ${_getDayOfWeek(context)}"),
            CustomText("${AppLocalizations.of(context)?.time}: ${_getTime()}"),
            CustomText(
                "${AppLocalizations.of(context)?.location}: ${_district.toLocalizedName(context)} $_court"),
            CustomText(
                "${AppLocalizations.of(context)?.matchType}: ${_matchType.toLocalizedName(context)}"),
            CustomText(
                "${AppLocalizations.of(context)?.ntrpLevel}: ${_getNtrpLevelRange()}"),
            if (_remarks != null && _remarks?.isNotEmpty == true) ...[
              CustomText(
                "${AppLocalizations.of(context)?.remarks}: ${_remarks ?? ""}",
                maxLines: shouldShowAllRemarks ? 10 : 1,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
