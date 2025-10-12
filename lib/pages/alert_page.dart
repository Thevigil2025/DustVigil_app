import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DustVigil Alerts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AlertsPage(),
    );
  }
}

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  // Mock data for the alerts. In a real app, this would come from a database.
  final List<Map<String, dynamic>> _alerts = const [
    {
      'type': 'warning',
      'title': 'High Dust Level Detected',
      'subtitle': '10:45 AM',
    },
    {
      'type': 'info',
      'title': 'Misting Tank Low',
      'subtitle': '09:30 AM',
    },
    {
      'type': 'warning',
      'title': 'Battery Low: 20%',
      'subtitle': 'Yesterday',
    },
    {
      'type': 'info',
      'title': 'System Check Complete',
      'subtitle': 'Yesterday',
    },
    {
      'type': 'warning',
      'title': 'Filter Needs Replacement',
      'subtitle': '2 days ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Alerts',
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
            children: _alerts.map((alert) {
              return Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Alert Icon
                      Icon(
                        alert['type'] == 'warning'
                            ? Icons.warning_rounded
                            : Icons.info_rounded,
                        color: alert['type'] == 'warning'
                            ? const Color(0xFFD32F2F)
                            : const Color(0xFF1976D2),
                        size: 30,
                      ),
                      const SizedBox(width: 16),
                      // Title and Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              alert['title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              alert['subtitle'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
