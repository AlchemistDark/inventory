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

  /// The room entity whose details are being displayed.
  final RoomEntity room;

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
    final roomsState = context.watch<RoomsBloc>().state;
    
    RoomEntity currentRoom = widget.room;
    if (roomsState is RoomsLoaded) {
      final found = roomsState.rooms.where((r) => r.id == widget.room.id).firstOrNull;
      if (found != null) {
        currentRoom = found;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(currentRoom.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => RoomFormPage(room: currentRoom),
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.rooms_inventoryTab, icon: const Icon(Icons.inventory_2)),
            Tab(text: l10n.rooms_employeesTab, icon: const Icon(Icons.people)),
          ],
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EmployeesBloc, EmployeesState>(
            listener: (context, state) {
              if (state is EmployeesLoaded) {
                context
                    .read<RoomDetailsBloc>()
                    .add(LoadRoomDetailsEvent(widget.room.id));
              }
            },
          ),
          BlocListener<InventoryBloc, InventoryState>(
            listener: (context, state) {
              if (state is InventoriesLoaded) {
                context
                    .read<RoomDetailsBloc>()
                    .add(LoadRoomDetailsEvent(widget.room.id));
              }
            },
          ),
        ],
        child: BlocBuilder<RoomDetailsBloc, RoomDetailsState>(
          builder: (context, state) {
            if (state is RoomDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RoomDetailsLoaded) {
              return TabBarView(
                controller: _tabController,
                children: [
                  RoomInventoryTab(
                    inventory: state.inventory,
                  ),
                  RoomEmployeesTab(
                    employees: state.employees,
                    positionMap: state.positionMap,
                  ),
                ],
              );
            } else if (state is RoomDetailsError) {
              return Center(
                child: Text(
                  l10n.common_error(state.failure.toLocalizedString(l10n)),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
