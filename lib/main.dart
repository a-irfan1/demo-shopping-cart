import 'package:bloc_fakestore_app/repository/store_repository.dart';
import 'package:bloc_fakestore_app/simple_bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'app.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(App(storeRepository: StoreRepository()));
}
