import 'package:flutter/material.dart';

import '../models/artwork.dart';
import '../screens/detail_screen.dart';

class DataList extends StatelessWidget {
  const DataList({
    super.key,
    required this.list,
    required this.isLoading,
    required this.emptyMessage,
    required this.onToggleCompleted,
    this.onEdit,
    this.onDelete,
  });

  final List<Artwork> list;
  final bool isLoading;
  final String emptyMessage;
  final ValueChanged<Artwork> onToggleCompleted;
  final ValueChanged<Artwork>? onEdit;
  final ValueChanged<Artwork>? onDelete;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (list.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final artwork = list[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            leading: IconButton(
              tooltip: artwork.completed ? 'Mark incomplete' : 'Mark complete',
              onPressed: () => onToggleCompleted(artwork),
              icon: Icon(
                artwork.completed
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
              ),
            ),
            title: Text(
              artwork.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${artwork.category} - ${artwork.artist} - ${artwork.year}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Wrap(
              spacing: 4,
              children: [
                if (onEdit != null)
                  IconButton(
                    tooltip: 'Edit artwork',
                    onPressed: () => onEdit!(artwork),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                if (onDelete != null)
                  IconButton(
                    tooltip: 'Delete artwork',
                    onPressed: () => onDelete!(artwork),
                    icon: const Icon(Icons.delete_outline),
                  ),
              ],
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArtworkDetailScreen(artwork: artwork),
              ),
            ),
          ),
        );
      },
    );
  }
}
