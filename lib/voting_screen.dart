import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({super.key});

  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _meetingController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _optionsController = TextEditingController();

  void sendEmails() async {
    // Configurações do servidor SMTP
    final smtpServer = SmtpServer('smtp.example.com',
        username: 'seu-email@example.com', password: 'sua-senha');

    // Configurações do e-mail
    final message = Message()
      ..from = const Address('seu-email@example.com')
      ..subject = 'Lembrete: Responda à enquete'
      ..text =
          'Caro destinatário,\n\nPor favor, lembre-se de responder à enquete.\n\nLink para a enquete: [INSIRA O LINK DO GOOGLE FORMS AQUI]'
      ..recipients.addAll([
        'email1@example.com',
        'email2@example.com',
        'email3@example.com',
      ]);

    try {
      final sendReport = await send(message, smtpServer);
      print(
          'E-mail enviado com sucesso! Resposta: ${sendReport.messageSendingEnd}');
    } catch (e) {
      print('Erro ao enviar e-mail: $e');
    }
  }

  void sendReminderEmails() {
    // Chame essa função diariamente para enviar lembretes por e-mail
    sendEmails();
  }

  void sendAuthorizationEmails() {
    // Chame essa função no dia anterior ao encerramento da enquete para enviar e-mails solicitando autorização
    sendEmails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Enquete'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: _meetingController,
              decoration: const InputDecoration(labelText: 'Reunião'),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _optionsController,
              decoration: const InputDecoration(labelText: 'Opções'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Criar a enquete no Google Forms usando as informações fornecidas
                // e obtenha o link do formulário
                String googleFormsLink = '[INSIRA O LINK DO GOOGLE FORMS AQUI]';

                // Enviar e-mails diários de lembrete
                sendReminderEmails();

                // Enviar e-mail de autorização no dia anterior ao encerramento da enquete
                sendAuthorizationEmails();
              },
              child: const Text('Criar Enquete'),
            ),
          ],
        ),
      ),
    );
  }
}
