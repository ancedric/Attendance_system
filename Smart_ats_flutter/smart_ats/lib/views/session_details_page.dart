import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import '../storage/local_storage.dart';

class SessionDetailsPage extends StatelessWidget {
  final String sessionName;
  final String sessionRef;
  final String arrivalTime;

  const SessionDetailsPage({
    super.key,
    required this.sessionName,
    required this.sessionRef,
    required this.arrivalTime,
  });

  void _leaveSession(BuildContext context) async {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm:ss').format(now);
    final user = await LocalStorage.getUser();
    final userRef = user["userRef"] ?? "unknown";

    await ApiService.updateDeparture(
      userRef: userRef,
      sessionRef: sessionRef,
      departureTime: formattedTime,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Session quittée.")),
    );
    Navigator.pop(context); // Retour à l'accueil
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détails de la session")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Titre de la session : $sessionName", style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            Text("Heure d'arrivée : $arrivalTime", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _leaveSession(context),
              child: const Text("Quitter la session"),
            )
          ],
        ),
      ),
    );
  }
}
