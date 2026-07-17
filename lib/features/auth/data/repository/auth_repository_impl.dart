import 'package:pharma_link/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:pharma_link/features/auth/domain/entity/auth_response_entity.dart';
import 'package:pharma_link/features/auth/domain/repository/auth_repository.dart';

import '../../domain/entity/profile_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<AuthResponseEntity> login({
    required String email,
    required String password,
  }) async {
    final model = await authRemoteDatasource.login(
      email: email,
      password: password,
    );
    return model.toEntity();
  }

  @override
  Future<AuthResponseEntity> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String doctorName,
    required String location,
    required String licenseNumber,
  }) async {
    final model = await authRemoteDatasource.register(
      name: name,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
      doctorName: doctorName,
      location: location,
      licenseNumber: licenseNumber,
    );
    return model.toEntity();
  }

  @override
  Future<ProfileEntity> profile() async {
    final model = await authRemoteDatasource.profile();
    return model.toEntity();
  }

  @override
  Future<void> logout() async {
    await authRemoteDatasource.logout();
  }
}
