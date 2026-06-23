class BpReading {
  final String id;
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
