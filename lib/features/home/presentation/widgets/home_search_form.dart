import 'package:flutter/material.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Form widget for searching inventory on the home screen.
///
/// Provides a barcode scanning button and a text field for name-based search.
class HomeSearchForm extends StatelessWidget {
  /// Creates a [HomeSearchForm].
  const HomeSearchForm({
    required this.searchController,
    required this.onScanPressed,
    required this.onSearchPressed,
    super.key,
  });

  /// Controller for the search text field.
  final TextEditingController searchController;

  /// Callback triggered when the barcode scan button is pressed.
  final VoidCallback onScanPressed;

  /// Callback triggered when the search button is pressed or form is submitted.
  final VoidCallback onSearchPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          l10n.home_searchTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onScanPressed,
          icon: const Icon(Icons.qr_code_2),
          label: Text(l10n.home_scanButton),
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
            labelText: l10n.home_searchFieldLabel,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            prefixIcon: const Icon(Icons.search),
          ),
          onSubmitted: (_) => onSearchPressed(),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: searchController,
          builder: (context, value, child) {
            final bool isNotEmpty = value.text.trim().isNotEmpty;

            return SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isNotEmpty ? onSearchPressed : null,
                icon: const Icon(Icons.search),
                label: Text(l10n.home_searchButton),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
