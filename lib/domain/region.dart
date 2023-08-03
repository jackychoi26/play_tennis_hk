import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Region { hkIsland, kowloon, newTerritories }

extension RegionTranslator on Region {
  // TODO: how to do dynamic look up in i10n
  String? toLocalizedName(BuildContext context) {
    switch (this) {
      case Region.newTerritories:
        return AppLocalizations.of(context)?.newTerritories;
      case Region.kowloon:
        return AppLocalizations.of(context)?.kowloon;
      case Region.hkIsland:
        return AppLocalizations.of(context)?.hkIsland;
    }
  }
}
