import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  GoTrueClient get auth => _client.auth;

  Future<bool> signIn() async {
    const webClientId =
        '369629569845-j468t4qeh12o5v24s1m1b6bcel0ksfji.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(serverClientId: webClientId);
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      return false;
    }

    await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    return true;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  bool isAuthorized() {
    return _client.auth.currentUser != null;
  }

  Future<int?> userId() async {
    var response = await _client.auth.getUser();
    if (response.user == null) {
      return null;
    }

    var idTable =
        await _client
            .from('users')
            .select('id')
            .eq('auth_id', response.user!.id)
            .single();

    return idTable['id'];
  }
}
