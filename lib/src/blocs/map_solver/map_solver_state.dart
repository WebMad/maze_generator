part of 'map_solver_cubit.dart';

@freezed
class MapSolverState with _$MapSolverState {
  const factory MapSolverState.initial({
    required List<List<int>> initialMap,
    required List<List<int>> solvedMap,
    required Set<String>? route,
    List<int>? startingPoint,
    List<int>? finishingPoint,
  }) = _Initial;
}
