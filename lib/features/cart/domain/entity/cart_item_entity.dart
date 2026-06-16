import '../../../medicine/domain/entity/medicine_entity.dart';
import '../../../order/domain/entity/order_item_entity.dart';

class CartItemEntity {
  final MedicineEntity medicine;
  final int quantity;

  CartItemEntity({required this.medicine, required this.quantity});

  double get totalPrice {
    return medicine.price * quantity;
  }

  CartItemEntity copyWith({
  int? quantity,
  }){
    return CartItemEntity(
        medicine: medicine,
        quantity: quantity ?? this.quantity
    );
  }

  OrderItemEntity toOrderItemEntity() {
    return OrderItemEntity(
      medicineId: medicine.id,
      medicineName: medicine.name,
      quantity: quantity,
      unitPrice: medicine.price,
    );
  }

}
