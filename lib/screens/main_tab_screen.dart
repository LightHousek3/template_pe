import 'package:flutter/material.dart';

import '../config/entity_config.dart';
import 'add_screen.dart';
import 'home_screen.dart';
import 'summary_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _selectedIndex = 0;
  int _refreshRevision = 0;

  Future<void> _openAdd() async {
    final added = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddScreen()),
    );

    if (added != true || !mounted) return;
    _notifyDataChanged();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Artwork added successfully')));
  }

  void _notifyDataChanged() {
    setState(() => _refreshRevision++);
  }

  @override
  Widget build(BuildContext context) {
    final titles = ['Home - List', 'Summary'];

    return Scaffold(
      appBar: AppBar(title: Text(titles[_selectedIndex])),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(
            refreshRevision: _refreshRevision,
            onDataChanged: _notifyDataChanged,
          ),
          SummaryScreen(
            refreshRevision: _refreshRevision,
            onDataChanged: _notifyDataChanged,
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: _openAdd,
              backgroundColor: const Color(0xFF64E3D5),
              foregroundColor: const Color(0xFF063E3A),
              icon: const Icon(Icons.add),
              label: Text('Add ${EntityConfig.entityName}'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}
