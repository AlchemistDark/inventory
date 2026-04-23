import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/constants/app_strings.dart';
import 'package:inventory_p_shalaev/features/features.dart';

class InventoryDetailsPage extends StatefulWidget {
  final InventoryEntity inventory;

  const InventoryDetailsPage({
    super.key,
    required this.inventory,
  });

  @override
  State<InventoryDetailsPage> createState() => _InventoryDetailsPageState();
}

class _InventoryDetailsPageState extends State<InventoryDetailsPage> {
  String _employeeName = '';
  String _roomName = '';
  String _categoryName = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    final empSource = context.read<EmployeesLocalDataSourceImpl>();
    final roomSource = context.read<RoomsLocalDataSourceImpl>();
    final catSource = context.read<CategoriesLocalDataSourceImpl>();

    final employees = await empSource.getEmployees();
    final rooms = await roomSource.getRooms();
    final categories = await catSource.getCategories();

    if (mounted) {
      setState(() {
        _employeeName = employees
                .where((e) => e.id == widget.inventory.employeeId)
                .firstOrNull
                ?.name ??
            AppStrings.inventoryList.notSpecifiedMale;
        _roomName = rooms
                .where((r) => r.id == widget.inventory.roomId)
                .firstOrNull
                ?.name ??
            AppStrings.inventoryList.notSpecified;
        _categoryName = categories
                .where((c) => c.id == widget.inventory.categoryId)
                .firstOrNull
                ?.name ??
            AppStrings.inventoryList.notSpecifiedFemale;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.home.itemDetailsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateInventoryPage(editTarget: widget.inventory),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailSection(
                    AppStrings.inventoryList.detailNameLabel,
                    widget.inventory.name,
                    isTitle: true,
                  ),
                  const Divider(),
                  _buildDetailRow(
                    AppStrings.inventoryList.detailBarcodeLabel,
                    widget.inventory.barcode ?? AppStrings.inventoryList.notSpecifiedMale,
                    icon: Icons.qr_code,
                  ),
                  _buildDetailRow(
                    AppStrings.inventoryList.detailInventoryNumberLabel,
                    widget.inventory.inventoryNumber ?? AppStrings.inventoryList.notSpecifiedMale,
                    icon: Icons.tag,
                  ),
                  _buildDetailRow(
                    AppStrings.inventoryList.detailQuantityLabel,
                    '${widget.inventory.quantity}',
                    icon: Icons.inventory_2,
                  ),
                  _buildDetailRow(
                    AppStrings.inventoryList.detailRoomLabel,
                    _roomName,
                    icon: Icons.room,
                  ),
                  _buildDetailRow(
                    AppStrings.inventoryList.detailResponsibleLabel,
                    _employeeName,
                    icon: Icons.person,
                  ),
                  _buildDetailRow(
                    AppStrings.inventoryList.detailCategoryLabel,
                    _categoryName,
                    icon: Icons.category,
                  ),
                  _buildDetailRow(
                    AppStrings.inventoryList.detailDateLabel,
                    widget.inventory.dateAdded.toString().split(' ')[0],
                    icon: Icons.calendar_today,
                  ),
                  if (widget.inventory.description != null && widget.inventory.description!.isNotEmpty)
                    _buildDetailRow(
                      AppStrings.inventoryList.detailDescriptionLabel,
                      widget.inventory.description!,
                      icon: Icons.description,
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailSection(String label, String value, {bool isTitle = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: isTitle ? 20 : 16,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: Colors.blue),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
