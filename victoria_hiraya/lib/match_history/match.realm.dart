// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Match extends _Match with RealmEntity, RealmObjectBase, RealmObject {
  Match(
    String victoryText,
    String profile,
    String score,
    DateTime date,
  ) {
    RealmObjectBase.set(this, 'victoryText', victoryText);
    RealmObjectBase.set(this, 'profile', profile);
    RealmObjectBase.set(this, 'score', score);
    RealmObjectBase.set(this, 'date', date);
  }

  Match._();

  @override
  String get victoryText =>
      RealmObjectBase.get<String>(this, 'victoryText') as String;
  @override
  set victoryText(String value) =>
      RealmObjectBase.set(this, 'victoryText', value);

  @override
  String get profile => RealmObjectBase.get<String>(this, 'profile') as String;
  @override
  set profile(String value) => RealmObjectBase.set(this, 'profile', value);

  @override
  String get score => RealmObjectBase.get<String>(this, 'score') as String;
  @override
  set score(String value) => RealmObjectBase.set(this, 'score', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  Stream<RealmObjectChanges<Match>> get changes =>
      RealmObjectBase.getChanges<Match>(this);

  @override
  Stream<RealmObjectChanges<Match>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Match>(this, keyPaths);

  @override
  Match freeze() => RealmObjectBase.freezeObject<Match>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'victoryText': victoryText.toEJson(),
      'profile': profile.toEJson(),
      'score': score.toEJson(),
      'date': date.toEJson(),
    };
  }

  static EJsonValue _toEJson(Match value) => value.toEJson();
  static Match _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'victoryText': EJsonValue victoryText,
        'profile': EJsonValue profile,
        'score': EJsonValue score,
        'date': EJsonValue date,
      } =>
        Match(
          fromEJson(victoryText),
          fromEJson(profile),
          fromEJson(score),
          fromEJson(date),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Match._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Match, 'Match', [
      SchemaProperty('victoryText', RealmPropertyType.string),
      SchemaProperty('profile', RealmPropertyType.string),
      SchemaProperty('score', RealmPropertyType.string),
      SchemaProperty('date', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
