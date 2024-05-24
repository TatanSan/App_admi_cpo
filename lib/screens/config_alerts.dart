import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertSettingsScreen extends StatefulWidget {
  const AlertSettingsScreen({super.key});

  @override
  AlertSettingsScreenState createState() => AlertSettingsScreenState();
}

class AlertSettingsScreenState extends State<AlertSettingsScreen> {
  late SharedPreferences _preferences;
  bool _emailNotification = false;
  bool _textNotification = false;
  TimeOfDay _notificationTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _emailNotification = _preferences.getBool('emailNotification') ?? false;
      _textNotification = _preferences.getBool('textNotification') ?? false;
      final hour =
          _preferences.getInt('notificationHour') ?? TimeOfDay.now().hour;
      final minute =
          _preferences.getInt('notificationMinute') ?? TimeOfDay.now().minute;
      _notificationTime = TimeOfDay(hour: hour, minute: minute);
    });
  }

  Future<void> _savePreferences() async {
    await _preferences.setBool('emailNotification', _emailNotification);
    await _preferences.setBool('textNotification', _textNotification);
    await _preferences.setInt('notificationHour', _notificationTime.hour);
    await _preferences.setInt('notificationMinute', _notificationTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Alertas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notificaciones por correo electrónico',
              style: TextStyle(fontSize: 16.0),
            ),
            Switch(
              value: _emailNotification,
              onChanged: (value) {
                setState(() {
                  _emailNotification = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Notificaciones por mensaje de texto',
              style: TextStyle(fontSize: 16.0),
            ),
            Switch(
              value: _textNotification,
              onChanged: (value) {
                setState(() {
                  _textNotification = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Hora de la notificación',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: _notificationTime,
                );
                if (selectedTime != null) {
                  setState(() {
                    _notificationTime = selectedTime;
                  });
                }
              },
              child: Text(
                _notificationTime.format(context),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await _savePreferences();
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Preferencias guardadas')),
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
