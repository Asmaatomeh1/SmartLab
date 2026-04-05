// import 'package:appwithfirebase/model/test_model.dart';
// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'test_state.dart';

// class TestCubit extends Cubit<TestState> {
//   TestCubit() : super(TestInitial());

//   List<TestModel> allTests = [];
//   List<TestModel> filteredTests = [];
//   List<TestModel> selectedTests = [];

//   /// تحميل الفحوصات من Firestore
//   Future<void> loadTests() async {
//     try {
//       emit(TestLoading());

//       var snapshot = await FirebaseFirestore.instance.collection("tests").get();

//       allTests = snapshot.docs
//           .map((doc) => TestModel.fromJson(doc.data()))
//           .toList();

//       filteredTests = allTests;

//       emitLoaded();
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }
//   }

//   /// البحث
//   void searchTests(String value) {
//     try {
//       filteredTests = allTests.where((test) {
//         return test.name.toLowerCase().contains(value.toLowerCase());
//       }).toList();

//       emitLoaded();
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }
//   }

//   /// اختيار
//   void toggleSelection(TestModel test) {
//     try {
//       if (selectedTests.contains(test)) {
//         selectedTests.remove(test);
//       } else {
//         selectedTests.add(test);
//       }
//     } catch (e) {
//       emit(TestError(e.toString()));
//     }

//     emitLoaded();
//   }

//   /// مجموع السعر
//   double get totalPrice {
//     double total = 0;

//     for (var test in selectedTests) {
//       total += test.price;
//     }

//     return total;
//   }

//   void emitLoaded() {
//     emit(
//       TestLoaded(
//         allTests: allTests,
//         filteredTests: filteredTests,
//         selectedTests: selectedTests,
//       ),
//     );
//   }
// }

import 'package:appwithfirebase/model/test_model.dart';
import 'package:appwithfirebase/test_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());

  // Private lists with proper types
  List<TestModel> _allTests = [];
  List<TestModel> _filteredTests = [];
  List<TestModel> _selectedTests = [];

  // Getters for read-only access
  List<TestModel> get allTests => List.unmodifiable(_allTests);
  List<TestModel> get filteredTests => List.unmodifiable(_filteredTests);
  List<TestModel> get selectedTests => List.unmodifiable(_selectedTests);

  /// Load tests from Firestore
  Future<void> loadTests() async {
    try {
      emit(TestLoading());

      final snapshot = await FirebaseFirestore.instance
          .collection("tests")
          .get();

      _allTests = snapshot.docs
          .map(
            (doc) => TestModel.fromJson({
              ...doc.data(),
              'id': doc.id, // Include document ID
            }),
          )
          .toList();

      _filteredTests = List.from(_allTests);
      _emitLoaded();
    } catch (e) {
      emit(TestError('Failed to load tests: ${e.toString()}'));
    }
  }

  /// Search tests
  void searchTests(String query) {
    if (query.isEmpty) {
      _filteredTests = List.from(_allTests);
    } else {
      final lowerQuery = query.toLowerCase().trim();
      _filteredTests = _allTests
          .where((test) => test.name.toLowerCase().contains(lowerQuery))
          .toList();
    }
    _emitLoaded();
  }

  /// Toggle test selection using ID comparison
  void toggleSelection(TestModel test) {
    final index = _selectedTests.indexWhere((item) => item.id == test.id);

    if (index != -1) {
      _selectedTests.removeAt(index);
    } else {
      _selectedTests.add(test);
    }

    _emitLoaded();
  }

  /// Check if test is selected
  bool isSelected(TestModel test) {
    return _selectedTests.any((item) => item.id == test.id);
  }

  /// Calculate total price
  double get totalPrice =>
      // ignore: avoid_types_as_parameter_names
      _selectedTests.fold<double>(0.0, (sum, test) => sum + (test.price));

  void _emitLoaded() {
    emit(
      TestLoaded(
        allTests: allTests,
        filteredTests: filteredTests,
        selectedTests: selectedTests,
      ),
    );
  }

  // void setInitialSelection(List<TestModel> tests) {
  //   // We clear the current selection and replace it with the tests
  //   // passed from the ResultsScreen
  //   _selectedTests = List.from(tests);

  //   // Refresh the filtered list to match all tests (optional but safer)
  //   _filteredTests = List.from(_allTests);

  //   // Emit the loaded state so the UI updates checkboxes and the Total Price
  //   _emitLoaded();
  // }
  void setInitialSelection(String appointmentId) {
    // Fetch the appointment details from Firestore
    FirebaseFirestore.instance
        .collection("appointments")
        .doc(appointmentId)
        .get()
        .then((doc) {
          if (doc.exists) {
            final data = doc.data()!;
            // Extract the necessary fields
            final selectedTests = (data['selectedTests'] as List)
                .map((item) => TestModel.fromJson(item))
                .toList();
            // final initialDate = (data['date'] as Timestamp).toDate();
            // final initialTime = TimeOfDay.fromDateTime(
            //   (data['time'] as Timestamp).toDate(),
            // );

            // Set the initial selection
            _selectedTests = List.from(selectedTests);
            _filteredTests = List.from(_allTests);

            // Emit the loaded state
            _emitLoaded();
          }
        });
  }

  //   // Emit the loaded state so the UI updates checkboxes and the Total Price
  //   _emitLoaded();
  // }

  /// Reset test selection
  // void resetSelection() {
  //   _selectedTests.clear();

  // }
}
