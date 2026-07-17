import 'package:flutter/material.dart';

import '../models/artwork.dart';
import '../services/app_service.dart';
import '../widgets/data_list.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({
    super.key,
    required this.userId,
    required this.refreshRevision,
    required this.onDataChanged,
  });

  final int userId;
  final int refreshRevision;
  final VoidCallback onDataChanged;

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  final _appService = AppService();
  List<Artwork> _list = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didUpdateWidget(covariant CompletedScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshRevision != widget.refreshRevision) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final dataList = await _appService.findByUser(
      widget.userId,
      completed: true,
    );

    if (!mounted) return;
    setState(() {
      _list = dataList;
      _isLoading = false;
    });
  }

  Future<void> _toggleCompleted(Artwork artwork) async {
    await _appService.toggleCompleted(artwork);
    await _loadData();
    widget.onDataChanged();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: DataList(
          list: _list,
          isLoading: _isLoading,
          emptyMessage: 'No completed artworks',
          onToggleCompleted: _toggleCompleted,
        ),
      ),
    );
  }
}
