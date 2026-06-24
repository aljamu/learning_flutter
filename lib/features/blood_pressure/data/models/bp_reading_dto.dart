//DTO that represents the data for the app

class BpReadingDto {
  final int id;
  final int systolic;
  final int diastolic;
  final int pulse;
  final String? notes;
  final int measuredAtEpochMs;

  BpReadingDto({
    required this.id,
    required this.systolic,
    required this.diastolic,
    required this.pulse,
    this.notes,
    required this.measuredAtEpochMs,
  });

// a special kind of constructor that returns an object, and it can run logic before creating it
// => replaces return
  factory BpReadingDto.fromJson(Map<String, dynamic> json) => BpReadingDto(
        id: json['id'] as int,
        systolic: json['systolic'] as int,
        diastolic: json['diastolic'] as int,
        pulse: json['pulse'] as int,
        notes: json['notes'] as String?,
        measuredAtEpochMs: json['measuredAtEpochMs'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'systolic': systolic,
        'diastolic': diastolic,
        'pulse': pulse,
        'notes': notes,
        'measuredAtEpochMs': measuredAtEpochMs,
      };
}
