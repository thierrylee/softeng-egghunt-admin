import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softeng_egghunt_admin/data/egg.dart';
import 'package:softeng_egghunt_admin/repository/eggs_repository.dart';

part 'egg_list_event.dart';

part 'egg_list_state.dart';

class EggListBloc extends Bloc<EggListEvent, EggListState> {
  late EggsRepository _eggsRepository;

  EggListBloc({required EggsRepository eggsRepository}) : super(EggListInitialState()) {
    _eggsRepository = eggsRepository;
    on<EggListInitEvent>(_onInit);
    on<EggListUpdateEvent>(_onEggsUpdate);
  }

  Future<void> _onInit(
    EggListInitEvent event,
    Emitter<EggListState> emit,
  ) async {
    _eggsRepository.listenOnEggs(this);
  }

  Future<void> _onEggsUpdate(
    EggListUpdateEvent event,
    Emitter<EggListState> emit,
  ) async {
    emit(EggListFetchedState(eggs: event.eggs.toList()));
  }
}
