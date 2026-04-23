import 'package:flutter/material.dart';

class InventorySelectionField<T> extends StatelessWidget {
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

  final String label;
  final String selectedName;
  final IconData icon;
  final List<T> items;
  final int? selectedId;
  final String Function(T) itemName;
  final int Function(T) itemId;
  final void Function(int) onSelected;

  void _showSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: items.map((item) {
          final id = itemId(item);
          final name = itemName(item);

          return ListTile(
            title: Text(name),
            selected: selectedId == id,
            onTap: () {
              onSelected(id);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showSelectionSheet(context),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedName),
                Icon(icon),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
