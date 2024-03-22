part of 'egg_list_bloc.dart';

sealed class EggListEvent extends Equatable {
  const EggListEvent();
}

class EggListInitEvent extends EggListEvent {
  @override
  List<Object?> get props => [];
}

class EggListUpdateEvent extends EggListEvent {
  final Iterable<Egg> eggs;

  const EggListUpdateEvent({required this.eggs});

  @override
  List<Object?> get props => [eggs];
}
