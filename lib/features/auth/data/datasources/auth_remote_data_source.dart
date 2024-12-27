import 'package:blog_bloc_app/core/error/server_exception.dart';
import 'package:blog_bloc_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(password: password, email: email, data: {'name': name});

      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(password: password, email: email);

      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (authException) {
      throw ServerException(authException.message);
    } catch (e) {
      final String err = e.toString();
      throw ServerException(err);
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }
      return null;
    } on AuthException catch (authException) {
      throw ServerException(authException.message);
    } catch (e) {
      final String err = e.toString();
      throw ServerException(err);
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;
}
