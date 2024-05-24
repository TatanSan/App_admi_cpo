import 'package:flutter/material.dart';

class PagosCirugiaScreen extends StatelessWidget {
  const PagosCirugiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro de Pagos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido al Centro de Pagos',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para pagar por PSE
              },
              child: const Text('Pagar por PSE'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para pagar por Nequi
              },
              child: const Text('Pagar por Nequi'),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para pagar por Daviplata
              },
              child: const Text('Pagar por Daviplata'),
            ),
          ],
        ),
      ),
    );
  }
}
