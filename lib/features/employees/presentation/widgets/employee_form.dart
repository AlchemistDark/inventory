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
    required this.nameError,
    required this.positions,
    required this.selectedPositionIds,
    required this.rooms,
    required this.selectedRoomId,
    required this.employee,
    super.key,
  });

  /// The employee being edited, or null if creating a new one.
  final EmployeeEntity? employee;

  /// Validation error for the employee's name, if any.
  final EmployeeNameValidationError? nameError;

  /// List of all available positions to choose from.
  final List<PositionEntity> positions;

  /// IDs of the positions currently selected for the employee.
  final List<int> selectedPositionIds;

  /// List of all available rooms to choose from.
  final List<RoomEntity> rooms;

  /// ID of the room currently selected for the employee.
  final int? selectedRoomId;

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
            maxLength: 50,
            decoration: InputDecoration(
              labelText: l10n.employees_nameLabel,
              counterText: '',
              errorText: switch (nameError) {
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
          InventoryMultiSelectionField(
            label: l10n.employees_positionLabel,
            icon: Icons.work_outline,
            items: positions,
            selectedIds: selectedPositionIds,
            itemName: (p) => p.name,
            itemId: (p) => p.id,
            onChanged: (ids) =>
                context.read<EmployeeFormBloc>().add(PositionsChanged(ids)),
          ),
          const SizedBox(height: 20),
          InventorySelectionField(
            label: l10n.employees_roomLabel,
            selectedName: rooms.getNameById(
              selectedRoomId,
              fallback: l10n.common_notDefined,
            ),
            icon: Icons.room_outlined,
            items: rooms,
            selectedId: selectedRoomId,
            itemName: (r) => r.name,
            itemId: (r) => r.id,
            onSelected: (id) =>
                context.read<EmployeeFormBloc>().add(RoomChanged(id)),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () =>
                context.read<EmployeeFormBloc>().add(SubmitEmployeeForm()),
            child: Text(
              employee == null ? l10n.common_create : l10n.common_save,
            ),
          ),
        ],
      ),
    );
  }
}
