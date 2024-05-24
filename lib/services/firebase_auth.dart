import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admi_cpo/screens/admin_screen.dart';
import 'package:admi_cpo/screens/user_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger _logger = Logger();

  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.i("Usuario autenticado: ${userCredential.user!.uid}");

      User? user = userCredential.user;
      if (user != null) {
        // ignore: use_build_context_synchronously
        await _checkUserRole(context, email);
      }
    } on FirebaseAuthException catch (e) {
      _logger.e("Error al autenticar: ${e.message}");
      rethrow;
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.i("Usuario registrado: ${userCredential.user!.uid}");
      // Add user document to Firestore with email as ID and default role 'user'
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(email)
          .set({'email': email, 'rol': 'user'});
    } on FirebaseAuthException catch (e) {
      _logger.e("Error al registrar usuario: ${e.message}");
      rethrow;
    }
  }

  Future<void> _checkUserRole(BuildContext context, String email) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('patients')
          .doc(email)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
        String role = data?['rol'] ??
            'user'; // Asigna 'user' por defecto si no hay campo 'rol'

        if (!context.mounted) {
          return; // Verifica si el contexto sigue siendo válido
        }

        if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminScreen(
                      email: '',
                    )),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen(email: email)),
          );
        }
      } else {
        _logger.w("No se encontró el documento del usuario con correo: $email");
      }
    } catch (e) {
      _logger.e("Error al verificar el rol del usuario: $e");
    }
  }
}
