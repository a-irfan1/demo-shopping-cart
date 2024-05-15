import 'package:dio/dio.dart';

import '../models/items.dart';

// late List<Item> catalog;

const _catalog = [
  'Code Smell',
  'Control Flow',
  'Interpreter',
  'Recursion',
  'Sprint',
  'Heisenbug',
  'Spaghetti',
  'Hydra Code',
  'Off-By-One',
  'Scope',
  'Callback',
  'Closure',
  'Automata',
  'Bit Shift',
  'Currying',
];

class StoreRepository {
  // final Dio _client = Dio(BaseOptions(
  //   baseUrl: "https://fakestoreapi.com/products",
  // ));

  final items = <Item>[];

  // Future<List<Item>> loadCatalog() async {
  //   final response = await _client.get('');
  //   catalog = (response.data as List)
  //       .map((json) => Item(
  //             json['id'],
  //             json['title'],
  //             // json['image'],
  //             // json['price'],
  //           ))
  //       .toList();
  //
  //   return catalog;
  // }

  Future<List<String>> loadCatalog() {
    return Future.delayed(const Duration(milliseconds: 800), () => _catalog);
  }

  Future<List<Item>> loadItems() {
    return Future.delayed(const Duration(milliseconds: 800), () => items);
  }

  void addItemToCart(Item item) => items.add(item);

  void removeItemFromCart(Item item) => items.remove(item);
}
