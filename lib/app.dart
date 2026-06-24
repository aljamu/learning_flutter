// lib/app.dart
import 'package:flutter/material.dart';
import 'package:learning_flutter/features/blood_pressure/domain/models/bp_reading.dart';
import 'features/blood_pressure/presentation/pages/bp_list_page.dart';
import 'features/blood_pressure/presentation/pages/bp_form_page.dart';
import 'features/blood_pressure/presentation/viewmodels/bp_list_vm.dart';
import 'features/blood_pressure/presentation/viewmodels/bp_form_vm.dart';

class App extends StatelessWidget {
  final BpListVm bpListVm;
  final BpFormVm bpFormVm;

  const App({
    super.key,
    required this.bpListVm,
    required this.bpFormVm,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => BpListPage(vm: bpListVm, formVm: bpFormVm),
        '/add': (context) => BpFormPage(vm: bpFormVm),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          final reading = settings.arguments as BpReading;
          return MaterialPageRoute(
            builder: (_) => BpFormPage(
              vm: bpFormVm,
              initialReading: reading,
            ),
          );
        }
        return null;
      },
    );
  }
}
