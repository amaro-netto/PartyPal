// screens/organizer/home_screen.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festa_facil/models/event_model.dart';
import 'package:festa_facil/screens/organizer/create_event_screen.dart';
import 'package:festa_facil/services/auth_service.dart';
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

  // --- MUDANÇA 1: Variável para guardar nossa conexão (Stream) ---
  Stream<QuerySnapshot>? _eventsStream;

  // --- MUDANÇA 2: O método initState() ---
  // Este método é chamado APENAS UMA VEZ quando a tela é criada.
  @override
  void initState() {
    super.initState();
    // Nós iniciamos a conexão aqui e guardamos na nossa variável.
    _eventsStream = _firestoreService.getEventsStream();
  }

  @override
  Widget build(BuildContext context) {
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
        // --- MUDANÇA 3: Usamos a variável que guardamos, em vez de criar uma nova ---
        stream: _eventsStream,
        builder: (context, snapshot) {
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
                    // TODO: Navegar para a tela de detalhes do evento
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