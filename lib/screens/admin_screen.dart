import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_data_and_surgery_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminScreen extends StatefulWidget {
  final String email;

  const AdminScreen({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _searchController = TextEditingController();
  final String twilioAccountSid = 'tu twilio id'; // Tu SID de Twilio
  final String twilioAuthToken =
      'tu twilio authtoken'; // Tu token de autenticación de Twilio
  final String twilioPhoneNumber =
      'tuTwiliophonenumber'; // Tu número de teléfono Twilio
  final String sendgridApiKey = 'your_sendgrid_api_key';

  Future<void> _sendEmail(
      String toEmail, String subject, String message) async {
    final response = await http.post(
      Uri.parse('https://api.sendgrid.com/v3/mail/send'),
      headers: {
        'Authorization': 'Bearer $sendgridApiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "personalizations": [
          {
            "to": [
              {"email": toEmail}
            ]
          }
        ],
        "from": {"email": "your_email@example.com"},
        "subject": subject,
        "content": [
          {"type": "text/plain", "value": message}
        ]
      }),
    );

    if (response.statusCode == 202) {
      if (kDebugMode) {
        print('Email sent successfully');
      }
    } else {
      if (kDebugMode) {
        print('Failed to send email: ${response.body}');
      }
    }
  }

  Future<void> _sendSms(String toNumber, String message) async {
    final response = await http.post(
      Uri.parse(
          'https://api.twilio.com/2010-04-01/Accounts/$twilioAccountSid/Messages.json'),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$twilioAccountSid:$twilioAuthToken'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'From': twilioPhoneNumber,
        'To': toNumber,
        'Body': message,
      },
    );

    if (response.statusCode == 201) {
      if (kDebugMode) {
        print('SMS sent successfully');
      }
    } else {
      if (kDebugMode) {
        print('Failed to send SMS: ${response.body}');
      }
    }
  }

  void _scheduleNotification(String fechaHoraCirugia, String notificationMethod,
      String contact) async {
    DateTime.parse(fechaHoraCirugia).subtract(const Duration(days: 2));
    const String message =
        'Señor usuario, se le informa que su cirugía ha sido programada. Por favor verifique la aplicación "Admi CPO"';

    if (notificationMethod == 'Email') {
      await _sendEmail(contact, 'Cirugía Programada', message);
    } else if (notificationMethod == 'Mensaje de texto') {
      await _sendSms(contact, message);
    }
  }

  void _updateSurgeryData(String userId, String fechaHoraCirugia,
      String notificationMethod, String contact) async {
    await FirebaseFirestore.instance
        .collection('surgeries')
        .doc(userId)
        .update({
      'fechaHoraCirugia': fechaHoraCirugia,
    });

    _scheduleNotification(fechaHoraCirugia, notificationMethod, contact);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content:
              Text('Datos de cirugía actualizados y notificación programada')),
    );
  }

  void _searchUser(BuildContext context) async {
    int cedula = int.tryParse(_searchController.text.trim()) ?? 0;

    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('patients')
        .where('cedula', isEqualTo: cedula)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      var userDoc = userSnapshot.docs.first;

      DocumentSnapshot surgerySnapshot = await FirebaseFirestore.instance
          .collection('surgeries')
          .doc(userDoc.id)
          .get();

      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => UserDataAndSurgeryScreen(
            userDoc: userDoc,
            surgeryDoc: surgerySnapshot,
            updateSurgeryData: _updateSurgeryData,
          ),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario no encontrado'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla de Administrador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Buscar usuario por documento:',
              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(labelText: 'Documento'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () => _searchUser(context),
                child: const Text('Buscar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
