import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/account.dart';

abstract interface class AccountDataSource {
  String? get userId;
  Future<Account> load();
  Future<Account> onboard(ProfessionalRole role, String name);
  Future<Account> updateName(String name);
  Future<AccountSettings> settings();
  Future<void> updateSettings(AccountSettings settings);
  Future<String> requestDeletion();
}

class SupabaseAccountDataSource implements AccountDataSource {
  SupabaseAccountDataSource(this.client);
  final SupabaseClient client;
  @override
  String? get userId => client.auth.currentUser?.id;
  String get _actor => userId ?? (throw const AuthException('Session missing'));
  @override
  Future<Account> load() async => Account.fromJson(
    await client
        .from('profiles')
        .select(
          'id,display_name,primary_role_label,account_state,updated_at,avatar_path',
        )
        .eq('id', _actor)
        .single(),
  );
  @override
  Future<Account> onboard(ProfessionalRole role, String name) async {
    final json = await client.rpc(
      'complete_onboarding',
      params: {'chosen_role': role.wire, 'name': name},
    );
    return Account.fromJson(Map<String, dynamic>.from(json as Map));
  }

  @override
  Future<Account> updateName(String name) async => Account.fromJson(
    await client
        .from('profiles')
        .update({'display_name': name})
        .eq('id', _actor)
        .select()
        .single(),
  );
  @override
  Future<AccountSettings> settings() async => AccountSettings.fromJson(
    await client
        .from('user_settings')
        .select('locale,theme_preference,notification_preferences')
        .eq('user_id', _actor)
        .single(),
  );
  @override
  Future<void> updateSettings(AccountSettings settings) async {
    await client
        .from('user_settings')
        .update(settings.toJson())
        .eq('user_id', _actor);
  }

  @override
  Future<String> requestDeletion() async {
    // RLS-controlled RPC: actor derives exclusively from the JWT.
    final result = await client.rpc('request_account_deletion');
    if (result is! String) {
      throw const FormatException('Malformed deletion receipt');
    }
    return result;
  }
}
