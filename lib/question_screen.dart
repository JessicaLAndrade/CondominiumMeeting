import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulação de dados
    String question = 'Você concorda em realizar uma reforma na área de lazer?';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Votação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica para registrar o voto "Sim"
              },
              child: const Text('Sim'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Lógica para registrar o voto "Não"
              },
              child: const Text('Não'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para disparar a notificação de autorização para o síndico
        },
        child: const Icon(Icons.notifications),
      ),
    );
  }
}
