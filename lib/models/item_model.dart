// models/item_model.dart

class ItemModel {
  final String id;
  final String itemName;
  final double quantityNeeded; // Quantidade necessária (ex: 5 kg)
  final double quantityTaken;  // Quantidade já confirmada (ex: 2 kg)
  final String unit; // Unidade de medida (kg, pacotes, garrafas)

  ItemModel({
    required this.id,
    required this.itemName,
    required this.quantityNeeded,
    required this.quantityTaken,
    required this.unit,
  });
}