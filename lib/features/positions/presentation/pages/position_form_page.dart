import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page for creating or editing an employee position.
class PositionFormPage extends StatefulWidget {

  /// Creates a [PositionFormPage].
  const PositionFormPage({this.position, super.key});

  /// Static method to get the route for this page.
  static Route<void> route({PositionEntity? position}) {
    return MaterialPageRoute<void>(
      builder: (_) => PositionFormPage(position: position),
    );
  }

  /// The position to edit, or null if creating a new one.
  final PositionEntity? position;

  @override
  State<PositionFormPage> createState() => _PositionFormPageState();
}

class _PositionFormPageState extends State<PositionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.position?.name ?? '';
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final position = PositionEntity(
        id: widget.position?.id ?? 0,
        name: _nameController.text.trim(),
        createdAt: widget.position?.createdAt ?? DateTime.now(),
      );

      if (widget.position == null) {
        context.read<PositionsBloc>().add(CreatePositionEvent(position));
      } else {
        context.read<PositionsBloc>().add(UpdatePositionEvent(position));
      }

      Navigator.pop(context);

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: Text(
            widget.position == null
                ? l10n.positions_created
                : l10n.positions_updated,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.position != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.positions_editTitle : l10n.positions_newTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.positions_nameLabel,
                ),
                autofocus: !isEditing,
                maxLength: 50,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.length < 3) {
                    return l10n.invForm_minLength3Error;
                  }

                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSave,
                  child: Text(
                    isEditing ? l10n.common_save : l10n.common_create,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
