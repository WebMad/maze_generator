part of 'maps_list_cubit.dart';

@freezed
class MapsListState with _$MapsListState {
  const factory MapsListState.initial() = _Initial;

  const factory MapsListState.loaded({
    required List<List<List<int>>> maps,
  }) = _Loaded;
}
