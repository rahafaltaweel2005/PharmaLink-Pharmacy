import 'package:pharma_link/features/auth/data/models/auth_response_model.dart';
abstract class AuthRemoteDatasource {
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> register({
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
