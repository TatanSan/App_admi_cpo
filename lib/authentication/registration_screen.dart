import 'package:flutter/material.dart';
import 'package:admi_cpo/services/firebase_auth.dart'; // Importa tu AuthService
import 'package:logger/logger.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Logger _logger = Logger();

  RegistrationScreen({super.key, required AuthService authService});

  void _registerUser(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      await AuthService().registerWithEmailAndPassword(email, password);
      Navigator.pop(
          // ignore: use_build_context_synchronously
          context); // Cierra la pantalla actual y vuelve a la anterior
    } catch (e) {
      _logger.i('Error al registrar usuario: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al registrar usuario: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    BuildContext currentContext =
        context; // Capturar el BuildContext aquí de manera síncrona

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Fondo con imagen
            Image.asset(
              'assets/logo_y_nombre_cpo.png',
              fit: BoxFit.cover,
            ),
            TextField(
              controller: _emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo electrónico'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _registerUser(currentContext),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
