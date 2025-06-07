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
      // O corpo agora é um StreamBuilder
      body: StreamBuilder<QuerySnapshot>(
        // Conecta-se à nossa nova função que "escuta" os eventos
        stream: _firestoreService.getEventsStream(),
        builder: (context, snapshot) {
          // Se estiver esperando dados, mostra uma tela de carregamento
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Se não houver dados ou a lista estiver vazia
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum evento encontrado.\nClique no '+' para criar seu primeiro evento!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          // Se houver algum erro
          if (snapshot.hasError) {
            return const Center(child: Text("Ocorreu um erro!"));
          }

          // Se tiver dados, pega a lista de documentos
          final eventDocs = snapshot.data!.docs;

          // Usa um ListView.builder para construir a lista de forma eficiente
          return ListView.builder(
            itemCount: eventDocs.length,
            itemBuilder: (context, index) {
              // Para cada documento, cria um objeto EventModel
              final event = EventModel.fromFirestore(eventDocs[index]);

              // Cria um card bonito para exibir o evento
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