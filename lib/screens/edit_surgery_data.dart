import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditSurgeryDataScreen extends StatefulWidget {
  final String userDocId;
  final Map<String, dynamic> surgeryData;

  const EditSurgeryDataScreen({
    required this.userDocId,
    required this.surgeryData,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditSurgeryDataScreenState createState() => _EditSurgeryDataScreenState();
}

class _EditSurgeryDataScreenState extends State<EditSurgeryDataScreen> {
  late TextEditingController _nombreProcedimientoController;
  late TextEditingController _cirujanoTratanteController;
  late TextEditingController _especialidadTratanteController;
  late TextEditingController _fechaHoraCirugiaController;
  late TextEditingController _solicitudSalaController;

  @override
  void initState() {
    super.initState();
    _nombreProcedimientoController =
        TextEditingController(text: widget.surgeryData['nombreProcedimiento']);
    _cirujanoTratanteController =
        TextEditingController(text: widget.surgeryData['cirujanoTratante']);
    _especialidadTratanteController =
        TextEditingController(text: widget.surgeryData['especialidadTratante']);
    _fechaHoraCirugiaController =
        TextEditingController(text: widget.surgeryData['fechaHoraCirugia']);
    _solicitudSalaController =
        TextEditingController(text: widget.surgeryData['solicitudSala']);
  }

  void _saveSurgeryData() {
    FirebaseFirestore.instance
        .collection('surgeries')
        .doc(widget.userDocId)
        .set({
      'nombreProcedimiento': _nombreProcedimientoController.text,
      'cirujanoTratante': _cirujanoTratanteController.text,
      'especialidadTratante': _especialidadTratanteController.text,
      'fechaHoraCirugia': _fechaHoraCirugiaController.text,
      'solicitudSala': _solicitudSalaController.text,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos de cirugía actualizados')),
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Datos de Cirugía'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(
                'Nombre del Procedimiento', _nombreProcedimientoController),
            _buildTextField('Cirujano Tratante', _cirujanoTratanteController),
            _buildTextField(
                'Especialidad Tratante', _especialidadTratanteController),
            _buildTextField(
                'Fecha y Hora de la Cirugía', _fechaHoraCirugiaController),
            _buildTextField('Solicitud de Sala', _solicitudSalaController),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: _saveSurgeryData,
                child: const Text('Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
