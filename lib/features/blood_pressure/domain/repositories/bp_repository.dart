import '../models/bp_reading.dart';

abstract class BpRepository {
  Future<List<BpReading>> getReadings();
  Future<BpReading> addReading(BpReading reading);
  Future<void> updateReading(BpReading reading);
  Future<void> deleteReading(String id);
}
