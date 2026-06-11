class OrderItemEntity {
  final int medicineId;
  final int quantity;
  final double unitPrice;

  OrderItemEntity({
    required this.medicineId,
    required this.quantity,
    required this.unitPrice,
  });
}