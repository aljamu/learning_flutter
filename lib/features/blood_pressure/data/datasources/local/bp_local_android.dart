import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../../domain/models/bp_reading.dart';
import '../../mappers/bp_mapper.dart';
import '../../models/bp_reading_dto.dart';

import 'bp_local.dart';

class BpLocalAndroidDataSource implements BpLocalDataSource {
  static const _fileName = 'bp_readings.json';

  Future<File> _file() async {
    // Gets an app-writable directory on Android.
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  @override
  Future<List<BpReading>> loadReadings() async {
    final file = await _file();

    // If the file doesn’t exist yet, there are no readings.
    if (!await file.exists()) return [];

    final raw = await file.readAsString();

    // If file is empty, treat as no data.
    if (raw.trim().isEmpty) return [];

    // Decode JSON array -> DTO maps.
    final decoded = jsonDecode(raw) as List<dynamic>;

    // Convert DTO -> domain using your mapper.
    final readings = decoded
        .map((e) => BpReadingDto.fromJson(e as Map<String, dynamic>))
        .map(BpMapper.toDomain)
        .toList();

    return readings;
  }

  @override
  Future<void> saveReadings(List<BpReading> readings) async {
    final file = await _file();

    // Convert domain -> DTOs (storage shape).
    final dtos = readings.map(BpMapper.toDto).toList();

    // Convert DTOs -> JSON maps.
    final jsonList = dtos.map((d) => d.toJson()).toList();

    // Save full list as JSON array.
    await file.writeAsString(jsonEncode(jsonList));
  }
}
