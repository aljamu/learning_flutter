// lib/main.dart
import 'package:flutter/material.dart';
import 'app.dart';

import 'features/blood_pressure/data/datasources/local/bp_local_android.dart';
import 'features/blood_pressure/data/repositories/bp_repository_impl.dart';
import 'features/blood_pressure/presentation/viewmodels/bp_list_vm.dart';
import 'features/blood_pressure/presentation/viewmodels/bp_form_vm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final localDataSource = BpLocalDataSourceAndroid();
  final repository = BpRepositoryImpl(localDataSource: localDataSource);

  final bpListVm = BpListVm(repository: repository);
  final bpFormVm = BpFormVm(repository: repository);

  runApp(
    App(
      bpListVm: bpListVm,
      bpFormVm: bpFormVm,
    ),
  );
}
