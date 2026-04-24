import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/app_localizations.dart';
import '../bloc/rooms_bloc.dart';
import '../bloc/rooms_state.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home_roomsButton),
      ),
      body: BlocBuilder<RoomsBloc, RoomsState>(
        builder: (context, state) {
          if (state is RoomsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomsLoaded) {
            if (state.rooms.isEmpty) {
              return const Center(child: Text('Список помещений пуст'));
            }

            return ListView.builder(
              itemCount: state.rooms.length,
              itemBuilder: (context, index) {
                final room = state.rooms[index];

                return ListTile(
                  title: Text(room.name),
                  subtitle: Text(room.description ?? ''),
                  leading: const Icon(Icons.room),
                );
              },
            );
          } else if (state is RoomsError) {
            return Center(child: Text('Ошибка: ${state.message}'));
          }

          return const Center(child: Text('Нажмите для загрузки'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Создание помещения в разработке')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
