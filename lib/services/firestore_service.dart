// services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- FUNÇÃO DE CRIAR EVENTO (JÁ EXISTIA) ---
  Future<void> createEvent(String eventName, DateTime eventDate, String description) async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    await _db.collection('events').add({
      'organizerId': user.uid,
      'eventName': eventName,
      'eventDate': Timestamp.fromDate(eventDate),
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // --- NOVA FUNÇÃO ADICIONADA AQUI ---
  // Retorna uma "corrente" de dados (Stream) com os eventos do usuário logado
  Stream<QuerySnapshot> getEventsStream() {
    final User? user = _auth.currentUser;
    if (user == null) {
      // Retorna uma stream vazia se não houver usuário
      return const Stream.empty();
    }

    // Pega todos os eventos da coleção 'events' ONDE o 'organizerId' é igual
    // ao ID do usuário logado, ordenados pela data de criação (mais novos primeiro).
    return _db
        .collection('events')
        .where('organizerId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots(); // .snapshots() é o que torna a consulta em tempo real!
  }
}