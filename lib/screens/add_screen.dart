import 'package:flutter/material.dart';

import '../config/entity_config.dart';
import '../models/artwork.dart';
import '../services/app_service.dart';
import '../services/session_service.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key, this.artwork});

  final Artwork? artwork;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  static const _categories = EntityConfig.categories;

  final _formKey = GlobalKey<FormState>();
  final _artworkService = AppService();
  final _sessionService = SessionService();
  final _titleController = TextEditingController();
  final _artistController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _category = _categories.first;
  bool _isLoading = false;
  bool get _isEditMode => widget.artwork != null;

  @override
  void initState() {
    super.initState();
    final artwork = widget.artwork;
    if (artwork == null) return;

    _titleController.text = artwork.title;
    _artistController.text = artwork.artist;
    _yearController.text = artwork.year;
    _descriptionController.text = artwork.description;
    _category = artwork.category;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _yearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final userId = await _sessionService.getUserId();
    if (userId == null) return;

    setState(() => _isLoading = true);

    final artwork = Artwork(
      id: widget.artwork?.id,
      title: _titleController.text.trim(),
      artist: _artistController.text.trim(),
      year: _yearController.text.trim(),
      category: _category,
      description: _descriptionController.text.trim(),
      createdBy: widget.artwork?.createdBy ?? userId,
      completed: widget.artwork?.completed ?? false,
      favorite: widget.artwork?.favorite ?? false,
    );

    if (_isEditMode) {
      await _artworkService.update(artwork);
    } else {
      await _artworkService.add(artwork);
    }

    if (!mounted) return;

    setState(() => _isLoading = false);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode
              ? 'Update ${EntityConfig.entityName}'
              : 'Add ${EntityConfig.entityName}',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 520),
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _isEditMode ? 'Update Artwork' : 'New Artwork',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        // DOI NHANH: Lab4 doi thanh Bill Name, Lab5 doi thanh Item Name.
                        labelText: 'Title',
                        prefixIcon: Icon(Icons.title),
                      ),
                      validator: _required,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _artistController,
                      decoration: const InputDecoration(
                        // DOI NHANH: Lab4/5 co the doi field nay thanh Amount/Price.
                        labelText: 'Artist',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: _required,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _yearController,
                      decoration: const InputDecoration(
                        // DOI NHANH: Lab4 doi thanh Due Date, Lab5 co the bo field nay.
                        labelText: 'Year',
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                      ),
                      keyboardType: TextInputType.number,
                      validator: _required,
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: _category,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        prefixIcon: Icon(Icons.category_outlined),
                      ),
                      items: _categories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) setState(() => _category = value);
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.notes_outlined),
                      ),
                      minLines: 4,
                      maxLines: 5,
                      validator: _required,
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _save,
                        child: Text(
                          _isLoading
                              ? 'Saving...'
                              : _isEditMode
                              ? 'Update Artwork'
                              : 'Save Artwork',
                        ),
                      ),
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

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
