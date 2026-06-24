// Define the meaning of a blood pressure reading for the UI
// The Ui does not need to know where the data comes from.

class BpReading {
  final int id;
  final int systolic;
  final int diastolic;
  final int pulse;
  final String? notes;
  final DateTime measuredAt;

  BpReading({
    required this.id,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    this.notes,
    required this.measuredAt,
  });
}
