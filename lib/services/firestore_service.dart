// services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // Pega a instância do banco de dados Firestore
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Pega a instância do Firebase Auth para saber quem está logado
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Função para criar um novo evento
  Future<void> createEvent(String eventName, DateTime eventDate, String description) async {
    // Pega o usuário atualmente logado
    final User? user = _auth.currentUser;

    // Se não houver usuário logado, não faz nada.
    if (user == null) return;

    // Cria um novo documento na coleção "events"
    await _db.collection('events').add({
      'organizerId': user.uid, // Salva o ID do organizador para saber quem criou
      'eventName': eventName,
      'eventDate': Timestamp.fromDate(eventDate), // Converte DateTime para o formato do Firebase
      'description': description,
      'createdAt': FieldValue.serverTimestamp(), // Salva a data de criação
    });
  }
}