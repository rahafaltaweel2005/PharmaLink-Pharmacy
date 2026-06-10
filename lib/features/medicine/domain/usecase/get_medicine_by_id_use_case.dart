import 'package:pharma_link/features/medicine/domain/entity/medicine_entity.dart';
import 'package:pharma_link/features/medicine/domain/repository/medicine_repository.dart';

class GetMedicineByIdUseCase {
  final MedicineRepository medicineRepository;

  GetMedicineByIdUseCase({required this.medicineRepository});

  Future<MedicineEntity> call({required int id}){
    return medicineRepository.getMedicineById(id: id);
  }
}
