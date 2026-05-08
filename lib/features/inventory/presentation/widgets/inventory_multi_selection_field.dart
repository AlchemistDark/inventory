import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/widgets/inventory_multi_selection_sheet.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// A selection field that allows picking multiple items from a list.
///
/// Displays selected items as a comma-separated string or a placeholder if empty.
class InventoryMultiSelectionField<T> extends StatelessWidget {
  /// Creates an [InventoryMultiSelectionField].
  const InventoryMultiSelectionField({
    required this.label,
    required this.selectedIds,
    required this.icon,
    required this.items,
    required this.itemName,
    required this.itemId,
    required this.onChanged,
    super.key,
  });

  /// The label text displayed above the field.
  final String label;

  /// The IDs of the currently selected items.
  final List<int> selectedIds;

  /// Icon representing the type of data being selected.
  final IconData icon;

  /// The full list of items available for selection.
  final List<T> items;

  /// Function to extract a display name from an item of type [T].
  final String Function(T) itemName;

  /// Function to extract a unique ID from an item of type [T].
  final int Function(T) itemId;

  /// Callback triggered when the selection changes.
  final ValueChanged<List<int>> onChanged;

  void _showSelectionSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusValue),
        ),
        clipBehavior: Clip.antiAlias,
        child: InventoryMultiSelectionSheet<T>(
          label: label,
          items: items,
          itemName: itemName,
          itemId: itemId,
          initialSelectedIds: selectedIds,
          onChanged: onChanged,
          icon: icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    final selectedNames = items
        .where((item) => selectedIds.contains(itemId(item)))
        .map(itemName)
        .join(', ');

    final displayText = selectedNames.isEmpty 
        ? l10n.common_notSelected 
        : selectedNames;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _showSelectionSheet(context),
          borderRadius: AppTheme.borderRadius,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: AppTheme.fieldDecoration,
            child: Row(
              children: [
                Icon(icon, color: AppTheme.greyDarkColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    displayText,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: AppTheme.greyColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
