import '../../models/bp_reading_dto.dart';

/// BpLocalDataSource is an abstraction (an interface).
/// Your ViewModels/Repositories should call:
/// loadReadings() to get readings & saveReadings(...) to store them
/// …and they should not care how those methods are implemented.

abstract class BpLocalDataSource {
  /// Load all saved readings from local storage.
  Future<List<BpReadingDto>> loadReadings();

  /// Persist/Save the full list of readings to local storage.
  Future<void> saveReadings(List<BpReadingDto> readings);
}
