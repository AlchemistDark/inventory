import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Page displaying detailed information about a room, including its inventory and employees.
///
/// Uses a [TabController] to switch between inventory and employee lists.
class RoomDetailsPage extends StatefulWidget {
  /// Creates a [RoomDetailsPage].
  const RoomDetailsPage({
    required this.room,
    super.key,
  });

  /// The room entity whose details are being displayed.
  final RoomEntity room;

  /// Helper method to create a route for this page with a scoped [RoomDetailsBloc].
  static Route<void> route({required RoomEntity room}) {
    return MaterialPageRoute<void>(
      builder: (context) => BlocProvider(
        create: (context) => ServiceLocator.getIt<RoomDetailsBloc>()
          ..add(LoadRoomDetailsEvent(room.id)),
        child: RoomDetailsPage(room: room),
      ),
    );
  }

  @override
  State<RoomDetailsPage> createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room.name),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.rooms_inventoryTab, icon: const Icon(Icons.inventory_2)),
            Tab(text: l10n.rooms_employeesTab, icon: const Icon(Icons.people)),
          ],
        ),
      ),
      body: BlocBuilder<RoomDetailsBloc, RoomDetailsState>(
        builder: (context, state) {
          if (state is RoomDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomDetailsLoaded) {
            return TabBarView(
              controller: _tabController,
              children: [
                RoomInventoryTab(
                  inventory: state.inventory,
                  employees: state.employees,
                  roomName: widget.room.name,
                ),
                RoomEmployeesTab(
                  employees: state.employees,
                  positions: state.positions,
                ),
              ],
            );
          }
 else if (state is RoomDetailsError) {
            return Center(
                child: Text(l10n.common_error(state.failure.toLocalizedString(l10n))));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
