import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_solver_state.dart';

part 'map_solver_cubit.freezed.dart';

class MapSolverCubit extends Cubit<MapSolverState> {
  MapSolverCubit({
    required List<List<int>> map,
  }) : super(
          MapSolverState.initial(
            initialMap: map,
            solvedMap: [...map].map((e) => [...e]).toList(),
            route: null,
          ),
        );

  void solve() {
    emit(
      state.copyWith(
        solvedMap: [...state.initialMap].map((e) => [...e]).toList(),
        route: null,
      ),
    );
    final map = state.solvedMap;

    final route = _iterate(
      startX: state.startingPoint?[0] ?? 0,
      startY: state.startingPoint?[1] ?? 0,
      x: state.startingPoint?[0] ?? 0,
      y: state.startingPoint?[1] ?? 0,
      endX: state.finishingPoint?[0] ?? map[0].length - 1,
      endY: state.finishingPoint?[1] ?? map.length - 1,
      n: 2,
    )?.map((e) => "${e[0]},${e[1]}").toSet();

    final res = route?.toList()?..removeLast();

    emit(
      state.copyWith(
        route: res?.toSet(),
      ),
    );
  }

  void selectStartingPoint(int x, int y) {
    emit(state.copyWith(startingPoint: [x, y]));
  }

  void selectFinishingPoint(int x, int y) {
    emit(state.copyWith(finishingPoint: [x, y]));
  }

    List<List<int>>? _iterate({
      required int startX,
      required int startY,
      required int endX,
      required int endY,
      required int x,
      required int y,
      required int n,
    }) {
      final map = state.solvedMap;

      if (endX == x && endY == y) return [];

      if (y >= map.length ||
          x >= map[0].length ||
          x < 0 ||
          y < 0 ||
          map[y][x] == 1 ||
          map[y][x] != 0 && map[y][x] < n) return null;

      map[y][x] = n;

      final res1 = _iterate(
        startX: startX,
        startY: startY,
        endX: endX,
        endY: endY,
        x: x + 1,
        y: y,
        n: n + 1,
      );

      final res2 = _iterate(
        startX: startX,
        startY: startY,
        endX: endX,
        endY: endY,
        x: x - 1,
        y: y,
        n: n + 1,
      );

      final res3 = _iterate(
        startX: startX,
        startY: startY,
        endX: endX,
        endY: endY,
        x: x,
        y: y + 1,
        n: n + 1,
      );

      final res4 = _iterate(
        startX: startX,
        startY: startY,
        endX: endX,
        endY: endY,
        x: x,
        y: y - 1,
        n: n + 1,
      );

      final arrRes = [res1, res2, res3, res4];

      int mnIndex = -1;
      int mn = map.length * map[0].length;

      for (int i = 0; i < arrRes.length; i++) {
        final res = arrRes[i];
        if (res == null) continue;

        if (mn > res.length) {
          mn = res.length;
          mnIndex = i;
        }
      }

      if (mnIndex == -1) {
        return null;
      }

      return arrRes[mnIndex]?..add([x, y]);
    }
}
