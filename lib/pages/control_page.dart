import 'package:flutter/material.dart';
import '../api_service.dart'; // Make sure this path is correct

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DustVigil Controls',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ControlsPage(),
    );
  }
}

class ControlsPage extends StatefulWidget {
  const ControlsPage({super.key});

  @override
  State<ControlsPage> createState() => _ControlsPageState();
}

class _ControlsPageState extends State<ControlsPage> {
  bool _isFanOn = true;
  bool _isMistingOn = false;
  bool _isEnergySaverOn = false;
  bool _loading = false;

  // ✅ Send command to backend
  Future<void> _sendCommand(String action) async {
    setState(() => _loading = true);

    final res = await ApiService.sendCommand('pod_1', action);

    setState(() => _loading = false);

    if (res['ok'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Command sent: $action')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed: ${res['error'] ?? 'Unknown error'}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Controls',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  _buildControlTile(
                    icon: Icons.wind_power,
                    title: 'Fan',
                    value: _isFanOn,
                    onChanged: (bool value) async {
                      setState(() => _isFanOn = value);
                      final action = value ? 'start_fan' : 'stop_fan';
                      await _sendCommand(action);
                    },
                  ),
                  _buildControlTile(
                    icon: Icons.water_drop,
                    title: 'Misting System',
                    value: _isMistingOn,
                    onChanged: (bool value) async {
                      setState(() => _isMistingOn = value);
                      final action = value ? 'start_misting' : 'stop_misting';
                      await _sendCommand(action);
                    },
                  ),
                  _buildControlTile(
                    icon: Icons.eco,
                    title: 'Energy Saver Mode',
                    value: _isEnergySaverOn,
                    onChanged: (bool value) async {
                      setState(() => _isEnergySaverOn = value);
                      final action = value
                          ? 'enable_energy_saver'
                          : 'disable_energy_saver';
                      await _sendCommand(action);
                    },
                  ),
                ],
              ),
            ),
          ),

          // ✅ Loader overlay when sending a command
          if (_loading)
            Container(
              color: Colors.black.withOpacity(0.2),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF6A1B9A),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControlTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700], size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Switch(
              value: value,
              onChanged: (bool newVal) async {
                 onChanged(newVal);
              },
              activeColor: const Color(0xFF6A1B9A),
            ),
          ],
        ),
      ),
    );
  }
}
