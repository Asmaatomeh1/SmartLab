class SelectedTest {
  final String testId;
  final String testName;
  final double priceAtBooking;

  SelectedTest({
    required this.testId,
    required this.testName,
    required this.priceAtBooking,
  });

  Map<String, dynamic> toMap() => {
    'testId': testId,
    'testName': testName,
    'priceAtBooking': priceAtBooking,
  };

  factory SelectedTest.fromMap(Map<String, dynamic> map) => SelectedTest(
    testId: map['testId'] ?? '',
    testName: map['testName'] ?? '',
    priceAtBooking: (map['priceAtBooking'] ?? 0).toDouble(),
  );
}

// ─────────────────────────────────────────────────────────────────────────────

class AppointmentModel {
  final String appointmentId;
  final String patientId;
  final String date;
  final String time;
  final String status; // 'pending' | 'completed' | 'cancelled'
  //final List<SelectedTest> selectedTests;
  //final double totalPrice;
  //final DateTime createdAt;

  AppointmentModel({
    required this.appointmentId,
    required this.patientId,
    required this.date,
    required this.time,
    required this.status,
  });

  Map<String, dynamic> toMap() => {
    'appointmentId': appointmentId,
    'patientId': patientId,
    'date': date,
    'time': time,
    'status': status,
    // 'selectedTests': selectedTests.map((t) => t.toMap()).toList(),
    // 'totalPrice': totalPrice,
    // 'createdAt': createdAt.toIso8601String(),
  };

  factory AppointmentModel.fromMap(Map<String, dynamic> map) =>
      AppointmentModel(
        appointmentId: map['appointmentId'] ?? '',
        patientId: map['patientId'] ?? '',
        date: map['date'] ?? '',
        time: map['time'] ?? '',
        status: map['status'] ?? 'pending',
        // selectedTests: (map['selectedTests'] as List<dynamic>? ?? [])
        //     .map((t) => SelectedTest.fromMap(t as Map<String, dynamic>))
        //     .toList(),
        // totalPrice: (map['totalPrice'] ?? 0).toDouble(),
        // createdAt: map['createdAt'] is String
        //     ? DateTime.parse(map['createdAt'])
        //     : (map['createdAt'] as dynamic).toDate(),
      );

  AppointmentModel copyWith({String? status}) => AppointmentModel(
    appointmentId: appointmentId,
    patientId: patientId,
    date: date,
    time: time,
    status: status ?? this.status,
    // selectedTests: selectedTests,
    // totalPrice: totalPrice,
    // createdAt: createdAt,
  );
}
