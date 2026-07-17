import 'package:flutter/material.dart';

import '../config/entity_config.dart';
import '../routes/app_routes.dart';
import '../services/session_service.dart';
import 'add_screen.dart';
import 'home_screen.dart';
import 'summary_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  final _sessionService = SessionService();
  int _selectedIndex = 0;
  int _refreshRevision = 0;
  int? _userId;
  String? _username;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final userId = await _sessionService.getUserId();
    final username = await _sessionService.getUsername();

    if (!mounted) return;
    if (userId == null) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }

    setState(() {
      _userId = userId;
      _username = username;
      _isLoading = false;
    });
  }

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

  Future<void> _logout() async {
    await _sessionService.clearSession();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  void _notifyDataChanged() {
    setState(() => _refreshRevision++);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _userId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final titles = ['Home - List', 'Summary'];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(
            userId: _userId!,
            username: _username,
            refreshRevision: _refreshRevision,
            onDataChanged: _notifyDataChanged,
          ),
          SummaryScreen(
            userId: _userId!,
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
