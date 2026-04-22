import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/constants/home_strings.dart';
import 'package:inventory_p_shalaev/features/home/presentation/bloc/home_bloc.dart';
import 'package:inventory_p_shalaev/features/home/presentation/bloc/home_event.dart';
import 'package:inventory_p_shalaev/features/inventory/domain/entities/inventory_entity.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/pages/create_inventory_page.dart';
import 'package:inventory_p_shalaev/features/inventory/presentation/pages/inventory_list_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Home screen for inventory management
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  final _barcodeController = TextEditingController();
  final MobileScannerController _scannerController = MobileScannerController();
  int _selectedNavIndex = 0;
  bool _isScanHandled = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const InitializeEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _barcodeController.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  void _submitBarcodeSearch(String value, BuildContext modalContext) {
    final barcode = value.trim();
    if (barcode.isEmpty) return;

    context.read<HomeBloc>().add(SearchInventoryByBarcodeEvent(barcode));
    _barcodeController.clear();
    Navigator.pop(modalContext);
  }

  void _handleScanResult(BarcodeCapture capture, BuildContext modalContext) {
    if (_isScanHandled) return;
    if (capture.barcodes.isEmpty) return;
    final barcode = capture.barcodes.first.rawValue;
    if (barcode == null || barcode.trim().isEmpty) return;

    _isScanHandled = true;
    _submitBarcodeSearch(barcode, modalContext);
  }

  /// Shows modal for barcode scanning/input
  void _showBarcodeDialog() {
    _barcodeController.clear();
    _isScanHandled = false;

    showDialog(
      context: context,
      builder: (modalContext) => AlertDialog(
        title: Text(AppStrings.home.barcodeDialogTitle),
        content: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.home.barcodeDialogHint,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black12,
                ),
                clipBehavior: Clip.antiAlias,
                child: MobileScanner(
                  controller: _scannerController,
                  onDetect: (capture) => _handleScanResult(capture, modalContext),
                  errorBuilder: (context, error, child) {
                    final message =
                        error.errorCode == MobileScannerErrorCode.permissionDenied
                        ? AppStrings.home.scannerPermissionDeniedMessage
                        : AppStrings.home.scannerUnavailableMessage;
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _barcodeController,
                decoration: InputDecoration(
                  labelText: AppStrings.home.barcodeFieldLabel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.qr_code),
                ),
                autofocus: true,
                onSubmitted: (value) => _submitBarcodeSearch(value, modalContext),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(modalContext),
            child: Text(AppStrings.home.cancelButton),
          ),
          ElevatedButton(
            onPressed: () {
              _submitBarcodeSearch(_barcodeController.text, modalContext);
            },
            child: Text(AppStrings.home.saveButton),
          ),
        ],
      ),
    );
  }

  /// Shows dialog when inventory item is not found
  void _showNotFoundDialog(String query) {
    // If the query looks like an exact match for barcode, we pass it forward.
    // In emulator or manual text, we treat query as barcode for creation.
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.home.notFoundDialogTitle),
        content: Text(
          AppStrings.home.notFoundDialogContent.replaceAll('%s', query),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.home.cancelButton),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateInventoryPage(),
                  settings: RouteSettings(arguments: {'initialBarcode': query}),
                ),
              );
            },
            child: Text(AppStrings.home.createButton),
          ),
        ],
      ),
    );
  }

  /// Shows dialog to create new inventory item (deprecated, see above)
  void _showCreateInventoryDialog(String barcode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.home.createInventoryDialogTitle),
        content: Text(AppStrings.home.createInventoryDialogContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.home.cancelButton),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppStrings.home.creatingItemMessage.replaceAll(
                      '%s',
                      barcode,
                    ),
                  ),
                ),
              );
            },
            child: Text(AppStrings.home.createButton),
          ),
        ],
      ),
    );
  }

  /// Shows dialog with inventory item details
  void _showInventoryDetails(InventoryEntity inventory) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.home.itemDetailsTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow(AppStrings.home.nameLabel, inventory.name),
              _buildDetailRow(
                AppStrings.home.barcodeLabel,
                inventory.barcode ?? AppStrings.home.notSpecified,
              ),
              _buildDetailRow(
                AppStrings.home.inventoryNumberLabel,
                inventory.inventoryNumber ?? AppStrings.home.notSpecified,
              ),
              _buildDetailRow(
                AppStrings.home.quantityLabel,
                '${inventory.quantity}',
              ),
              if (inventory.description != null)
                _buildDetailRow(
                  AppStrings.home.descriptionLabel,
                  inventory.description!,
                ),
              _buildDetailRow(
                AppStrings.home.registrationDateLabel,
                inventory.dateAdded.toString().split(' ')[0],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.home.closeDialogButton),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppStrings.home.editUnderDevelopment)),
              );
            },
            child: Text(AppStrings.home.editButton),
          ),
        ],
      ),
    );
  }

  /// Builds a detail row with label and value
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _onNavTap(int index) {
    if (index == 0) {
      // Navigate to Inventory List
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InventoryListPage()),
      );
    } else if (index == 1) {
      // Employees
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.home.employeesUnderDevelopment)),
      );
    } else if (index == 2) {
      // Rooms
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.home.roomsUnderDevelopment)),
      );
    }
    
    setState(() {
      _selectedNavIndex = index;
    });
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
               // Only show not found if we searched for a specific barcode or query
               if (_barcodeController.text.isNotEmpty || _searchController.text.isNotEmpty) {
                 _showNotFoundDialog(state.query);
                 _barcodeController.clear();
               }
            } else if (state is HomeSearchSuccess) {
               // Immediately open detail view
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
                    // Title
                    Text(
                      AppStrings.home.searchTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Scan button
                    ElevatedButton.icon(
                      onPressed: _showBarcodeDialog,
                      icon: const Icon(Icons.qr_code_2),
                      label: Text(AppStrings.home.scanButton),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Search field
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: AppStrings.home.searchFieldLabel,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Search button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final query = _searchController.text.trim();
                          if (query.isNotEmpty) {
                            context.read<HomeBloc>().add(
                              SearchInventoriesByNameEvent(query),
                            );
                          }
                        },
                        icon: const Icon(Icons.search),
                        label: Text(AppStrings.home.searchButton),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Search results
                    if (state is HomeSearchMultipleResults)
                      _buildMultipleResults(state.inventories)
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedNavIndex,
        onTap: _onNavTap,
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
      ),
    );
  }

  /// Builds search result card
  Widget _buildSearchResult(InventoryEntity inventory) {
    return GestureDetector(
      onTap: () => _showInventoryDetails(inventory),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      inventory.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${AppStrings.home.quantityPrefix}${inventory.quantity}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (inventory.inventoryNumber != null) ...[
                const SizedBox(height: 4),
                Text(
                  '${AppStrings.home.inventoryNumberLabel} ${inventory.inventoryNumber}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Builds multiple search results list
  Widget _buildMultipleResults(List<InventoryEntity> inventories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.home.foundItemsTitle.replaceAll(
            '%d',
            inventories.length.toString(),
          ),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...inventories.map(
          (inventory) => GestureDetector(
            onTap: () => _showInventoryDetails(inventory),
            child: Card(
              child: ListTile(
                title: Text(inventory.name),
                subtitle: Text(
                  '${AppStrings.home.quantityPrefix}${inventory.quantity}',
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
