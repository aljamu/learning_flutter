// lib/features/blood_pressure/presentation/pages/bp_form_page.dart
import 'package:flutter/material.dart';
import '../viewmodels/bp_form_vm.dart';
import '../../domain/models/bp_reading.dart';

class BpFormPage extends StatefulWidget {
  final BpFormVm vm;
  final BpReading? initialReading;

  const BpFormPage({
    super.key,
    required this.vm,
    this.initialReading,
  });

  @override
  State<BpFormPage> createState() => _BpFormPageState();
}

class _BpFormPageState extends State<BpFormPage> {
  final systolicCtrl = TextEditingController();
  final diastolicCtrl = TextEditingController();
  final pulseCtrl = TextEditingController();
  final notesCtrl = TextEditingController();

  void _syncControllersFromVm() {
    systolicCtrl.text = widget.vm.systolic.toString();
    diastolicCtrl.text = widget.vm.diastolic.toString();
    pulseCtrl.text = widget.vm.pulse.toString();
    notesCtrl.text = widget.vm.notes ?? '';
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialReading != null) {
      widget.vm.loadFromDomain(widget.initialReading!);
    }
    _syncControllersFromVm();

    // Listen once to keep controllers in sync if user navigated with prefilled VM
    widget.vm.addListener(() {
      // Only update when not focused to avoid fighting the user typing.
      if (!FocusScope.of(context).hasPrimaryFocus) return;
      _syncControllersFromVm();
    });
  }

  @override
  void dispose() {
    systolicCtrl.dispose();
    diastolicCtrl.dispose();
    pulseCtrl.dispose();
    notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Reading'),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: widget.vm,
          builder: (context, _) {
            final isEditing = widget.vm.id != null;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Text(
                    isEditing ? 'Edit reading' : 'New reading',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _NumberField(
                          label: 'Systolic (mmHg)',
                          controller: systolicCtrl,
                          onChanged: (v) => widget.vm.systolic = v,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _NumberField(
                          label: 'Diastolic (mmHg)',
                          controller: diastolicCtrl,
                          onChanged: (v) => widget.vm.diastolic = v,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _NumberField(
                    label: 'Pulse (bpm)',
                    controller: pulseCtrl,
                    onChanged: (v) => widget.vm.pulse = v,
                  ),
                  const SizedBox(height: 12),

                  _DatePickerField(
                    label: 'Measured at',
                    value: widget.vm.measuredAt,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: widget.vm.measuredAt,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked == null) return;

                      final timePicked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(widget.vm.measuredAt),
                      );
                      if (timePicked == null) return;

                      widget.vm.measuredAt = DateTime(
                        picked.year,
                        picked.month,
                        picked.day,
                        timePicked.hour,
                        timePicked.minute,
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: notesCtrl,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Notes (optional)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (s) => widget.vm.notes = s.isEmpty ? null : s,
                  ),
                  const SizedBox(height: 16),

                  if (widget.vm.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Error: ${widget.vm.errorMessage}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),

                  SizedBox(
                    height: 48,
                    child: FilledButton(
                      onPressed: widget.vm.isSaving
                          ? null
                          : () async {
                              // Update VM values from controllers (in case user never triggered onChanged)
                              widget.vm.systolic = int.tryParse(systolicCtrl.text) ?? 0;
                              widget.vm.diastolic = int.tryParse(diastolicCtrl.text) ?? 0;
                              widget.vm.pulse = int.tryParse(pulseCtrl.text) ?? 0;
                              widget.vm.notes = notesCtrl.text.isEmpty ? null : notesCtrl.text;

                              await widget.vm.save();
                              if (widget.vm.errorMessage == null && mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                      child: widget.vm.isSaving
                          ? const CircularProgressIndicator()
                          : Text(widget.vm.id == null ? 'Save' : 'Update'),
                    ),
                  ),

                  if (widget.vm.id != null) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 48,
                      child: OutlinedButton.icon(
                        onPressed: widget.vm.isSaving
                            ? null
                            : () async {
                                // simple: reuse delete from list vm? if you want delete here,
                                // you'd add a delete method to form vm. keeping minimal for now.
                                Navigator.of(context).pop();
                              },
                        icon: const Icon(Icons.check),
                        label: const Text('Done'),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<int> onChanged;

  const _NumberField({
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: (s) {
        final v = int.tryParse(s);
        onChanged(v ?? 0);
      },
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final String label;
  final DateTime value;
  final VoidCallback onTap;

  const _DatePickerField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Measured at',
          border: OutlineInputBorder(),
        ),
        child: Text(
          '${value.toLocal()}'.split('.').first,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
