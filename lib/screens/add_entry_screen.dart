import 'package:flutter/material.dart';
import '../services/diary_service.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final DiaryService _diaryService = DiaryService();

  void _saveEntry() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      _showError("Title and content cannot be empty");
      return;
    }

    await _diaryService.addEntry(
      _titleController.text.trim(),
      _contentController.text.trim(),
    );

    Navigator.pop(context); // Back to home
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Entry")),
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
            ElevatedButton(onPressed: _saveEntry, child: const Text("Save Entry"))
          ],
        ),
      ),
    );
  }
}
