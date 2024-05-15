import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Item extends Equatable {
  Item(
    this.id,
    this.title,
    // this.image,
    // this.price,
  ) : color = Colors.primaries[id % Colors.primaries.length];

  final int id;
  final String title;
  // final String image;
  final Color color;
  final double price = Random().nextInt(90) + 10;

  @override
  List<Object?> get props => [id, title, /*image,*/ color];
}
