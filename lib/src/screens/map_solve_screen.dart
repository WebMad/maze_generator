import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/map_solver/map_solver_cubit.dart';
import '../widgets/map_display_widget.dart';

enum SelectingMode {
  start,
  end,
  none,
}

class MapSolveScreen extends StatefulWidget {
  const MapSolveScreen({super.key});

  @override
  State<MapSolveScreen> createState() => _MapSolveScreenState();
}

class _MapSolveScreenState extends State<MapSolveScreen> {
  SelectingMode selectingMode = SelectingMode.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solve map'),
      ),
      body: BlocBuilder<MapSolverCubit, MapSolverState>(
        builder: (context, state) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<MapSolverCubit>().solve();
                },
                child: const Text('Решить'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: selectingMode != SelectingMode.start
                        ? () {
                            setState(() {
                              selectingMode = SelectingMode.start;
                            });
                          }
                        : null,
                    child: const Text('Начальная точка'),
                  ),
                  ElevatedButton(
                    onPressed: selectingMode != SelectingMode.end
                        ? () {
                            setState(() {
                              selectingMode = SelectingMode.end;
                            });
                          }
                        : null,
                    child: const Text('Конечная точка'),
                  ),
                ],
              ),
              Expanded(
                child: MapDisplayWidget(
                  map: state.solvedMap,
                  route: state.route,
                  finishingPoint: state.finishingPoint,
                  startingPoint: state.startingPoint,
                  onTap: (x, y) {
                    if (selectingMode == SelectingMode.start) {
                      context.read<MapSolverCubit>().selectStartingPoint(x, y);
                    } else if (selectingMode == SelectingMode.end) {
                      context.read<MapSolverCubit>().selectFinishingPoint(x, y);
                    }

                    selectingMode = SelectingMode.none;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
