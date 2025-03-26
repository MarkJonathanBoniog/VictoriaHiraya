import 'package:realm/realm.dart';
import 'package:victoria_hiraya/match_history/match.dart';

class MatchHistoryModel {
  late Realm realm;
  late RealmResults<Match> matches;

  MatchHistoryModel() {
    final config = Configuration.local([Match.schema]);
    realm = Realm(config);
    matches = realm.query<Match>("TRUEPREDICATE SORT(date DESC)");
  }

  RealmResults<Match> get matchHistory => matches;

  void addMatch(
    String victoryText,
    String profile,
    String score,
  ) {
    Match newMatch = Match(victoryText, profile, score, DateTime.now());
    realm.write(() {
      realm.add(newMatch);
      // realm.deleteAll<Match>();
    });
  }
}
