import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/widgets/inventory_selection_tile.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A widget that displays a list of items for selection in a dialog.
///
/// This widget is used by [InventorySelectionField] to provide a consistent
/// interface for choosing entities like employees, rooms, or categories.
/// It supports highlighting the currently selected item and provides a
/// scrollable list.
class InventorySelectionSheet<T> extends StatelessWidget {
  /// Creates an [InventorySelectionSheet].
  const InventorySelectionSheet({
    required this.label,
    required this.items,
    required this.itemName,
    required this.itemId,
    required this.onSelected,
    required this.icon,
    this.selectedId,
    super.key,
  });

  /// The title displayed at the top of the sheet.
  final String label;

  /// The list of items to display.
  final List<T> items;

  /// Function to extract a display name from an item.
  final String Function(T) itemName;

  /// Function to extract a unique ID from an item.
  final int Function(T) itemId;

  /// Callback triggered when an item is selected.
  final ValueChanged<int?> onSelected;

  /// Icon to display next to each item.
  final IconData icon;

  /// The ID of the currently selected item, used for highlighting.
  final int? selectedId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Text(
            label,
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const Divider(height: 1),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: items.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    AppLocalizations.of(context)!.common_noItems,
                    style: TextStyle(color: theme.hintColor),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final id = itemId(item);
                    final name = itemName(item);
                    final isSelected = selectedId == id;

                    return InventorySelectionTile(
                      name: name,
                      isSelected: isSelected,
                      icon: icon,
                      onTap: () {
                        onSelected(isSelected ? null : id);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
