// models/guest_model.dart

class GuestModel {
  final String id;
  final String guestName;
  final List<String> additionalGuests; // Lista de acompanhantes
  final String itemTakenId; // ID do item que ele vai levar
  final double quantityBrought; // Quanto ele vai levar

  GuestModel({
    required this.id,
    required this.guestName,
    required this.additionalGuests,
    required this.itemTakenId,
    required this.quantityBrought,
  });
}