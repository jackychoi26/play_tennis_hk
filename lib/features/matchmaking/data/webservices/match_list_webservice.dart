import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/matchmaking/domain/entities/match_list.dart';

class MatchListWebservice extends Webservice {
  performRequest() async {
    final response = await dio.get('/matchmaking');
    try {
      final matchList = MatchList.fromJson(response.data);
      return matchList;
    } catch (err) {
      print(err);
    }
  }
}
