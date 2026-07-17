import 'package:flutter/material.dart';

import '../config/entity_config.dart';
import '../models/artwork.dart';
import '../models/data_summary.dart';
import '../services/app_service.dart';
import '../widgets/data_list.dart';
import 'detail_screen.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({
    super.key,
    required this.refreshRevision,
    required this.onDataChanged,
  });

  final int refreshRevision;
  final VoidCallback onDataChanged;

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _appService = AppService();
  DataSummary? _summary;
  List<Artwork> _favoriteList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void didUpdateWidget(covariant SummaryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshRevision != widget.refreshRevision) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final summary = await _appService.getSummary(EntityConfig.defaultUserId);
    final favoriteList = await _appService.findByUser(
      EntityConfig.defaultUserId,
      favorite: true,
    );

    if (!mounted) return;
    setState(() {
      _summary = summary;
      _favoriteList = favoriteList;
      _isLoading = false;
    });
  }

  Future<void> _openDetail(Artwork item) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => DetailScreen(artwork: item)),
    );

    if (changed != true) return;
    await _loadData();
    widget.onDataChanged();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _summary == null) {
      return const SafeArea(child: Center(child: CircularProgressIndicator()));
    }

    final summary = _summary!;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Gallery Statistics',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _SummaryTile(
                  icon: Icons.collections_outlined,
                  label: 'Total',
                  value: summary.totalItems.toString(),
                ),
                _SummaryTile(
                  icon: Icons.favorite_outline,
                  label: 'Favorites',
                  value: summary.favoriteItems.toString(),
                ),
                _SummaryTile(
                  icon: Icons.check_circle_outline,
                  label: 'Status on',
                  value: summary.completedItems.toString(),
                ),
                _SummaryTile(
                  icon: Icons.category_outlined,
                  label: 'Categories',
                  value: summary.categoryCount.toString(),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              // DOI NHANH: Lab4 doi thanh "Unpaid Bills", Lab5 doi thanh "Wishlist Items".
              '${EntityConfig.favoriteLabel} ${EntityConfig.entityNamePlural}',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: DataList(
                list: _favoriteList,
                isLoading: false,
                emptyMessage: 'No favorite items',
                onOpenDetail: _openDetail,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 156,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
