import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maze_generator/src/map_with_islands_generator.dart';

part 'maps_list_state.dart';

part 'maps_list_cubit.freezed.dart';

class MapsListCubit extends Cubit<MapsListState> {
  MapsListCubit() : super(const MapsListState.initial()) {
    load();
  }

  void load() {
    final maps = <List<List<int>>>[];

    for (int i = 0; i < 6; i++) {
      maps.add(
        MapWithIslandsGenerator.generateV2(
          width: 13,
          height: 13,
        ),
        // MapWithIslandsGenerator.generate(
        //   width: 13,
        //   height: 13,
        //   maxCountIslands: 40,
        //   maxIslandSize: 100,
        // ),
      );
    }

    emit(MapsListState.loaded(maps: maps));
  }
}
