// lib/features/blood_pressure/presentation/viewmodels/bp_list_vm.dart

import 'package:flutter/foundation.dart';

import '../../domain/models/bp_reading.dart';
import '../../domain/repositories/bp_repository.dart';

/// ViewModel for the "list" screen.
///
/// Responsibilities:
/// - Load readings from the repository
/// - Expose state for the UI
/// - Expose actions like refresh/delete
class BpListVm extends ChangeNotifier {
  final BpRepository repository;

  // UI state
  bool isLoading = false;
  String? errorMessage;
  List<BpReading> readings = [];

  BpListVm({required this.repository});

  /// Load readings into [readings].
  Future<void> load() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      readings = await repository.getReadings();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Delete a reading, then reload list.
  Future<void> deleteById(int id) async {
    // Find action can be optional; repository handles persistence.
    await repository.deleteReading(id);

    // Simple approach: reload everything.
    await load();
  }
}
