import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/widgets/inventory_selection_tile.dart';
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
  State<InventoryMultiSelectionSheet<T>> createState() => _InventoryMultiSelectionSheetState<T>();
}

class _InventoryMultiSelectionSheetState<T> extends State<InventoryMultiSelectionSheet<T>> {
  late List<int> _currentSelectedIds;

  @override
  void initState() {
    super.initState();
    _currentSelectedIds = List<int>.from(widget.initialSelectedIds);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppTheme.borderRadiusValue * 2),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: AppTheme.grabHandleDecoration,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.label,
                      style: theme.textTheme.titleLarge,
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
              Expanded(
                child: widget.items.isEmpty
                    ? Center(
                        child: Text(l10n.invList_noItemsFilterMessage),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          final item = widget.items[index];
                          final id = widget.itemId(item);
                          final name = widget.itemName(item);
                          final isSelected = _currentSelectedIds.contains(id);

                          return InventorySelectionTile(
                            name: name,
                            isSelected: isSelected,
                            icon: widget.icon,
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _currentSelectedIds.remove(id);
                                } else {
                                  _currentSelectedIds.add(id);
                                }
                              });
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
