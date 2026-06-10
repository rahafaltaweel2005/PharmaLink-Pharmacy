

import '../entity/auth_response_entity.dart';

abstract class AuthRepository {
  Future<AuthResponseEntity> login({
    required String email,
    required String password,
  });
  Future<AuthResponseEntity> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String doctorName,
    required String location,
    required String licenseNumber,
  });
  Future<void> logout();
}
