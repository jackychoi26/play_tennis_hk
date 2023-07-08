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
  String toLocalizedName(String? locale) {
    if (locale == 'zh') {
      switch (this) {
        case District.centralAndWestern:
          return '中西區';
        case District.eastern:
          return '東區';
        case District.southern:
          return '南區';
        case District.wanChai:
          return '灣仔區';
        case District.shamShuiPo:
          return '深水埗區';
        case District.kowloonCity:
          return '九龍城區';
        case District.kwunTong:
          return '觀塘區';
        case District.wongTaiSin:
          return '黃大仙區';
        case District.yauTsimMong:
          return '油尖旺區';
        case District.islands:
          return '離島區';
        case District.kwaiTsing:
          return '葵青區';
        case District.north:
          return '北區';
        case District.saiKung:
          return '西貢區';
        case District.shaTin:
          return '沙田區';
        case District.taiPo:
          return '大埔區';
        case District.tsuenWan:
          return '荃灣區';
        case District.tuenMun:
          return '屯門區';
        case District.yuenLong:
          return '元朗區';
        default:
          return '';
      }
    } else {
      switch (this) {
        case District.centralAndWestern:
          return 'Central and Western';
        case District.eastern:
          return 'Eastern';
        case District.southern:
          return 'Southern';
        case District.wanChai:
          return 'Wan Chai';
        case District.shamShuiPo:
          return 'Sham Shui Po';
        case District.kowloonCity:
          return 'Kowloon City';
        case District.kwunTong:
          return 'Kwun Tong';
        case District.wongTaiSin:
          return 'Wong Tai Sin';
        case District.yauTsimMong:
          return 'Yau Tsim Mong';
        case District.islands:
          return 'Islands';
        case District.kwaiTsing:
          return 'Kwai Tsing';
        case District.north:
          return 'North';
        case District.saiKung:
          return 'Sai Kung';
        case District.shaTin:
          return 'Sha Tin';
        case District.taiPo:
          return 'Tai Po';
        case District.tsuenWan:
          return 'Tsuen Wan';
        case District.tuenMun:
          return 'Tuen Mun';
        case District.yuenLong:
          return 'Yuen Long';
        default:
          return '';
      }
    }
  }
}
