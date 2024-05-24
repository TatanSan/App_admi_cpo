import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_surgery_data.dart';

class UserDataAndSurgeryScreen extends StatelessWidget {
  final DocumentSnapshot userDoc;
  final DocumentSnapshot surgeryDoc;
  final Function(String, String, String, String) updateSurgeryData;

  const UserDataAndSurgeryScreen({
    required this.userDoc,
    required this.surgeryDoc,
    required this.updateSurgeryData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var userData = userDoc.data() as Map<String, dynamic>;
    var surgeryData = surgeryDoc.data() as Map<String, dynamic>? ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del Usuario y Cirugía'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Datos del Usuario',
              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            _buildDataRow('Nombre', userData['name'] ?? 'N/A'),
            _buildDataRow('Documento', userData['cedula'].toString()),
            _buildDataRow('Edad', userData['age'].toString()),
            _buildDataRow('Teléfono', userData['phone'] ?? 'N/A'),
            _buildDataRow('Dirección', userData['address'] ?? 'N/A'),
            _buildDataRow('Alergias', userData['allergies'] ?? 'N/A'),
            _buildDataRow('Religión', userData['religion'] ?? 'N/A'),
            _buildDataRow('Método de Notificación',
                userData['notificationMethod'] ?? 'N/A'),
            _buildDataRow('Contacto', userData['contact'] ?? 'N/A'),
            const SizedBox(height: 20.0),
            const Text(
              'Datos de la Cirugía',
              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            _buildDataRow('Nombre del Procedimiento',
                surgeryData['nombreProcedimiento'] ?? 'En trámite'),
            _buildDataRow('Cirujano Tratante',
                surgeryData['cirujanoTratante'] ?? 'En trámite'),
            _buildDataRow('Especialidad Tratante',
                surgeryData['especialidadTratante'] ?? 'En trámite'),
            _buildDataRow('Fecha y Hora de la Cirugía',
                surgeryData['fechaHoraCirugia'] ?? 'En trámite'),
            _buildDataRow('Solicitud de Sala',
                surgeryData['solicitudSala'] ?? 'En trámite'),
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditSurgeryDataScreen(
                            userDocId: userDoc.id,
                            surgeryData: surgeryData,
                          ),
                        ),
                      ).then((_) {
                        // Aquí puedes realizar cualquier acción después de que se cierre la pantalla de edición
                      });
                    },
                    child: const Text('Editar Datos de Cirugía'),
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      updateSurgeryData(
                        userDoc.id,
                        surgeryData['fechaHoraCirugia'],
                        userData['notificationMethod'],
                        userData['contact'],
                      );
                    },
                    child: const Text('Enviar Notificación'),
                  ),
                ],
              ),
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
