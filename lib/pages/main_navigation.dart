import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'alert_page.dart';
import 'control_page.dart';
import 'impact_page.dart';
import 'diagnostics_page.dart';
import 'recycling_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const AlertsPage(),
    const ControlsPage(),
    const MorePage(), // 👈 Added the working MorePage widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alerts"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Controls"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
        ],
      ),
    );
  }
}

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          ListTile(
            leading: const Icon(Icons.recycling, color: Colors.green),
            title: const Text('Recycling'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecyclingPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.medical_services, color: Colors.redAccent),
            title: const Text('Diagnostics'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DiagnosticsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.show_chart, color: Colors.orange),
            title: const Text('Impact'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ImpactPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
