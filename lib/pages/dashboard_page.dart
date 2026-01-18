// lib/pages/dashboard_page.dart
import 'package:flutter/material.dart';
import '../api_service.dart'; // adjust if your api_service is in a different path

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic>? latestReading;
  bool loading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    _loadLatest();
  }

  Future<void> _loadLatest() async {
    setState(() {
      loading = true;
      error = '';
    });

    try {
      final res = await ApiService.getReadings();
      if (res['ok'] == true && res['data'] is List && (res['data'] as List).isNotEmpty) {
        setState(() {
          latestReading = (res['data'] as List).last as Map<String, dynamic>?;
        });
      } else {
        setState(() {
          latestReading = null;
        });
      }
    } catch (e) {
      setState(() {
        latestReading = null;
        error = 'Failed to load readings';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

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

  String _fmt(dynamic v) {
    if (v == null) return '-';
    return v.toString();
  }

  @override
  Widget build(BuildContext context) {
    // convenience variables from latestReading
    final pm25 = latestReading != null ? latestReading!['pm25'] : null;
    final pm10 = latestReading != null ? latestReading!['pm10'] : null;
    final co2 = latestReading != null ? latestReading!['co2'] : null;
    final temperature = latestReading != null ? latestReading!['temperature'] : null;
    final humidity = latestReading != null ? latestReading!['humidity'] : null;
    final battery = latestReading != null ? latestReading!['battery'] : null;
    final solar = latestReading != null ? latestReading!['solar'] : null; // optional

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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black87),
            onPressed: _loadLatest,
            tooltip: 'Refresh',
          )
        ],
      ),
      body: SafeArea(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : (error.isNotEmpty
                ? Center(child: Text(error))
                : SingleChildScrollView(
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
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  // show pm25 value here (or fallback)
                                  '${_fmt(pm25)} µg/m³',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Environment Card (Temperature & Humidity)
                        _buildDashboardCard(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.thermostat, color: Color(0xFFD32F2F), size: 36),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${_fmt(temperature)}°C',
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text('Temperature', style: TextStyle(color: Colors.grey)),
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
                                  children: [
                                    const Icon(Icons.opacity, color: Color(0xFF1976D2), size: 36),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${_fmt(humidity)}%',
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text('Humidity', style: TextStyle(color: Colors.grey)),
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
                              const Icon(Icons.battery_full, color: Color(0xFF4CAF50), size: 36),
                              const SizedBox(width: 16),
                              Text(
                                'Battery: ${_fmt(battery)}%',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              const Icon(Icons.wb_sunny, color: Color(0xFFFFC107), size: 36),
                              const SizedBox(width: 8),
                              Text(
                                'Solar: ${_fmt(solar)}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),

                        // Graph Placeholder
                        _buildDashboardCard(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
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
                  )),
      ),
    );
  }
}
