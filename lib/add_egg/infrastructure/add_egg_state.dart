part of 'add_egg_bloc.dart';

abstract class AddEggState extends Equatable {
  const AddEggState();
}

class AddEggInitialState extends AddEggState {
  @override
  List<Object> get props => [];
}

class AddEggErrorState extends AddEggState {
  final String errorMessage;

  const AddEggErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AddEggSuccessState extends AddEggState {
  @override
  List<Object> get props => [];
}