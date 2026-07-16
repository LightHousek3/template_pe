import 'package:flutter/material.dart';

import '../models/artwork.dart';
import '../services/app_service.dart';
import '../widgets/artwork_list.dart';

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
  List<Artwork> _artworks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadArtworks();
  }

  @override
  void didUpdateWidget(covariant CompletedArtworkScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshRevision != widget.refreshRevision) {
      _loadArtworks();
    }
  }

  Future<void> _loadArtworks() async {
    setState(() => _isLoading = true);
    final dataList = await _appService.findByUser(
      widget.userId,
      completed: true,
    );

    if (!mounted) return;
    setState(() {
      _artworks = dataList;
      _isLoading = false;
    });
  }

  Future<void> _toggleCompleted(Artwork artwork) async {
    await _appService.toggleCompleted(artwork);
    await _loadArtworks();
    widget.onDataChanged();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: ArtworkList(
          artworks: _artworks,
          isLoading: _isLoading,
          emptyMessage: 'No completed artworks',
          onToggleCompleted: _toggleCompleted,
        ),
      ),
    );
  }
}
