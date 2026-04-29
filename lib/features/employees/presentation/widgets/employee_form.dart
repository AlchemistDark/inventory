import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A form for entering and editing employee details.
///
/// This widget handles the display of input fields for name, position, and room,
/// and communicates changes to the [EmployeeFormBloc].
class EmployeeForm extends StatelessWidget {
  /// Creates an [EmployeeForm].
  const EmployeeForm({
    required this.state,
    this.employee,
    super.key,
  });

  /// The current state of the employee form.
  final EmployeeFormMetadataLoaded state;

  /// The employee being edited, or null if creating a new one.
  final EmployeeEntity? employee;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            initialValue: employee?.name,
            decoration: InputDecoration(
              labelText: l10n.employees_nameLabel,
              errorText: switch (state.nameError) {
                EmployeeNameValidationError.tooShort =>
                  l10n.employees_minLength3,
                EmployeeNameValidationError.tooLong =>
                  l10n.employees_maxLength50,
                null => null,
              },
              prefixIcon: const Icon(Icons.person_outline),
            ),
            onChanged: (value) =>
                context.read<EmployeeFormBloc>().add(NameChanged(value)),
          ),
          const SizedBox(height: 20),
          InventorySelectionField(
            label: l10n.employees_positionLabel,
            selectedName: state.positions
                    .where((p) => p.id == state.selectedPositionId)
                    .firstOrNull
                    ?.name ??
                l10n.common_notSelected,
            icon: Icons.work_outline,
            items: state.positions,
            selectedId: state.selectedPositionId,
            itemName: (p) => p.name,
            itemId: (p) => p.id,
            onSelected: (id) =>
                context.read<EmployeeFormBloc>().add(PositionChanged(id)),
          ),
          const SizedBox(height: 20),
          InventorySelectionField(
            label: l10n.employees_roomLabel,
            selectedName: state.rooms
                    .where((r) => r.id == state.selectedRoomId)
                    .firstOrNull
                    ?.name ??
                l10n.common_notDefined,
            icon: Icons.room_outlined,
            items: state.rooms,
            selectedId: state.selectedRoomId,
            itemName: (r) => r.name,
            itemId: (r) => r.id,
            onSelected: (id) =>
                context.read<EmployeeFormBloc>().add(RoomChanged(id)),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () =>
                context.read<EmployeeFormBloc>().add(SubmitEmployeeForm()),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              employee == null ? l10n.common_create : l10n.common_save,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
