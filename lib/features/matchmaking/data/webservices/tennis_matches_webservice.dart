import 'dart:async';

import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/features/filter/domain/entities/tennis_matches_filter_options.dart';
import 'package:play_tennis_hk/features/matchmaking/data/webservices/tennis_matches_response.dart';

class TennisMatchesWebservice extends Webservice {
  TennisMatchesWebservice(
    this._tennisMatchesFilterOptions,
  );

  final TennisMatchesFilterOptions _tennisMatchesFilterOptions;

  Future<TennisMatchesResponse> performRequest({required num offset}) async {
    final response =
        await dio.get(_getEndpoint(_tennisMatchesFilterOptions, offset));

    try {
      final tennisMatches = TennisMatchesResponse.fromJson(response.data);
      return tennisMatches;
    } catch (err) {
      rethrow;
    }
  }

  String _getEndpoint(
      TennisMatchesFilterOptions tennisMatchesFilterOptions, num offset) {
    final lowerNtrpLevel = tennisMatchesFilterOptions.lowerNtrpLevel;
    final upperNtrpLevel = tennisMatchesFilterOptions.upperNtrpLevel;
    final selectedDistricts = tennisMatchesFilterOptions.selectedDistricts
        .map((e) => e.toKey())
        .toList();

    return "/matchmaking/all?lowerNtrpLevel=$lowerNtrpLevel&upperNtrpLevel=$upperNtrpLevel&selectedDistricts=$selectedDistricts&offset=$offset";
  }
}
