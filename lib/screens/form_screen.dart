import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:admi_cpo/screens/user_data_screen.dart';

class FormScreen extends StatefulWidget {
  final String email;

  const FormScreen({required this.email, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final Logger _logger = Logger();
  String _selectedNotificationMethod = 'Email';

  void _saveData(BuildContext context) async {
    String name = _nameController.text.trim();
    int cedula = int.tryParse(_cedulaController.text.trim()) ?? 0;
    int age = int.tryParse(_ageController.text.trim()) ?? 0;
    String phone = _phoneController.text.trim();
    String address = _addressController.text.trim();
    String allergies = _allergiesController.text.trim();
    String religion = _religionController.text.trim();
    String contact = _contactController.text.trim();
    String rol = 'user'; // Establecer el rol como 'user' por defecto

    try {
      await FirebaseFirestore.instance
          .collection('patients')
          .doc(widget.email)
          .set({
        'name': name,
        'cedula': cedula,
        'age': age,
        'phone': phone,
        'address': address,
        'allergies': allergies,
        'religion': religion,
        'email': widget.email,
        'rol': rol,
        'notificationMethod': _selectedNotificationMethod,
        'contact': contact,
      });

      _logger.i('Datos guardados exitosamente en Firestore');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Datos guardados exitosamente'),
          duration: Duration(seconds: 3),
        ),
      );

      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => UserDataScreen(email: widget.email),
        ),
      );
    } catch (e) {
      _logger.e('Error al guardar datos en Firestore: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar datos: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Por favor, ingresa tus datos:',
              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Por favor, ingresa tu nombre:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Por favor, ingresa tu numero de documento (solo numeros):',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _cedulaController,
              decoration: const InputDecoration(labelText: 'Documento'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Por favor, ingresa tu edad (solo numeros):',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Edad'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Por favor, ingresa tu teléfono (sin guiones):',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Por favor, ingresa tu dirección:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Dirección'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Por favor, ingresa el nombre de las alergias de lo contrario ingresa ("ninguna"):',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _allergiesController,
              decoration: const InputDecoration(labelText: 'Alergias'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Por favor, ingresa la religión que profesas o eres creyente:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _religionController,
              decoration: const InputDecoration(labelText: 'Religión'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Por favor, selecciona cómo deseas ser notificado:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedNotificationMethod,
              items: <String>['Email', 'Mensaje de texto'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedNotificationMethod = newValue!;
                });
              },
            ),
            const SizedBox(height: 20.0),
            Text(
              'Por favor, ingresa tu ${_selectedNotificationMethod == 'Email' ? 'correo electrónico' : 'número de teléfono'}:',
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: _selectedNotificationMethod == 'Email'
                    ? 'Correo electrónico'
                    : 'Número de teléfono',
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () => _saveData(context),
                child: const Text('Guardar Datos'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
