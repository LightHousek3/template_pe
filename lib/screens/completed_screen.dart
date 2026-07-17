import 'package:flutter/material.dart';

import '../models/artwork.dart';
import '../services/app_service.dart';
import '../widgets/data_list.dart';

class CompletedArtworkScreen extends StatefulWidget {
  const CompletedArtworkScreen({
    super.key,
    required this.userId,
    required this.refreshRevision,
    required this.onDataChanged,
  });

  final int userId;
  final int refreshRevision;
  final VoidCallback onDataChanged;

  @override
  State<CompletedArtworkScreen> createState() => _CompletedArtworkScreenState();
}

class _CompletedArtworkScreenState extends State<CompletedArtworkScreen> {
  final _appService = AppService();
  List<Artwork> _list = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didUpdateWidget(covariant CompletedArtworkScreen oldWidget) {
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
