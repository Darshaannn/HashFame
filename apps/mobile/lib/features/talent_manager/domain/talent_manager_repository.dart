import '../domain/talent_manager_profile.dart';

abstract interface class TalentManagerRepository {
  Future<TalentManagerProfile> getProfile({String? userId});
  Future<TalentManagerProfile> updateProfile(TalentManagerProfile profile);
}

abstract interface class TalentManagerDataSource {
  String? get userId;
  Future<TalentManagerProfile> getProfile({String? userId});
  Future<TalentManagerProfile> updateProfile(TalentManagerProfile profile);
}
