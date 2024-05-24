import 'package:admi_cpo/screens/edit_user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admi_cpo/screens/user_screen.dart';

class UserDataScreen extends StatelessWidget {
  final String email;

  const UserDataScreen({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del Usuario'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('patients').doc(email).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar datos'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No se encontraron datos'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre: ${userData['name']}'),
                Text('Numero de Documento: ${userData['cedula']}'),
                Text('Edad: ${userData['age']}'),
                Text('Teléfono: ${userData['phone']}'),
                Text('Dirección: ${userData['address']}'),
                Text('Alergias: ${userData['allergies']}'),
                Text('Religión: ${userData['religion']}'),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditUserDataScreen(email: email),
                        ),
                      );
                    },
                    child: const Text('Modificar Datos'),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(email: email),
                        ),
                      );
                    },
                    child: const Text('Página Principal'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
