import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:play_tennis_hk/features/filter/domain/entities/tennis_matches_filter_options.dart';
import 'package:play_tennis_hk/features/filter/domain/repositories/tennis_matches_filter_options_repository.dart';

class TennisMatchesFilterOptionsRepositoryImpl
    implements TennisMatchesFilterOptionsRepository {
  final _key = "tennisMatchesFilterOptions";

  @override
  Future<TennisMatchesFilterOptions?> getTennisMatchesFilterOptions() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(_key);
    if (value != null) {
      try {
        print(value);
        return TennisMatchesFilterOptions.fromJson(json.decode(value));
      } catch (err) {
        print(err);
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<void> storeTennisMatchesFilterOptions(
    TennisMatchesFilterOptions tennisMatchesFilterOptions,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(
      _key,
      json.encode(tennisMatchesFilterOptions),
    );
  }
}
