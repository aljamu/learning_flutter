//Converts between DTO and domain model
//import domain model
import '../../domain/models/bp_reading.dart'; 
//import DTO
import '../models/bp_reading_dto.dart';

class BpMapper {
  static BpReading toDomain(BpReadingDto dto) => BpReading(
        id: dto.id,
        systolic: dto.systolic,
        diastolic: dto.diastolic,
        pulse: dto.pulse,
        notes: dto.notes,
        measuredAt: DateTime.fromMillisecondsSinceEpoch(dto.measuredAtEpochMs),
      );

  static BpReadingDto toDto(BpReading domain) => BpReadingDto(
        id: domain.id,
        systolic: domain.systolic,
        diastolic: domain.diastolic,
        pulse: domain.pulse,
        notes: domain.notes,
        measuredAtEpochMs: domain.measuredAt.millisecondsSinceEpoch,
      );
}
