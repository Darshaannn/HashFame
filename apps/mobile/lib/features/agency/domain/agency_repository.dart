import '../domain/agency_profile.dart';

abstract interface class AgencyRepository {
  Future<AgencyProfile> getProfile({String? userId});
  Future<AgencyProfile> updateProfile(AgencyProfile profile);
}

abstract interface class AgencyDataSource {
  String? get userId;
  Future<AgencyProfile> getProfile({String? userId});
  Future<AgencyProfile> updateProfile(AgencyProfile profile);
}
