import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              _buildControlTile(
                icon: Icons.wind_power,
                title: 'Fan',
                value: _isFanOn,
                onChanged: (bool value) {
                  setState(() {
                    _isFanOn = value;
                  });
                },
              ),
              _buildControlTile(
                icon: Icons.water_drop,
                title: 'Misting System',
                value: _isMistingOn,
                onChanged: (bool value) {
                  setState(() {
                    _isMistingOn = value;
                  });
                },
              ),
              _buildControlTile(
                icon: Icons.eco,
                title: 'Energy Saver Mode',
                value: _isEnergySaverOn,
                onChanged: (bool value) {
                  setState(() {
                    _isEnergySaverOn = value;
                  });
                },
              ),
            ],
          ),
        ),
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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[700], size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF6A1B9A),
            ),
          ],
        ),
      ),
    );
  }
}
