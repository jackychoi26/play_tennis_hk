import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/core/extensions/date_time_formatter.dart';
import 'package:play_tennis_hk/domain/district.dart';

class MatchInfoCell extends StatelessWidget {
  const MatchInfoCell({
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

  String _getDate(String? localName) {
    if (localName == "zh") {
      return startDateTime.getChineseMonthDayValue();
    } else {
      return startDateTime.getEnglishMonthDayValue();
    }
  }

  String _getTime() {
    final startHour = startDateTime.getHourIn12HoursFormat();
    final endHour = endDateTime.getHourIn12HoursFormat();
    return "$startHour-$endHour ${endDateTime.isPm() ? "pm" : "am"}";
  }

  String _getUstaLevelRange() {
    if (ustaLevelRange.length == 1) {
      return ustaLevelRange.first.toString();
    } else {
      return "${ustaLevelRange.first.toString()} - ${ustaLevelRange.last.toString()}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final localName = AppLocalizations.of(context)?.localeName;

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
          Text("${AppLocalizations.of(context)?.date}: ${_getDate(localName)}"),
          Text("${AppLocalizations.of(context)?.time}: ${_getTime()}"),
          Text(
              "${AppLocalizations.of(context)?.location}: ${district.toLocalizedName(localName)} $court"),
          Text(
              "${AppLocalizations.of(context)?.ustaLevel}: ${_getUstaLevelRange()}"),
          Text("${AppLocalizations.of(context)?.remarks}: ${remarks ?? ""}"),
        ],
      ),
    );
  }
}
