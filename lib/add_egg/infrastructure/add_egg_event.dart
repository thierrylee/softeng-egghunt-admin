part of 'add_egg_bloc.dart';

sealed class AddEggEvent extends Equatable {
  const AddEggEvent();
}

class AddEggSubmitEvent extends AddEggEvent {
  final String eggName;
  final String eggDescription;
  final int eggValue;

  const AddEggSubmitEvent({required this.eggName, required this.eggDescription, required this.eggValue});

  @override
  List<Object?> get props => [eggName, eggDescription, eggValue];
}
