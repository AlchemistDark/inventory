import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/positions/domain/entities/position_entity.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A dialog for creating or editing an employee position.
class PositionFormDialog extends StatefulWidget {
  /// Creates a [PositionFormDialog].
  const PositionFormDialog({required this.onSave, this.position, super.key});

  /// The position to edit, or null if creating a new one.
  final PositionEntity? position;

  /// Callback called when the user saves the form.
  final ValueChanged<String> onSave;

  @override
  State<PositionFormDialog> createState() => _PositionFormDialogState();
}

class _PositionFormDialogState extends State<PositionFormDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.position?.name);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSave(_controller!.text.trim());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = _controller;

    if (controller == null) {
      return const SizedBox.shrink();
    }

    return AlertDialog(
      title: Text(
        widget.position == null
            ? l10n.positions_newTitle
            : l10n.positions_editTitle,
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: l10n.positions_nameLabel,
            hintText: l10n.employees_nameLabel,
          ),
          autofocus: true,
          maxLength: 50,
          validator: (value) {
            final text = value?.trim() ?? '';
            if (text.length < 3) {
              return l10n.employees_minLength3;
            }

            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.home_cancelButton),
        ),
        TextButton(onPressed: _onSave, child: Text(l10n.home_saveButton)),
      ],
    );
  }
}
