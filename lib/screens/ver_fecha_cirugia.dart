import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerFechaCirugiaScreen extends StatefulWidget {
  final String nombreProcedimiento;
  final String cirujanoTratante;
  final String especialidadTratante;
  final String fechaHoraCirugia;
  final String solicitudSala;
  final String email;

  const VerFechaCirugiaScreen({
    required this.nombreProcedimiento,
    required this.cirujanoTratante,
    required this.especialidadTratante,
    required this.fechaHoraCirugia,
    required this.solicitudSala,
    required this.email,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VerFechaCirugiaScreenState createState() => _VerFechaCirugiaScreenState();
}

class _VerFechaCirugiaScreenState extends State<VerFechaCirugiaScreen> {
  String _selectedNotificationMethod = 'Email';
  final TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserContact();
  }

  void _loadUserContact() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('patients')
        .doc(widget.email)
        .get();
    if (userDoc.exists) {
      setState(() {
        _contactController.text = userDoc['contact'] ?? '';
        _selectedNotificationMethod = userDoc['notificationMethod'] ?? 'Email';
      });
    }
  }

  void _saveNotificationPreference() async {
    await FirebaseFirestore.instance
        .collection('patients')
        .doc(widget.email)
        .update({
      'notificationMethod': _selectedNotificationMethod,
      'contact': _contactController.text,
    });

    String message =
        'Se ha guardado las notificaciones, las cuales serán enviadas a ';
    if (_selectedNotificationMethod == 'Email') {
      message += '$_selectedNotificationMethod: ${_contactController.text}';
    } else {
      message += '$_selectedNotificationMethod: ${_contactController.text}';
    }

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );

    // Mostrar el mensaje emergente durante 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver Fecha de Cirugía Programada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              widget.nombreProcedimiento != 'En trámite'
                  ? 'Su cirugía está programada para el dia: ${widget.fechaHoraCirugia}'
                  : 'Señor usuario, su cirugía aún no se encuentra programada. Se le notificará cuando tenga una fecha asignada al correo electrónico que registró o al número de teléfono.',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            if (widget.nombreProcedimiento != 'En trámite') ...[
              _buildDataRow(
                  'Nombre del Procedimiento', widget.nombreProcedimiento),
              _buildDataRow('Cirujano Tratante', widget.cirujanoTratante),
              _buildDataRow(
                  'Especialidad Tratante', widget.especialidadTratante),
              _buildDataRow('Solicitud de Sala', widget.solicitudSala),
            ],
            const SizedBox(height: 20.0),
            const Text(
              'Señor usuario, seleccione si desea ser notificado por Email o número de teléfono y posteriormente ingrese los datos en el siguiente campo, a continuación dele click al botón "Guardar preferencias de notificación" para seleccionar el modo en que se le notificará la fecha de su cirugía.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
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
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: _selectedNotificationMethod == 'Email'
                    ? 'Correo electrónico'
                    : 'Número de teléfono',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _saveNotificationPreference();
              },
              child: const Text('Guardar preferencias de notificación'),
            ),
            const SizedBox(height: 10.0), // Separación adicional
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Página Principal'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
