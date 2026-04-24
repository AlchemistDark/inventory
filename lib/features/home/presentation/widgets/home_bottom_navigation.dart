import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
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
          builder: (context) => const RoomsPage(),
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
