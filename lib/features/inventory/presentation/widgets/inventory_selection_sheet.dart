import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A bottom sheet widget that displays a list of items for selection.
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
                padding: const EdgeInsets.all(16),
                child: Text(
                  label,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
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
                        // Toggle behavior: if already selected, deselect it (set to null)
                        onSelected(isSelected ? null : id);
                        Navigator.pop(context);
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
