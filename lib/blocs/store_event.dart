part of 'store_bloc.dart';

@immutable
abstract class StoreEvent extends Equatable {
  const StoreEvent();
}

final class StoreStarted extends StoreEvent {
  @override
  List<Object> get props => [];
}
