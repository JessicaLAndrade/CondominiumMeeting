import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VotingScreen extends StatelessWidget {
  final String googleFormsUrl =
      'https://docs.google.com/forms/d/e/1FAIpQLSdxhCbeWK8ONnkIVHv2v4B968aEBybpkUtQYSLBLhoJFcx9iQ/viewform';

  const VotingScreen({super.key}); // URL do Google Forms

  void launchGoogleForms() async {
    if (await canLaunch(googleFormsUrl)) {
      await launch(googleFormsUrl);
    } else {
      throw 'Não foi possível abrir o Google Forms';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Votação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Por favor, clique no botão abaixo para acessar a votação:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: launchGoogleForms,
              child: const Text('Acessar Votação'),
            ),
          ],
        ),
      ),
    );
  }
}
