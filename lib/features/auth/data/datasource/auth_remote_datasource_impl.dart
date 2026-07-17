import '../../../../core/constant/api_const.dart';
import '../../../../core/constant/app_const.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/secure_storage_helper.dart';
import 'package:pharma_link/features/auth/data/models/auth_response_model.dart';
import '../models/profile_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.post(
      endpoint: ApiConst.login,
      data: {'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String doctorName,
    required String location,
    required String licenseNumber,
  }) async {
    final response = await ApiClient.post(
      endpoint: ApiConst.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'doctorName': doctorName,
        'location': location,
        'licenseNumber': licenseNumber,
      },
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<ProfileModel> profile() async {
    final response = await ApiClient.get(endpoint: ApiConst.profile);
    return ProfileModel.fromJson(response.data);
  }

  @override
  Future<void> logout() async {
    final refreshToken = await SecureStorageHelper.read(
      key: AppConst.refreshTokenKey,
    );
    await ApiClient.post(
      endpoint: ApiConst.logout,
      data: {"refreshToken": refreshToken},
    );
    await SecureStorageHelper.deleteAll();
  }
}
