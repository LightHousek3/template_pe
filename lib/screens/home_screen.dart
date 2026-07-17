import 'package:flutter/material.dart';

import '../config/entity_config.dart';
import '../models/artwork.dart';
import '../services/app_service.dart';
import '../widgets/data_list.dart';
import '../widgets/banner.dart';
import 'add_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.userId,
    required this.username,
    required this.refreshRevision,
    required this.onDataChanged,
  });

  final int userId;
  final String? username;
  final int refreshRevision;
  final VoidCallback onDataChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _appService = AppService();
  final _searchController = TextEditingController();
  List<Artwork> _list = [];
  bool _isLoading = true;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshRevision != widget.refreshRevision) {
      _loadData();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final dataList = await _appService.findByUser(
      widget.userId,
      searchText: _searchController.text,
      category: _selectedCategory,
    );

    if (!mounted) return;
    setState(() {
      _list = dataList;
      _isLoading = false;
    });
  }

  Future<void> _delete(Artwork artwork) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Artwork'),
          content: const Text('Are you sure you want to delete this artwork?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || artwork.id == null) return;

    await _appService.delete(artwork.id!);
    await _loadData();
    widget.onDataChanged();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Artwork deleted successfully')),
    );
  }

  Future<void> _toggleCompleted(Artwork artwork) async {
    await _appService.toggleCompleted(artwork);
    await _loadData();
    widget.onDataChanged();
  }

  Future<void> _edit(Artwork artwork) async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => AddScreen(artwork: artwork)),
    );

    if (updated != true) return;
    await _loadData();
    widget.onDataChanged();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Artwork updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Column(
          children: [
            AppBanner(username: widget.username),
            const SizedBox(height: 16),
            _SearchAndFilterBar(
              controller: _searchController,
              selectedCategory: _selectedCategory,
              onSearchChanged: (_) => _loadData(),
              onCategoryChanged: (value) {
                setState(() => _selectedCategory = value);
                _loadData();
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: DataList(
                list: _list,
                isLoading: _isLoading,
                emptyMessage: 'No artworks found',
                onToggleCompleted: _toggleCompleted,
                onEdit: _edit,
                onDelete: _delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchAndFilterBar extends StatelessWidget {
  const _SearchAndFilterBar({
    required this.controller,
    required this.selectedCategory,
    required this.onSearchChanged,
    required this.onCategoryChanged,
  });

  final TextEditingController controller;
  final String? selectedCategory;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Search by title or category',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String?>(
          initialValue: selectedCategory,
          decoration: const InputDecoration(
            labelText: 'Filter by category',
            prefixIcon: Icon(Icons.filter_list),
          ),
          items: [
            const DropdownMenuItem<String?>(
              value: null,
              child: Text('All categories'),
            ),
            ...EntityConfig.categories.map(
              (category) => DropdownMenuItem<String?>(
                value: category,
                child: Text(category),
              ),
            ),
          ],
          onChanged: onCategoryChanged,
        ),
      ],
    );
  }
}
