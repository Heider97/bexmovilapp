part of 'sync_features_bloc.dart';


abstract class SyncFeaturesEvent{}


class SyncFeatureAdd extends SyncFeaturesEvent{}

class SyncFeatureGet extends SyncFeaturesEvent{}