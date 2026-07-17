import 'package:flutter/material.dart';

import '../config/entity_config.dart';
import '../models/artwork.dart';

class DataList extends StatelessWidget {
  const DataList({
    super.key,
    required this.list,
    required this.isLoading,
    required this.emptyMessage,
    required this.onOpenDetail,
  });

  final List<Artwork> list;
  final bool isLoading;
  final String emptyMessage;
  final ValueChanged<Artwork> onOpenDetail;

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
        final item = list[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ListTile(
            leading: Icon(
              item.favorite ? Icons.favorite : Icons.image_outlined,
              color: item.favorite ? Colors.redAccent : null,
            ),
            title: Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              // DOI NHANH: Lab4 hien category, amount, due_date, status.
              // Lab5 hien category, price, status.
              '${item.artist} - ${item.year} - ${item.category}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Chip(
              visualDensity: VisualDensity.compact,
              label: Text(
                item.completed
                    ? EntityConfig.statusOnLabel
                    : EntityConfig.statusOffLabel,
              ),
            ),
            onTap: () => onOpenDetail(item),
          ),
        );
      },
    );
  }
}
