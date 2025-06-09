// screens/organizer/home_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import necessário para o User
import 'package:festa_facil/models/event_model.dart';
import 'package:festa_facil/screens/organizer/create_event_screen.dart';
import 'packagee:festa_facil/services/auth_service.dart';
import 'package:festa_facil/services/firestore_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  Stream<QuerySnapshot>? _eventsStream;

  @override
  void initState() {
    super.initState();
    print("--- HomeScreen initState() CHAMADO ---");

    // Mantemos a inicialização do stream de eventos
    _eventsStream = _firestoreService.getEventsStream();
    print("Stream de eventos inicializado.");

    // --- NOSSO NOVO "ESPIÃO" ADICIONADO AQUI ---
    // Ele vai escutar TODAS as mudanças no status de autenticação
    // enquanto esta tela estiver ativa.
    _authService.authStateChanges.listen((User? user) {
      if (user == null) {
        print("!!! AuthState Listener na HomeScreen: O USUÁRIO FICOU NULO !!!");
      } else {
        print(">>> AuthState Listener na HomeScreen: Usuário está PRESENTE. ID: ${user.uid}");
      }
    });
    print("O 'espião' do status de autenticação foi ativado.");
  }

  @override
  Widget build(BuildContext context) {
    print("--- HomeScreen build() CHAMADO ---");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Eventos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _eventsStream,
        builder: (context, snapshot) {
          print("--- StreamBuilder se reconstruiu. Status da conexão: ${snapshot.connectionState} ---");

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum evento encontrado.\nClique no '+' para criar seu primeiro evento!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Ocorreu um erro!"));
          }

          final eventDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: eventDocs.length,
            itemBuilder: (context, index) {
              final event = EventModel.fromFirestore(eventDocs[index]);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: const Icon(Icons.event, color: Colors.blue),
                  title: Text(
                    event.eventName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      '${event.eventDate.day}/${event.eventDate.month}/${event.eventDate.year}'),
                  onTap: () {
                    print("Evento selecionado: ${event.eventName}");
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateEventScreen()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Criar Novo Evento',
      ),
    );
  }
}