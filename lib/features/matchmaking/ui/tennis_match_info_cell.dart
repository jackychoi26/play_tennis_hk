import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/core/extensions/date_time_formatter.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/domain/region.dart';
import 'package:play_tennis_hk/features/matchmaking/ui/partner_detail_screen.dart';

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

  Color _getBackgroundColor() {
    switch (district.toRegion()) {
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

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PartnerDetailScreen(),
          ),
        );
      },
      child: Container(
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
                "${AppLocalizations.of(context)?.location}: ${district.toLocalizedName(localName)} $court"),
            CustomText(
                "${AppLocalizations.of(context)?.ustaLevel}: ${_getUstaLevelRange()}"),
            CustomText(
                "${AppLocalizations.of(context)?.remarks}: ${remarks ?? ""}"),
          ],
        ),
      ),
    );
  }
}
