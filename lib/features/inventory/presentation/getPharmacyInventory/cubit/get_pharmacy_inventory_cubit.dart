import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/get_pharmacy_inventory_use_case.dart';
import '../state/get_pharmacy_inventory_state.dart';

class GetPharmacyInventoryCubit extends Cubit<GetPharmacyInventoryState> {
  final GetPharmacyInventoryUseCase getMainInventoryUseCase;

  GetPharmacyInventoryCubit({required this.getMainInventoryUseCase})
    : super(GetPharmacyInventoryInitialState());

  Future<void> getPharmacyInventory() async {
    emit(GetPharmacyInventoryLoadingState());
    try {
      final inventory = await getMainInventoryUseCase();
      emit(GetPharmacyInventoryLoadedState(inventory: inventory));
    } catch (error) {
      emit(GetPharmacyInventoryErrorState(error: error.toString()));
    }
  }
}
