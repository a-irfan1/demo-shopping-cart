import 'package:bloc/bloc.dart';
import 'package:bloc_fakestore_app/repository/store_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/catalog.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc({required this.storeRepository}) : super(StoreLoading()) {
    on<StoreStarted>(_onStarted);
  }

  final StoreRepository storeRepository;

  Future<void> _onStarted(StoreStarted event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    try {
      final catalog = await storeRepository.loadCatalog();
      emit(StoreLoaded(Catalog(itemNames: catalog)));
    } catch (_) {
      emit(StoreError());
    }
  }
}
