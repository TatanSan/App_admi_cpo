import 'dart:async';
import 'package:admi_cpo/screens/pagos_cirugia.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admi_cpo/screens/form_screen.dart';
import 'package:admi_cpo/screens/indications_screen.dart';
import 'package:admi_cpo/screens/ver_fecha_cirugia.dart';

class MainScreen extends StatefulWidget {
  final String email;

  const MainScreen({required this.email, super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  // Variables para almacenar los datos de la cirugía
  String _nombreProcedimiento = 'En trámite';
  String _cirujanoTratante = 'En trámite';
  String _especialidadTratante = 'En trámite';
  String _fechaHoraCirugia = 'En trámite';
  String _solicitudSala = 'En trámite';

  @override
  void initState() {
    super.initState();
    _startTimer();
    // Obtener los datos de la cirugía cuando se carga la pantalla
    _fetchSurgeryData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Método para obtener los datos de la cirugía desde Firestore
  void _fetchSurgeryData() {
    FirebaseFirestore.instance
        .collection('surgeries')
        .doc(widget.email) // Usar el email como ID del documento
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        // Si existe el documento, actualizar los datos de la cirugía
        final surgeryData = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _nombreProcedimiento =
              surgeryData['nombreProcedimiento'] ?? 'En trámite';
          _cirujanoTratante = surgeryData['cirujanoTratante'] ?? 'En trámite';
          _especialidadTratante =
              surgeryData['especialidadTratante'] ?? 'En trámite';
          _fechaHoraCirugia = surgeryData['fechaHoraCirugia'] ?? 'En trámite';
          _solicitudSala = surgeryData['solicitudSala'] ?? 'En trámite';
        });
      }
    });
  }

  void _payForSurgery() {
    // Aquí iría la lógica para realizar el pago de la cirugía
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PagosCirugiaScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Señor usuario, si es la primera vez que ingresa, por favor ingrese sus datos dando click en el botón "Datos del Usuario". También podrá corregir o adicionar algún dato que sea necesario.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormScreen(email: widget.email)),
                );
              },
              child: const Text('Datos del Usuario'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Señor usuario, por favor lea las indicaciones y la programación de su cirugía dando click en el botón "Indicaciones de Cirugía".',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const IndicacionesScreen()),
                );
              },
              child: const Text('Indicaciones de Cirugía'),
            ),
            const SizedBox(
                height: 20.0), // Espacio adicional entre el texto y el botón
            const Text(
              'Señor usuario, para ver la fecha de su cirugía, por favor, haga click en el botón "Ver fecha de cirugía programada", allí podrá ver la programación de su cirugía.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerFechaCirugiaScreen(
                      nombreProcedimiento: _nombreProcedimiento,
                      cirujanoTratante: _cirujanoTratante,
                      especialidadTratante: _especialidadTratante,
                      fechaHoraCirugia: _fechaHoraCirugia,
                      solicitudSala: _solicitudSala,
                      email: '',
                    ),
                  ),
                );
              },
              child: const Text('Ver fecha de cirugía programada'),
            ),
            const SizedBox(height: 20.0),
            // Nuevo botón para pagar la cirugía
            const Text(
              'Señor usuario, si usted es beneficiario o pertenece al régimen subsidiado nivel II debe cancelar un copago, por favor seleccione el botón "Pagar" y siga las instrucciones para realizar su pago.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PagosCirugiaScreen(),
                  ),
                );
              },
              child: const Text('Pagar'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 650,
        child: PageView.builder(
          controller: _pageController,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              'assets/banner$index.jpg',
              fit: BoxFit.cover,
            );
          },
          onPageChanged: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
    );
  }
}
