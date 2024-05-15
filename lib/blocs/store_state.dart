part of 'store_bloc.dart';

@immutable
abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

final class StoreLoading extends StoreState {}

final class StoreLoaded extends StoreState {
  const StoreLoaded(this.catalog);

  final Catalog catalog;

  @override
  List<Object> get props => [catalog];
}

final class StoreError extends StoreState {}
