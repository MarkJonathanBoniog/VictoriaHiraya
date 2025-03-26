import 'package:realm/realm.dart';

part 'match.realm.dart';

@RealmModel()
class _Match {
  late String victoryText;
  late String profile;
  late String score;
  late DateTime date;
}
