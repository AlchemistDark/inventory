import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';
import 'package:inventory_p_shalaev/features/features.dart';

/// Home screen for inventory management
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  int _selectedNavIndex = 0;

  void _submitBarcode(String barcode) {
    context.read<HomeBloc>().add(SearchInventoryByBarcodeEvent(barcode));
  }

  void _onSearchPressed() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<HomeBloc>().add(SearchInventoriesByNameEvent(query));
    }
  }

  /// Shows modal for barcode scanning/input
  void _showBarcodeDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          BarcodeScannerDialog(onBarcodeSubmitted: _submitBarcode),
    );
  }

  /// Shows dialog when inventory item is not found
  void _showNotFoundDialog(String query) {
    showDialog(
      context: context,
      builder: (context) => InventoryNotFoundDialog(
        query: query,
        onCreate: () {
          Navigator.pop(context); // Close dialog
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const CreateInventoryPage(),
              settings: RouteSettings(arguments: {'initialBarcode': query}),
            ),
          );
        },
      ),
    );
  }

  /// Shows inventory item details screen
  void _showInventoryDetails(InventoryEntity inventory) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => InventoryDetailsPage(inventory: inventory),
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const InitializeEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.home.appBarTitle),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppStrings.home.menuUnderDevelopment)),
              );
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeNotFound) {
              _showNotFoundDialog(state.query);
            } else if (state is HomeSearchSuccess) {
              _showInventoryDetails(state.inventory);
            } else if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${AppStrings.home.errorPrefix}${state.message}',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    HomeSearchForm(
                      searchController: _searchController,
                      onScanPressed: _showBarcodeDialog,
                      onSearchPressed: _onSearchPressed,
                    ),
                    const SizedBox(height: 24),
                    if (state is HomeSearchMultipleResults)
                      MultipleResultsList(
                        inventories: state.inventories,
                        onInventoryTap: _showInventoryDetails,
                      )
                    else if (state is HomeLoading)
                      const CircularProgressIndicator()
                    else if (state is HomeInitial)
                      const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavigation(
        currentIndex: _selectedNavIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
