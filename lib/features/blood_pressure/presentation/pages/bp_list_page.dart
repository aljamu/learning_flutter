// lib/features/blood_pressure/presentation/pages/bp_list_page.dart
import 'package:flutter/material.dart';

import '../viewmodels/bp_form_vm.dart';
import '../viewmodels/bp_list_vm.dart';
import '../widgets/bp_reading_card.dart';

import '../../domain/models/bp_reading.dart';
import 'bp_form_page.dart';

class BpListPage extends StatefulWidget {
  final BpListVm vm;
  final BpFormVm formVm;

  const BpListPage({
    super.key,
    required this.vm,
    required this.formVm,
  });

  @override
  State<BpListPage> createState() => _BpListPageState();
}

class _BpListPageState extends State<BpListPage> {
  @override
  void initState() {
    super.initState();
    widget.vm.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: widget.vm.load,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          widget.formVm.resetForNew();
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BpFormPage(vm: widget.formVm),
            ),
          );
          widget.vm.load();
        },
        child: const Icon(Icons.add),
      ),
      body: AnimatedBuilder(
        animation: widget.vm,
        builder: (context, _) {
          if (widget.vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.vm.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Error: ${widget.vm.errorMessage}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: widget.vm.load,
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (widget.vm.readings.isEmpty) {
            return const Center(
              child: Text('No readings yet.\nTap + to add one.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
            itemCount: widget.vm.readings.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final reading = widget.vm.readings[index];
              return BpReadingCard(
                reading: reading,
                onEdit: () async {
                  widget.formVm.loadFromDomain(reading);

                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BpFormPage(
                        vm: widget.formVm,
                        initialReading: reading,
                      ),
                    ),
                  );

                  widget.vm.load();
                },
                onDelete: () async {
                  await widget.vm.deleteById(reading.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
