class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.recycling),
            title: const Text('Recycling'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecyclingPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.health_and_safety),
            title: const Text('Diagnostics'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DiagnosticsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.show_chart),
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
