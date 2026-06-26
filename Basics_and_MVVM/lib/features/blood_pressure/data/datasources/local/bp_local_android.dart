import 'dart:convert'; // jsonDecode/jsonEncode
import 'dart:io'; // File

import 'package:path_provider/path_provider.dart'; // getApplicationDocumentsDirectory

import '../../models/bp_reading_dto.dart';
import 'bp_local.dart';

/// Android implementation of the local data source.
/// Stores readings as a JSON file in the app documents directory.
class BpLocalDataSourceAndroid implements BpLocalDataSource {
  /// File name used inside the documents directory.
  static const _fileName = 'bp_readings.json';

  /// Returns the File object pointing to our JSON storage file.
  Future<File> _file() async {
    // Documents directory is app-private on Android.
    final dir = await getApplicationDocumentsDirectory();

    // Full path like: /data/user/0/<app>/files/bp_readings.json
    return File('${dir.path}/$_fileName');
  }

  @override
  Future<List<BpReadingDto>> loadReadings() async {
    final file = await _file();

    // If the file doesn't exist yet, treat it as "no saved readings".
    if (!await file.exists()) {
      return [];
    }

    // Read the entire file as a string.
    final raw = await file.readAsString();

    // If the file is empty, also treat it as "no saved readings".
    if (raw.trim().isEmpty) {
      return [];
    }

    // Decode JSON into a dynamic object.
    final decoded = jsonDecode(raw);

    // Expecting JSON structure: a List of objects.
    final list = (decoded as List).cast<dynamic>();

    // Convert each map into a DTO.
    return list
        .map((e) => BpReadingDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveReadings(List<BpReadingDto> readings) async {
    final file = await _file();

    // Convert each DTO to JSON maps.
    final jsonList = readings.map((r) => r.toJson()).toList();

    // Encode as a JSON string.
    final raw = jsonEncode(jsonList);

    // Write string to disk. flush: true ensures it is written promptly.
    await file.writeAsString(raw, flush: true);
  }
}
