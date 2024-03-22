part of 'egg_list_bloc.dart';

sealed class EggListState extends Equatable {
  const EggListState();
}

class EggListInitialState extends EggListState {
  @override
  List<Object> get props => [];
}

class EggListFetchedState extends EggListState {
  final List<Egg> eggs;

  const EggListFetchedState({required this.eggs});

  @override
  List<Object?> get props => [eggs];
}
