import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/pages/inventory_list_page.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const HomeBottomNavigation({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _handleTap(context, index),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.inventory_2),
          label: AppStrings.home.inventoryButton,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.people),
          label: AppStrings.home.employeesButton,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.location_on),
          label: AppStrings.home.roomsButton,
        ),
      ],
    );
  }

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.home.employeesUnderDevelopment)),
      );
    } else if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.home.roomsUnderDevelopment)),
      );
    }
  }
}
