// models/event_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
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

  // --- NOVO MÉTODO ADICIONADO AQUI ---
  // Factory constructor para criar um EventModel a partir de um documento do Firestore
  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return EventModel(
      id: doc.id, // Pega o ID do próprio documento
      eventName: data['eventName'] ?? '', // ?? '' para evitar erros se o campo for nulo
      // Converte o Timestamp do Firebase de volta para DateTime
      eventDate: (data['eventDate'] as Timestamp).toDate(),
      description: data['description'] ?? '',
      organizerId: data['organizerId'] ?? '',
    );
  }
}