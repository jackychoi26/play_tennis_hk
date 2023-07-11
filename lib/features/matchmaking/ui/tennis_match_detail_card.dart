import 'package:flutter/material.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/core/extensions/date_time_formatter.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/match_type.dart';
import 'package:play_tennis_hk/domain/region.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/tennis_match.dart';

class TennisMatchDetailCard extends StatelessWidget {
  TennisMatchDetailCard({
    required TennisMatch tennisMatch,
    this.shouldShowAllRemarks = false,
    super.key,
  })  : _startDateTime = tennisMatch.startDateTime,
        _endDateTime = tennisMatch.endDateTime,
        _district = tennisMatch.district,
        _court = tennisMatch.court,
        _ustaLevelRange = tennisMatch.ustaLevelRange,
        _matchType = tennisMatch.matchType,
        _remarks = tennisMatch.remarks;

  final DateTime _startDateTime;
  final DateTime _endDateTime;
  final District _district;
  final String _court;
  final List<num> _ustaLevelRange;
  final MatchType _matchType;
  final String? _remarks;

  bool shouldShowAllRemarks;

  String _getDate(String? localName) {
    if (localName == "zh") {
      return _startDateTime.getChineseMonthDayValue();
    } else {
      return _startDateTime.getEnglishMonthDayValue();
    }
  }

  String _getTime() {
    final startHour = _startDateTime.getHourIn12HoursFormat();
    final endHour = _endDateTime.getHourIn12HoursFormat();
    return "$startHour-$endHour ${_endDateTime.isPm() ? "pm" : "am"}";
  }

  String _getUstaLevelRange() {
    if (_ustaLevelRange.length == 1) {
      return _ustaLevelRange.first.toString();
    } else {
      return "${_ustaLevelRange.first.toString()} - ${_ustaLevelRange.last.toString()}";
    }
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
  Widget build(BuildContext context) {
    final localName = AppLocalizations.of(context)?.localeName;

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              "${AppLocalizations.of(context)?.date}: ${_getDate(localName)}"),
          CustomText("${AppLocalizations.of(context)?.time}: ${_getTime()}"),
          CustomText(
              "${AppLocalizations.of(context)?.location}: ${_district.toLocalizedName(localName)} $_court"),
          CustomText(
              "${AppLocalizations.of(context)?.matchType}: ${_matchType.toLocalizedName(context)}"),
          CustomText(
              "${AppLocalizations.of(context)?.ustaLevel}: ${_getUstaLevelRange()}"),
          CustomText(
            "${AppLocalizations.of(context)?.remarks}: ${_remarks ?? ""}",
            maxLines: shouldShowAllRemarks ? 10 : 1,
          ),
        ],
      ),
    );
  }
}
