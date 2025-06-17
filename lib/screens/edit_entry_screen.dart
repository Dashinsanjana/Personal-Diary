import 'package:flutter/material.dart';
import '../services/diary_service.dart';
import '../models/diary_entry.dart';

class EditEntryScreen extends StatefulWidget {
  final DiaryEntry entry;

  const EditEntryScreen({super.key, required this.entry});

  @override
  State<EditEntryScreen> createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final DiaryService _diaryService = DiaryService();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.entry.title;
    _contentController.text = widget.entry.content;
  }

  void _saveChanges() async {
    await _diaryService.updateEntry(
      widget.entry.id,
      _titleController.text.trim(),
      _contentController.text.trim(),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Entry")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: "Content"),
                maxLines: null,
                expands: true,
              ),
            ),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}
