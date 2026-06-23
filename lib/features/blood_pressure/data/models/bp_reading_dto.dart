class BpReadingDto {
  final String id;
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

  factory BpReadingDto.fromJson(Map<String, dynamic> json) => BpReadingDto(
        id: json['id'] as String,
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
