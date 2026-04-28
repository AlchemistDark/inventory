import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Bottom navigation bar for the home screen.
///
/// Handles navigation between main feature areas: Inventory, Employees, and Rooms.
class HomeBottomNavigation extends StatelessWidget {
  /// Creates a [HomeBottomNavigation].
  const HomeBottomNavigation({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  /// Currently selected navigation index.
  final int currentIndex;

  /// Callback function triggered when a navigation item is tapped.
  final void Function(int) onTap;

  void _handleTap(BuildContext context, int index) {
    onTap(index);

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const InventoryListPage(),
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const EmployeesPage(),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => const Text('Не реализовано'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _handleTap(context, index),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.inventory_2),
          label: l10n.home_inventoryButton,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.people),
          label: l10n.home_employeesButton,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.location_on),
          label: l10n.home_roomsButton,
        ),
      ],
    );
  }
}
