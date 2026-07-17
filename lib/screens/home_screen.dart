import 'package:flutter/material.dart';

import '../config/entity_config.dart';
import '../models/artwork.dart';
import '../services/app_service.dart';
import '../widgets/data_list.dart';
import '../widgets/banner.dart';
import 'detail_screen.dart';

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
  String _selectedYearFilter = EntityConfig.yearFilterAll;

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
      yearFilter: _selectedYearFilter,
    );

    if (!mounted) return;
    setState(() {
      _list = dataList;
      _isLoading = false;
    });
  }

  Future<void> _openDetail(Artwork artwork) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(artwork: artwork)),
    );

    if (changed != true) return;
    await _loadData();
    widget.onDataChanged();
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
              selectedYearFilter: _selectedYearFilter,
              onSearchChanged: (_) => _loadData(),
              onCategoryChanged: (value) {
                setState(() => _selectedCategory = value);
                _loadData();
              },
              onYearFilterChanged: (value) {
                if (value == null) return;
                setState(() => _selectedYearFilter = value);
                _loadData();
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: DataList(
                list: _list,
                isLoading: _isLoading,
                emptyMessage: 'No artworks found',
                onOpenDetail: _openDetail,
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
    required this.selectedYearFilter,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.onYearFilterChanged,
  });

  final TextEditingController controller;
  final String? selectedCategory;
  final String selectedYearFilter;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onYearFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Search by title',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String?>(
                initialValue: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Icons.category_outlined),
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
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: selectedYearFilter,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  prefixIcon: Icon(Icons.filter_list),
                ),
                items: EntityConfig.yearFilters
                    .map(
                      (filter) =>
                          DropdownMenuItem(value: filter, child: Text(filter)),
                    )
                    .toList(),
                onChanged: onYearFilterChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
