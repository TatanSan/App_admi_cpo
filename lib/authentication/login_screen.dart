import 'package:flutter/material.dart';
import 'package:admi_cpo/services/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final AuthService authService =
      AuthService(); // Instancia del servicio AuthService

  LoginScreen({super.key, required AuthService authService});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Método para iniciar sesión
  void _login(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      await authService.signInWithEmailAndPassword(context, email, password);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo_y_nombre_cpo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            TextField(
              controller: _emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(
                  context), // Llama al método _login al presionar el botón
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
