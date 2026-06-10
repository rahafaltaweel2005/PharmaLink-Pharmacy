import 'package:pharma_link/features/medicine/domain/repository/medicine_repository.dart';

import '../entity/medicine_type.dart';

class UpdateMedicineUseCase {
  final MedicineRepository medicineRepository;

  UpdateMedicineUseCase({required this.medicineRepository});

  Future<void> call({
    required int id,
    required String name,
    required String imageUrl,
    String? description,
    required double price,
    required MedicineType type,
  }) {
    return medicineRepository.updateMedicine(
      id: id,
      name: name,
      imageUrl: imageUrl,
      description: description,
      price: price,
      type: type,
    );
  }
}
