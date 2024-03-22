import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softeng_egghunt_admin/data/egg.dart';
import 'package:softeng_egghunt_admin/repository/eggs_repository.dart';

part 'add_egg_event.dart';

part 'add_egg_state.dart';

class AddEggBloc extends Bloc<AddEggEvent, AddEggState> {
  late EggsRepository _eggRepository;

  AddEggBloc({required EggsRepository eggRepository}) : super(AddEggInitialState()) {
    _eggRepository = eggRepository;
    on<AddEggSubmitEvent>(_onSubmitEgg);
  }

  Future<void> _onSubmitEgg(
    AddEggSubmitEvent event,
    Emitter<AddEggState> emit,
  ) async {
    if (event.eggValue < 0) {
      emit(const AddEggErrorState(errorMessage: "C'est méchant de faire des malus ! 😬"));
    }

    final eggs = await _eggRepository.getEggs();
    if (eggs.any((egg) => egg.eggName == event.eggName)) {
      emit(const AddEggErrorState(errorMessage: "Une oeuf à ce nom existe déjà ! 😵"));
      return;
    }

    _eggRepository.addEgg(Egg(
      eggName: event.eggName,
      eggDescription: event.eggDescription,
      eggValue: event.eggValue,
    ));
    emit(AddEggSuccessState());
  }
}
