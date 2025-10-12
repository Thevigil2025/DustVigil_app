import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DustVigil Recycling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RecyclingPage(),
    );
  }
}

class RecyclingPage extends StatelessWidget {
  const RecyclingPage({super.key});

  Widget _buildCard({
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

  Widget _buildSuggestionTile(
      {required IconData icon, required String title, Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Recycling',
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
              // Dust Collected Card
              _buildCard(
                child: Row(
                  children: [
                    const Icon(Icons.line_weight, color: Colors.grey, size: 36),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        '2.3 kg collected this week',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Algae Growth Card
              _buildCard(
                child: Row(
                  children: [
                    const Icon(Icons.grass, color: Colors.green, size: 36),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Algae Status: Active',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Recycling Suggestions Section
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recycling Suggestions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSuggestionTile(
                      icon: Icons.account_balance,
                      title: 'Use dust + clay for bricks.',
                    ),
                    _buildSuggestionTile(
                      icon: Icons.science,
                      title: 'Harvest algae for biofuel.',
                    ),
                    _buildSuggestionTile(
                      icon: Icons.local_shipping,
                      title: 'Schedule recycler pickup.',
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
