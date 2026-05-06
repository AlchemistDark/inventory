import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// A generic selection field that opens a bottom sheet to pick an item from a list.
///
/// This widget is used for selecting employees, categories, or rooms in the form.
/// It displays the current selection and handles triggering the selection sheet.
class InventorySelectionField<T> extends StatelessWidget {
  /// Creates an [InventorySelectionField].
  const InventorySelectionField({
    required this.label,
    required this.selectedName,
    required this.icon,
    required this.items,
    required this.itemName,
    required this.itemId,
    required this.onSelected,
    this.selectedId,
    super.key,
  });

  /// The label text displayed above the field.
  final String label;

  /// The name of the currently selected item to display in the field.
  final String selectedName;

  /// Icon representing the type of data being selected.
  final IconData icon;

  /// The full list of items available for selection.
  final List<T> items;

  /// The ID of the currently selected item, if any.
  final int? selectedId;

  /// Function to extract a display name from an item of type [T].
  final String Function(T) itemName;

  /// Function to extract a unique ID from an item of type [T].
  final int Function(T) itemId;

  /// Callback triggered when an item is selected from the bottom sheet.
  final ValueChanged<int?> onSelected;

  /// Shows the selection bottom sheet with a list of items.
  void _showSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => InventorySelectionSheet<T>(
        label: label,
        items: items,
        itemName: itemName,
        itemId: itemId,
        onSelected: onSelected,
        icon: icon,
        selectedId: selectedId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    selectedName,
                    style: const TextStyle(fontSize: 16),
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
