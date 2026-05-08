import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/widgets/inventory_selection_list.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A bottom sheet that allows multiple selection of items.
class InventoryMultiSelectionSheet<T> extends StatefulWidget {
  const InventoryMultiSelectionSheet({
    required this.label,
    required this.items,
    required this.itemName,
    required this.itemId,
    required this.initialSelectedIds,
    required this.onChanged,
    required this.icon,
    super.key,
  });

  final String label;
  final List<T> items;
  final String Function(T) itemName;
  final int Function(T) itemId;
  final List<int> initialSelectedIds;
  final ValueChanged<List<int>> onChanged;
  final IconData icon;

  @override
  State<InventoryMultiSelectionSheet<T>> createState() =>
      _InventoryMultiSelectionSheetState<T>();
}

class _InventoryMultiSelectionSheetState<T> extends State<InventoryMultiSelectionSheet<T>> {
  List<int> _currentSelectedIds = [];

  @override
  void initState() {
    super.initState();
    _currentSelectedIds = List<int>.of(widget.initialSelectedIds);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.onChanged(_currentSelectedIds);
                  Navigator.pop(context);
                },
                child: Text(l10n.common_save),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: widget.items.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    l10n.common_noItems,
                    style: TextStyle(color: theme.hintColor),
                  ),
                )
              : InventorySelectionList<T>(
                  items: widget.items,
                  itemName: widget.itemName,
                  itemId: widget.itemId,
                  icon: widget.icon,
                  isSelected: (id) => _currentSelectedIds.contains(id),
                  onItemTap: (id, isSelected) {
                    setState(() {
                      if (isSelected) {
                        _currentSelectedIds.remove(id);
                      } else {
                        _currentSelectedIds.add(id);
                      }
                    });
                  },
                ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
