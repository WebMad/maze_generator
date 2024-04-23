import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maze_generator/src/blocs/maps_list/maps_list_cubit.dart';
import 'package:maze_generator/src/screens/map_solve_screen.dart';
import 'package:maze_generator/src/widgets/map_display_widget.dart';

import 'src/blocs/map_solver/map_solver_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Selector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => MapsListCubit(),
        child: const MapSelectionPage(),
      ),
    );
  }
}

class MapSelectionPage extends StatelessWidget {
  const MapSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Map'),
      ),
      body: BlocBuilder<MapsListCubit, MapsListState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => const SizedBox(),
            loaded: (maps) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<MapsListCubit>().load();
                  },
                  child: Text('Сгенерировать карты'),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) => MapSolverCubit(
                                    map: maps.maps[index],
                                  ),
                                  child: const MapSolveScreen(),
                                );
                              },
                            ),
                          );
                        },
                        child: Card(
                          child: GridTile(
                            footer: GridTileBar(
                              backgroundColor: Colors.black45,
                              title: Center(child: Text('Карта ${index + 1}')),
                            ),
                            child: MapDisplayWidget(
                              map: maps.maps[index],
                              route: null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MapWithIslandsWidget extends StatelessWidget {
  const MapWithIslandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Замените этот код реализацией вашего виджета карты
    return Container(
      color: Colors.grey,
      child: const Center(
        child: Icon(Icons.map, size: 72.0, color: Colors.white),
      ),
    );
  }
}
