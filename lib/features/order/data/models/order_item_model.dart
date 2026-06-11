import '../../domain/entity/order_item_entity.dart';

class  OrderItemModel {
  int? medicineId;
  int? quantity;
  double? unitPrice;

  OrderItemModel({this.medicineId, this.quantity, this.unitPrice});

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    medicineId = json['medicineId'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicineId'] = this.medicineId;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    return data;
  }
  OrderItemEntity toEntity() {
    return OrderItemEntity(
      medicineId: medicineId!,
      quantity: quantity!,
      unitPrice: unitPrice!,
    );
  }
}


