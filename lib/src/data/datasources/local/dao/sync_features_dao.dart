part of '../app_database.dart';

class SyncFeaturesDao {
  final AppDatabase _appDatabase;

  SyncFeaturesDao(this._appDatabase);

  List<Feature> parseFeature(
    List<Map<String,dynamic>> featureLists){
    final features = <Feature>[];
      for(var featureMap in featureLists){
        final client = Feature.fromMap(featureMap);
        features.add(client);
      }
      return features;
  }

  Future<List<Feature>> getAllFeature() async {
    final db = await _appDatabase.streamDatabase;
    final featureList = await db!.query(tableFeature);
    final feature = parseFeature(featureList);
    return feature;
  }

  Future<void> insertFeatures(List<Feature> features) async {
    final db = await _appDatabase.streamDatabase;
    var batch = db!.batch();

    await Future.forEach(features, (feature) async {
      var foundProduct = await db.query(tableFeature, where: 'coddashboard = ?', whereArgs: [feature.coddashboard]);

      if(foundProduct.isNotEmpty){
        batch.update(tableFeature, feature.toJson(), where: 'coddashboard = ?', whereArgs: [feature.coddashboard]);
      } else {
        batch.insert(tableFeature, feature.toJson());
      }
    });


    batch.commit(noResult: true, continueOnError: true);
  }

  Future<int> updateFeature(Feature feature) {
    return _appDatabase.update(tableFeature, feature.toJson(),
        'coddashboard', feature.coddashboard);
  }

  Future<void> emptyFeature() async {
    final db = await _appDatabase.streamDatabase;
    await db!.delete(tableFeature);
    return Future.value();
  }



}