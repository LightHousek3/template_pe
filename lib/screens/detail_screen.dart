import 'package:flutter/material.dart';

import '../config/entity_config.dart';
import '../models/artwork.dart';
import '../services/app_service.dart';
import 'add_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.artwork});

  final Artwork artwork;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _appService = AppService();
  late Artwork _item;
  bool _hasChanged = false;

  @override
  void initState() {
    super.initState();
    _item = widget.artwork;
  }

  Future<void> _openEdit() async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => AddScreen(artwork: _item)),
    );

    if (updated != true || !mounted) return;
    setState(() => _hasChanged = true);
    Navigator.pop(context, true);
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete ${EntityConfig.entityName}'),
          content: const Text('Are you sure you want to delete this item?'),
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

    if (confirmed != true || _item.id == null) return;

    await _appService.delete(_item.id!);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Item deleted successfully')));
    Navigator.pop(context, true);
  }

  Future<void> _toggleFavorite() async {
    await _appService.toggleFavorite(_item);
    if (!mounted) return;
    setState(() {
      _item = _item.copyWith(favorite: !_item.favorite);
      _hasChanged = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _item.favorite ? 'Added to favorites' : 'Removed from favorites',
        ),
      ),
    );
  }

  Future<void> _toggleStatus() async {
    await _appService.toggleCompleted(_item);
    if (!mounted) return;
    setState(() {
      _item = _item.copyWith(completed: !_item.completed);
      _hasChanged = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Status updated successfully')),
    );
  }

  void _close() {
    Navigator.pop(context, _hasChanged);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _close();
          }
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${EntityConfig.entityName} Detail'),
          leading: IconButton(
            tooltip: 'Back',
            onPressed: _close,
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            _item.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Icon(
                          _item.favorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: _item.favorite ? Colors.redAccent : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _DetailRow(label: 'Artist:', value: _item.artist),
                    _DetailRow(label: 'Year:', value: _item.year),
                    _DetailRow(label: 'Category:', value: _item.category),
                    _DetailRow(
                      label: 'Status:',
                      value: _item.completed
                          ? EntityConfig.statusOnLabel
                          : EntityConfig.statusOffLabel,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _item.description,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _openEdit,
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Edit'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _toggleFavorite,
                          icon: Icon(
                            _item.favorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          label: Text(
                            _item.favorite
                                ? 'Remove favorite'
                                : 'Add to favorite',
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _toggleStatus,
                          icon: const Icon(Icons.swap_horiz),
                          label: const Text('Toggle status'),
                        ),
                        OutlinedButton.icon(
                          onPressed: _delete,
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
