import '../../../domain/models/bp_reading.dart';

/// Local data source contract.
/// Knows how to read/write readings to the device storage.
/// Repository uses this and converts it into app/domain behavior.
abstract class BpLocalDataSource {
  Future<List<BpReading>> loadReadings();
  Future<void> saveReadings(List<BpReading> readings);
}
