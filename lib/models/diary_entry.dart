class DiaryEntry {
  final String id;
  final String title;
  final String content;
  final DateTime timestamp;

  DiaryEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  factory DiaryEntry.fromMap(String id, Map<String, dynamic> data) {
    return DiaryEntry(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap(String userId) {
    return {
      'userId': userId,
      'title': title,
      'content': content,
      'timestamp': timestamp,
    };
  }
}
