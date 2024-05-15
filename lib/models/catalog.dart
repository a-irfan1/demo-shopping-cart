import 'package:bloc_fakestore_app/models/items.dart';
import 'package:equatable/equatable.dart';

class Catalog extends Equatable {
  const Catalog({required this.itemNames});

  final List<String> itemNames;

  Item getByID(int id) => Item(id, itemNames[id % itemNames.length]);

  Item getByPosition(int position) => getByID(position);

  @override
  List<Object> get props => [itemNames];
}
