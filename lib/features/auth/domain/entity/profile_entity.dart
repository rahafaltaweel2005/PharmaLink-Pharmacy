import 'package:pharma_link/features/auth/domain/entity/user_role.dart';

class ProfileEntity {
  final int id;
  final String name;
  final String email;
  final UserRole role;
  final String phoneNumber;
  final String doctorName;
  final String location;
  final String licenseNumber;

  ProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    required this.doctorName,
    required this.location,
    required this.licenseNumber,
  });
}
