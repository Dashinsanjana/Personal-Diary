import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/diary_entry.dart';

class DiaryService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _userId => _auth.currentUser!.uid;

  Future<void> addEntry(String title, String content) async {
    await _firestore.collection('entries').add({
      'userId': _userId,
      'title': title,
      'content': content,
      'timestamp': DateTime.now(),
    });
  }
  // Add below existing methods
Future<void> updateEntry(String id, String title, String content) async {
  await _firestore.collection('entries').doc(id).update({
    'title': title,
    'content': content,
    'timestamp': DateTime.now(),
  });
}

Future<void> deleteEntry(String id) async {
  await _firestore.collection('entries').doc(id).delete();
}

  Stream<List<DiaryEntry>> getEntries() {
    return _firestore
        .collection('entries')
        .where('userId', isEqualTo: _userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DiaryEntry.fromMap(doc.id, doc.data()))
            .toList());
  }
}
