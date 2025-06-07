import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _partyNameController = TextEditingController();
  // Lista para armazenar os itens e quantidades
  final List<Map<String, String>> _items = [];

  @override
  void dispose() {
    _partyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela do Administrador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _partyNameController,
              decoration: const InputDecoration(
                labelText: 'Nome da Festa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Itens da Festa:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]['item'] ?? ''),
                    trailing: Text(_items[index]['quantity'] ?? ''),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ação para adicionar um novo item
                _addItemDialog();
              },
              child: const Text('Adicionar Item'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ação para salvar os detalhes da festa
                _savePartyDetails();
              },\
              child: const Text('Salvar Festa'),
            ),
          ],
        ),
      ),
    );
  }

  void _addItemDialog() {
    final TextEditingController itemController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Novo Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: itemController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Item',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantidade',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // Para facilitar a entrada de números
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                itemController.dispose();
                quantityController.dispose();
              },
            ),
            ElevatedButton(
              child: const Text('Adicionar'),
              onPressed: () {
                if (itemController.text.isNotEmpty && quantityController.text.isNotEmpty) {
                  setState(() {
                    _items.add({
                      'item': itemController.text,
                      'quantity': quantityController.text,
                    });
                  });
                  Navigator.of(context).pop(); // Fecha o diálogo
                  itemController.dispose();
                  quantityController.dispose();
                } else {
                  // Opcional: mostrar um SnackBar ou outra indicação que os campos são obrigatórios
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _savePartyDetails() {
    // Lógica para salvar os detalhes (vamos implementar)
    String partyName = _partyNameController.text;
    // _items contém a lista de itens e quantidades
    print('Nome da Festa: $partyName');
    print('Itens: $_items');
    // Aqui você integraria com um backend ou salvaria localmente
  }
}
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _partyNameController = TextEditingController();
  // Lista para armazenar os itens e quantidades
  final List<Map<String, String>> _items = [];

  @override
  void dispose() {
    _partyNameController.dispose();
    super.dispose();
  }

  void _addItemDialog() {
    final TextEditingController itemController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Novo Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: itemController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Item',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantidade',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // Para facilitar a entrada de números
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                itemController.dispose();
                quantityController.dispose();
              },
            ),
            ElevatedButton(
              child: const Text('Adicionar'),
              onPressed: () {
                if (itemController.text.isNotEmpty && quantityController.text.isNotEmpty) {
                  setState(() {
                    _items.add({
                      'item': itemController.text,
                      'quantity': quantityController.text,
                    });
                  });
                  Navigator.of(context).pop(); // Fecha o diálogo
                  itemController.dispose();
                  quantityController.dispose();
                } else {
                  // Opcional: mostrar um SnackBar ou outra indicação que os campos são obrigatórios
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Método para remover um item
  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _savePartyDetails() {
    // Lógica para salvar os detalhes (vamos implementar)
    String partyName = _partyNameController.text;
    // _items contém a lista de itens e quantidades
    print('Nome da Festa: $partyName');
    print('Itens: $_items');
    // Aqui você integraria com um backend ou salvaria localmente
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela do Administrador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _partyNameController,
              decoration: const InputDecoration(
                labelText: 'Nome da Festa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Itens da Festa:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]['item'] ?? ''),
                    trailing: IconButton( // Adicionado IconButton para remover
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _removeItem(index); // Chama o método para remover o item
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ação para adicionar um novo item
                _addItemDialog();
              },
              child: const Text('Adicionar Item'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ação para salvar os detalhes da festa
                _savePartyDetails();
              },
              child: const Text('Salvar Festa'),
            ),
          ],
        ),
      ),
    );
  }
}
