import 'account.dart';

abstract interface class AccountRepository {
  Future<AccountSnapshot> load();
  Future<Account> completeOnboarding(ProfessionalRole role, String name);
  Future<Account> updateName(String name);
  Future<AccountSettings> settings();
  Future<void> updateSettings(AccountSettings settings);
  Future<String> requestDeletion();
  Future<void> clearCache();
}
