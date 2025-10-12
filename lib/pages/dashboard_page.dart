import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Widget _buildDashboardCard({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
  }) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Dashboard',
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Air Quality Card
              _buildDashboardCard(
                child: Row(
                  children: [
                    const Icon(Icons.air, color: Color(0xFF4CAF50), size: 36),
                    const SizedBox(width: 16),
                    const Text(
                      'Air Quality Index:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        '85 (Moderate)',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Environment Card
              _buildDashboardCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.thermostat,
                              color: Color(0xFFD32F2F), size: 36),
                          SizedBox(height: 8),
                          Text(
                            '25°C',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text('Temperature',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                      child: VerticalDivider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.opacity,
                              color: Color(0xFF1976D2), size: 36),
                          SizedBox(height: 8),
                          Text(
                            '55%',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text('Humidity', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Battery/Solar Card
              _buildDashboardCard(
                child: Row(
                  children: [
                    const Icon(Icons.battery_full,
                        color: Color(0xFF4CAF50), size: 36),
                    const SizedBox(width: 16),
                    const Text(
                      'Battery: 75%',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.wb_sunny,
                        color: Color(0xFFFFC107), size: 36),
                    const SizedBox(width: 8),
                    const Text(
                      'Solar: 120W',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Graph Placeholder
              _buildDashboardCard(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Icon(
                      Icons.bar_chart,
                      size: 60,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Pollution Reduction Over Time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
