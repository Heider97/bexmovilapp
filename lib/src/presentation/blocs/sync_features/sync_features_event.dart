part of 'sync_features_bloc.dart';

abstract class SyncFeaturesEvent{}

class SyncFeatureLeave extends SyncFeaturesEvent{}

class SyncFeatureGet extends SyncFeaturesEvent{}