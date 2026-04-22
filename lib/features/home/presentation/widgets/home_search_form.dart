import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';

class HomeSearchForm extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onScanPressed;
  final VoidCallback onSearchPressed;

  const HomeSearchForm({
    super.key,
    required this.searchController,
    required this.onScanPressed,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.home.searchTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onScanPressed,
          icon: const Icon(Icons.qr_code_2),
          label: Text(AppStrings.home.scanButton),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: AppStrings.home.searchFieldLabel,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: const Icon(Icons.search),
          ),
          onSubmitted: (_) => onSearchPressed(),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onSearchPressed,
            icon: const Icon(Icons.search),
            label: Text(AppStrings.home.searchButton),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
          ),
        ),
      ],
    );
  }
}
