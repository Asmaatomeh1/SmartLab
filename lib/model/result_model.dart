// class TestResultItem {
//   final String testId;
//   final String testName;
//   final String resultUrl; // Firebase Storage URL (PDF or image)

//   TestResultItem({
//     required this.testId,
//     required this.testName,
//     required this.resultUrl,
//   });

//   Map<String, dynamic> toMap() => {
//         'testId': testId,
//         'testName': testName,
//         'resultUrl': resultUrl,
//       };

//   factory TestResultItem.fromMap(Map<String, dynamic> map) => TestResultItem(
//         testId: map['testId'] ?? '',
//         testName: map['testName'] ?? '',
//         resultUrl: map['resultUrl'] ?? '',
//       );

//   TestResultItem copyWith({String? testId, String? testName, String? resultUrl}) =>
//       TestResultItem(
//         testId: testId ?? this.testId,
//         testName: testName ?? this.testName,
//         resultUrl: resultUrl ?? this.resultUrl,
//       );
// }

// ─────────────────────────────────────────────────────────────────────────────

class ResultModel {
  final String resultId; // Firestore doc id
  final String appointmentId; // links to appointments collection
  // final String patientId;      // for easy querying from patient side
  //final List<TestResultItem> results; // one entry per test
  final DateTime createdAt;
  //  final String status;         // 'ready' | 'pending'
  final String? notes;
  final String? resultUrl; // optional admin notes

  ResultModel({
    required this.resultId,
    required this.appointmentId,
    //    required this.patientId,
    //required this.results,
    required this.createdAt,
    // this.status = 'ready',
    this.notes,
    this.resultUrl,
  });

  Map<String, dynamic> toMap() => {
    'resultId': resultId,
    'appointmentId': appointmentId,
    // 'patientId': patientId,
    // 'results': results.map((r) => r.toMap()).toList(),
    'createdAt': createdAt.toIso8601String(),
    // 'status': status,
    'notes': notes,
    'resultUrl': resultUrl,
  };

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      resultId: map['resultId'] ?? '',
      appointmentId: map['appointmentId'] ?? '',
      // patientId: map['patientId'] ?? '',
      // results: (map['results'] as List<dynamic>? ?? [])
      //     .map((r) => TestResultItem.fromMap(r as Map<String, dynamic>))
      //     .toList(),
      createdAt: DateTime.parse(
        map['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      // status: map['status'] ?? 'ready',
      notes: map['notes'],
      resultUrl: map['resultUrl'],
    );
  }

  ResultModel copyWith({
    String? resultId,
    String? appointmentId,
    // String? patientId,
    // List<TestResultItem>? results,
    DateTime? createdAt,
    //  String? status,
    String? notes,
    String? resultUrl,
  }) => ResultModel(
    resultId: resultId ?? this.resultId,
    appointmentId: appointmentId ?? this.appointmentId,
    //  patientId: patientId ?? this.patientId,
    // results: results ?? this.results,
    createdAt: createdAt ?? this.createdAt,
    // status: status ?? this.status,
    notes: notes ?? this.notes,
    resultUrl: resultUrl ?? this.resultUrl,
  );

  @override
  String toString() =>
      'ResultModel{ resultId: $resultId, appointmentId: $appointmentId, '
      ' status: , results: items, notes: $notes, resultUrl: $resultUrl }';
}
