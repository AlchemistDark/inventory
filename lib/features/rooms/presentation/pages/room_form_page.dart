import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page for creating or editing a room
class RoomFormPage extends StatefulWidget {
  /// Creates a [RoomFormPage]
  const RoomFormPage({this.room, super.key});

  /// The room to edit, or null if creating a new one
  final RoomEntity? room;

  @override
  State<RoomFormPage> createState() => _RoomFormPageState();
}

class _RoomFormPageState extends State<RoomFormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameController;
  TextEditingController? _descriptionController;

   @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.room?.name);
    _descriptionController =
        TextEditingController(text: widget.room?.description);
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final room = RoomEntity(
        id: widget.room?.id ?? 0,
        name: _nameController!.text,
        description: _descriptionController?.text,
        createdAt: widget.room?.createdAt ?? DateTime.now(),
      );

      if (widget.room == null) {
        context.read<RoomsBloc>().add(CreateRoomEvent(room));
      } else {
        context.read<RoomsBloc>().add(UpdateRoomEvent(room));
      }

      Navigator.pop(context);
    }
  }

   @override
  void dispose() {
    _nameController?.dispose();
    _descriptionController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.room != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.rooms_editTitle : l10n.rooms_newTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.rooms_nameLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.invForm_nameRequiredError;
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: l10n.rooms_descriptionLabel,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: Text(l10n.home_saveButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
