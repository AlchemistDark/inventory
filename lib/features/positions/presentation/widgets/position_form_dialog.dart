import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/positions/domain/entities/position_entity.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A dialog for creating or editing an employee position.
class PositionFormDialog extends StatefulWidget {
  /// Creates a [PositionFormDialog].
  const PositionFormDialog({
    required this.onSave,
    this.position,
    super.key,
  });

  /// The position to edit, or null if creating a new one.
  final PositionEntity? position;

  /// Callback called when the user saves the form.
  final void Function(String name) onSave;

  @override
  State<PositionFormDialog> createState() => _PositionFormDialogState();
}

class _PositionFormDialogState extends State<PositionFormDialog> {
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(widget.position == null
          ? l10n.positions_newTitle
          : l10n.positions_editTitle),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: l10n.positions_nameLabel),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.home_cancelButton),
        ),
        TextButton(
          onPressed: () {
            final text = _controller?.text;
            if (text != null && text.isNotEmpty) {
              widget.onSave(text);
              Navigator.pop(context);
            }
          },
          child: Text(l10n.home_saveButton),
        ),
      ],
    );
  }
}
