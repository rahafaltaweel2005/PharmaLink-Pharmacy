import 'package:pharma_link/features/medicine/domain/entity/medicine_entity.dart';
import 'package:pharma_link/features/medicine/domain/repository/medicine_repository.dart';

class GetMedicinesUseCase {
  final MedicineRepository medicineRepository;

  GetMedicinesUseCase({required this.medicineRepository});

  Future<List<MedicineEntity>> call() {
    return medicineRepository.getMedicines();
  }
}
