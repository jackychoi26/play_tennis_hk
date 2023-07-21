import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum MatchType {
  training,
  singles,
  doubles,
  mensSingles,
  womensSingles,
  mensDoubles,
  womensDoubles,
  mixedDoubles,
}

extension MatchTypeTranslator on MatchType {
  // TODO: how to do dynamic look up in i10n
  String? toLocalizedName(BuildContext context) {
    final localeName = AppLocalizations.of(context)?.localeName;
    if (localeName == null) return null;

    switch (this) {
      case MatchType.training:
        return AppLocalizations.of(context)?.training;
      case MatchType.singles:
        return AppLocalizations.of(context)?.singles;
      case MatchType.doubles:
        return AppLocalizations.of(context)?.doubles;
      case MatchType.mensSingles:
        return AppLocalizations.of(context)?.mensSingles;
      case MatchType.womensSingles:
        return AppLocalizations.of(context)?.womensSingles;
      case MatchType.mensDoubles:
        return AppLocalizations.of(context)?.mensDoubles;
      case MatchType.womensDoubles:
        return AppLocalizations.of(context)?.womensDoubles;
      case MatchType.mixedDoubles:
        return AppLocalizations.of(context)?.mixedDoubles;
    }
  }
}

extension MatchTypeMapper on MatchType {
  String toJson() {
    switch (this) {
      case MatchType.training:
        return 'TRAINING';
      case MatchType.singles:
        return 'SINGLES';
      case MatchType.doubles:
        return 'DOUBLES';
      case MatchType.mensSingles:
        return 'MENS_SINGLES';
      case MatchType.womensSingles:
        return 'WOMENS_SINGLES';
      case MatchType.mensDoubles:
        return 'MENS_DOUBLES';
      case MatchType.womensDoubles:
        return 'WOMENS_DOUBLES';
      case MatchType.mixedDoubles:
        return 'MIXED_DOUBLES';
    }
  }
}
