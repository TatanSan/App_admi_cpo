import 'package:admi_cpo/screens/user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class EditUserDataScreen extends StatelessWidget {
  final String email;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final Logger _logger = Logger();

  EditUserDataScreen({required this.email, super.key});

  void _updateData(BuildContext context) async {
    String name = _nameController.text.trim();
    int cedula = int.tryParse(_cedulaController.text.trim()) ?? 0;
    int age = int.tryParse(_ageController.text.trim()) ?? 0;
    String phone = _phoneController.text.trim();
    String address = _addressController.text.trim();
    String allergies = _allergiesController.text.trim();
    String religion = _religionController.text.trim();

    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(email)
          .update({
        'name': name,
        'cedula': cedula,
        'age': age,
        'phone': phone,
        'address': address,
        'allergies': allergies,
        'religion': religion,
      });

      _logger.i('Datos actualizados exitosamente en Firestore');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Datos actualizados exitosamente'),
          duration: Duration(seconds: 3),
        ),
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => UserDataScreen(email: email),
        ),
      );
    } catch (e) {
      _logger.e('Error al actualizar datos en Firestore: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al actualizar datos: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modificar Datos del Usuario'),
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
          if (snapshot.hasData && snapshot.data != null) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            _nameController.text = data['name'] ?? '';
            _cedulaController.text = (data['cedula'] ?? '').toString();
            _ageController.text = (data['age'] ?? '').toString();
            _phoneController.text = data['phone'] ?? '';
            _addressController.text = data['address'] ?? '';
            _allergiesController.text = data['allergies'] ?? '';
            _religionController.text = data['religion'] ?? '';

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Por favor, modifica tus datos:',
                      style: TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Por favor, modifica tu nombre:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Por favor, modifica tu numero de documento (solo numeros):',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _cedulaController,
                      decoration: const InputDecoration(labelText: 'Documento'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Por favor, modifica tu edad (solo numeros):',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _ageController,
                      decoration: const InputDecoration(labelText: 'Edad'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Por favor, modifica tu teléfono (sin guiones):',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Teléfono'),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Por favor, modifica tu dirección:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Dirección'),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Por favor, modifica el nombre de las alergias de lo contrario ingresa ("ninguna"):',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _allergiesController,
                      decoration: const InputDecoration(labelText: 'Alergias'),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Por favor, modifica la religión que profesas o eres creyente:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _religionController,
                      decoration: const InputDecoration(labelText: 'Religión'),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _updateData(context),
                        child: const Text('Actualizar Datos'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No se encontraron datos'));
          }
        },
      ),
    );
  }
}
