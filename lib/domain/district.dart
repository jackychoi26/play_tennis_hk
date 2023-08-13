import 'package:play_tennis_hk/domain/region.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum District {
  centralAndWestern,
  eastern,
  southern,
  wanChai,
  shamShuiPo,
  kowloonCity,
  kwunTong,
  wongTaiSin,
  yauTsimMong,
  islands,
  kwaiTsing,
  north,
  saiKung,
  shaTin,
  taiPo,
  tsuenWan,
  tuenMun,
  yuenLong
}

extension DistrictTranslator on District {
  // TODO: how to do dynamic look up in i10n
  String? toLocalizedName(BuildContext context) {
    switch (this) {
      case District.centralAndWestern:
        return AppLocalizations.of(context)?.centralAndWestern;
      case District.eastern:
        return AppLocalizations.of(context)?.eastern;
      case District.southern:
        return AppLocalizations.of(context)?.southern;
      case District.wanChai:
        return AppLocalizations.of(context)?.wanChai;
      case District.shamShuiPo:
        return AppLocalizations.of(context)?.shamShuiPo;
      case District.kowloonCity:
        return AppLocalizations.of(context)?.kowloonCity;
      case District.kwunTong:
        return AppLocalizations.of(context)?.kwunTong;
      case District.wongTaiSin:
        return AppLocalizations.of(context)?.wongTaiSin;
      case District.yauTsimMong:
        return AppLocalizations.of(context)?.yauTsimMong;
      case District.islands:
        return AppLocalizations.of(context)?.islands;
      case District.kwaiTsing:
        return AppLocalizations.of(context)?.kwaiTsing;
      case District.north:
        return AppLocalizations.of(context)?.north;
      case District.saiKung:
        return AppLocalizations.of(context)?.saiKung;
      case District.shaTin:
        return AppLocalizations.of(context)?.shaTin;
      case District.taiPo:
        return AppLocalizations.of(context)?.taiPo;
      case District.tsuenWan:
        return AppLocalizations.of(context)?.tsuenWan;
      case District.tuenMun:
        return AppLocalizations.of(context)?.tuenMun;
      case District.yuenLong:
        return AppLocalizations.of(context)?.yuenLong;
      default:
        return null;
    }
  }
}

extension DistrictMapper on District {
  Region toRegion() {
    switch (this) {
      // HK island region
      case District.centralAndWestern:
      case District.wanChai:
      case District.eastern:
      case District.southern:
        return Region.hkIsland;
      case District.yauTsimMong:
      case District.shamShuiPo:
      case District.kowloonCity:
      case District.wongTaiSin:
      case District.kwunTong:
        return Region.kowloon;
      case District.kwaiTsing:
      case District.tsuenWan:
      case District.tuenMun:
      case District.yuenLong:
      case District.islands:
      case District.north:
      case District.taiPo:
      case District.shaTin:
      case District.saiKung:
        return Region.newTerritories;
    }
  }

  String toKey() {
    switch (this) {
      case District.centralAndWestern:
        return 'CENTRAL_AND_WESTERN';
      case District.eastern:
        return 'EASTERN';
      case District.southern:
        return 'SOUTHERN';
      case District.wanChai:
        return 'WAN_CHAI';
      case District.shamShuiPo:
        return 'SHAM_SHUI_PO';
      case District.kowloonCity:
        return 'KOWLOON_CITY';
      case District.kwunTong:
        return 'KWUN_TONG';
      case District.wongTaiSin:
        return 'WONG_TAI_SIN';
      case District.yauTsimMong:
        return 'YAU_TSIM_MONG';
      case District.islands:
        return 'ISLANDS';
      case District.kwaiTsing:
        return 'KWAI_TSING';
      case District.north:
        return 'NORTH';
      case District.saiKung:
        return 'SAI_KUNG';
      case District.shaTin:
        return 'SHA_TIN';
      case District.taiPo:
        return 'TAI_PO';
      case District.tsuenWan:
        return 'TSUEN_WAN';
      case District.tuenMun:
        return 'TUEN_MUN';
      case District.yuenLong:
        return 'YUEN_LONG';
    }
  }
}
