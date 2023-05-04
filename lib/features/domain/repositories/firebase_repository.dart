import '../entities/user_entity.dart';

// Credential Section

abstract class FirebaseRepository {
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<void> googleAuth();
  Future<void> forgotPassword(String email);

  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<void> getUpdateUser(UserEntity user);
  Future<String> getCurrentUId();
  Stream<List<UserEntity>> getAllUsers();
}
