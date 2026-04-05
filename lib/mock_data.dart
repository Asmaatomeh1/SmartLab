import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadMockTests() async {
  final tests = [
    {
      "id": "T001",
      "name": "Complete Blood Count (CBC)",
      "description":
          "Measures red and white blood cells, hemoglobin, and platelets.",
      "price": 50.0,
    },

    {
      "id": "T002",
      "name": "Blood Glucose Test",
      "description": "Measures the amount of glucose in the blood.",
      "price": 30.0,
    },

    {
      "id": "T003",
      "name": "Lipid Profile",
      "description":
          "Measures cholesterol levels including HDL, LDL, and triglycerides.",
      "price": 75.0,
    },

    {
      "id": "T004",
      "name": "Liver Function Test",
      "description": "Evaluates liver enzymes and overall liver health.",
      "price": 90.0,
    },

    {
      "id": "T005",
      "name": "Kidney Function Test",
      "description":
          "Checks kidney performance through creatinine and urea levels.",
      "price": 85.0,
    },

    {
      "id": "T006",
      "name": "Thyroid Function Test",
      "description": "Measures T3, T4, and TSH hormone levels.",
      "price": 95.0,
    },

    {
      "id": "T007",
      "name": "Vitamin D Test",
      "description": "Measures Vitamin D levels in the blood.",
      "price": 110.0,
    },

    {
      "id": "T008",
      "name": "Iron Test",
      "description": "Checks iron levels and detects anemia.",
      "price": 60.0,
    },

    {
      "id": "T009",
      "name": "Urine Analysis",
      "description": "Examines urine for infections and kidney disorders.",
      "price": 40.0,
    },

    {
      "id": "T010",
      "name": "COVID-19 PCR Test",
      "description": "Detects active COVID-19 infection.",
      "price": 120.0,
    },
  ];

  for (var test in tests) {
    await FirebaseFirestore.instance
        .collection("tests")
        .doc(test["id"] as String)
        .set(test);
  }
}
