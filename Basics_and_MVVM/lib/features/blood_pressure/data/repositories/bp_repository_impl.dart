// lib/features/blood_pressure/data/repositories/bp_repository_impl.dart

import '../../domain/models/bp_reading.dart';
import '../../domain/repositories/bp_repository.dart';

import '../datasources/local/bp_local.dart';
import '../mappers/bp_mapper.dart';
import '../models/bp_reading_dto.dart';

/// Data-layer repository implementation that uses JSON file storage
/// via [BpLocalDataSource], while exposing the [BpRepository] contract.
class BpRepositoryImpl implements BpRepository {
  final BpLocalDataSource localDataSource;

  BpRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<List<BpReading>> getReadings() async {
    // Load DTOs from local storage
    final List<BpReadingDto> dtos = await localDataSource.loadReadings();

    // Convert DTOs -> Domain objects
    return dtos.map(BpMapper.toDomain).toList();
  }

  @override
  Future<BpReading> addReading(BpReading reading) async {
    // Load current DTO list
    final List<BpReadingDto> current = await localDataSource.loadReadings();

    // Convert domain -> DTO and add
    current.add(BpMapper.toDto(reading));

    // Save updated list
    await localDataSource.saveReadings(current);

    // Return the same reading (common simple approach)
    return reading;
  }

  @override
  Future<void> updateReading(BpReading reading) async {
    // Load current DTO list
    final List<BpReadingDto> current = await localDataSource.loadReadings();

    // Convert updated domain -> DTO
    final updatedDto = BpMapper.toDto(reading);

    // Find existing item by id.
    // NOTE: This must compile with your actual id types.
    final index = current.indexWhere((r) => r.id == reading.id);

    if (index == -1) {
      // If not found, add it (simple behavior)
      current.add(updatedDto);
    } else {
      // Replace existing item
      current[index] = updatedDto;
    }

    // Save updated list
    await localDataSource.saveReadings(current);
  }

  @override
  Future<void> deleteReading(int id) async {
    // Load current DTO list
    final List<BpReadingDto> current = await localDataSource.loadReadings();

    // Filter out matching id.
    // IMPORTANT: r.id and id must be the same type for this to compile.
    final filtered = current.where((r) => r.id.toString() != id).toList();

    // Save updated list
    await localDataSource.saveReadings(filtered);
  }
}
