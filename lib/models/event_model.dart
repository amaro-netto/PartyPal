// models/event_model.dart

class EventModel {
  final String id; // ID único do evento
  final String eventName;
  final DateTime eventDate;
  final String description;
  final String organizerId;

  EventModel({
    required this.id,
    required this.eventName,
    required this.eventDate,
    required this.description,
    required this.organizerId,
  });
}