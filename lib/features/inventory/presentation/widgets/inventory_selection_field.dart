import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

class InventorySelectionField<T> extends StatelessWidget {
  final String label;
  final String selectedName;
  final IconData icon;
  final List<T> items;
  final int? selectedId;
  final String Function(T) itemName;
  final int Function(T) itemId;
  final void Function(int) onSelected;

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

  void _showSelectionSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.4,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
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
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
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
                      child: items.isEmpty
                          ? Center(
                              child: Text(l10n.invList_noItemsFilterMessage),
                            )
                          : ListView.builder(
                              controller: scrollController,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                final id = itemId(item);
                                final name = itemName(item);
                                final isSelected = selectedId == id;

                                return ListTile(
                                  leading: Icon(
                                    icon,
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                        : null,
                                  ),
                                  title: Text(
                                    name,
                                    style: TextStyle(
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : null,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : null,
                                    ),
                                  ),
                                  trailing: isSelected
                                      ? Icon(
                                          Icons.check,
                                          color: theme.colorScheme.primary,
                                        )
                                      : null,
                                  onTap: () {
                                    onSelected(id);
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
        },
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
                Icon(icon, color: Colors.grey[600], size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedName,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
