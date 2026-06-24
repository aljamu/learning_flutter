// lib/features/blood_pressure/presentation/viewmodels/bp_form_vm.dart

import 'package:flutter/foundation.dart';

import '../../domain/models/bp_reading.dart';
import '../../domain/repositories/bp_repository.dart';

/// ViewModel for the "add/edit form" screen.
///
/// Responsibilities:
/// - Hold current input values
/// - Create a BpReading domain object
/// - Call repository methods
class BpFormVm extends ChangeNotifier {
  final BpRepository repository;

  BpFormVm({required this.repository});

  // Form fields
  int? id; // null means "new reading"
  int systolic = 0;
  int diastolic = 0;
  int pulse = 0;
  String? notes;

  DateTime measuredAt = DateTime.now();

  // UI state
  bool isSaving = false;
  String? errorMessage;

  /// Initialize form for "new reading".
  void resetForNew() {
    id = null;
    systolic = 0;
    diastolic = 0;
    pulse = 0;
    notes = null;
    measuredAt = DateTime.now();

    errorMessage = null;
    isSaving = false;
    notifyListeners();
  }

  /// Initialize form for editing an existing reading.
  void loadFromDomain(BpReading reading) {
    id = reading.id;
    systolic = reading.systolic;
    diastolic = reading.diastolic;
    pulse = reading.pulse;
    notes = reading.notes;
    measuredAt = reading.measuredAt;

    errorMessage = null;
    isSaving = false;
    notifyListeners();
  }

  /// Save (add if id is null, otherwise update).
  Future<void> save() async {
    isSaving = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Build domain model
      final domain = BpReading(
        id: id ?? _generateId(),
        systolic: systolic,
        diastolic: diastolic,
        pulse: pulse,
        notes: notes,
        measuredAt: measuredAt,
      );

      // Add or update
      if (id == null) {
        await repository.addReading(domain);
      } else {
        await repository.updateReading(domain);
      }

      // Update internal id to what repository accepted (optional but nice)
      id = domain.id;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isSaving = false;
      notifyListeners();
    }
  }

  // Simple ID generator (keeps packages to minimum).
  // In real apps you might use a UUID package later.
  int _generateId() {
    return DateTime.now().microsecondsSinceEpoch.toInt();
  }
}
