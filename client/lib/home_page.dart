import 'package:flutter/material.dart';
import 'dart:async';

import 'package:recipe_app/search/filter_page.dart';
import 'package:recipe_app/search/ingredients.dart';
import 'package:recipe_app/models/ingredient_model.dart';

StreamController<int> streamController = StreamController<int>.broadcast();

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FilterPage(),
          Expanded(
            child: IngredientsPage(streamController.stream),
          ),
        ],
      ),
    );
  }

  ScaffoldMessengerState showResult(x) => ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text('Selected ingredient : ${Item.formatCase('$x')}'),
        duration: const Duration(milliseconds: 500),
      ),
    );
}
