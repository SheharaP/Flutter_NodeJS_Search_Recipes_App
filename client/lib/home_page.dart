import 'package:flutter/material.dart';
import 'package:recipe_app/search/filter_page.dart';

import 'package:recipe_app/routes/api_connection.dart';
import 'package:recipe_app/search/ingredients.dart';

import 'package:recipe_app/search/search_ingredient.dart';
import 'package:recipe_app/models/ingredient_model.dart';

class HomePage extends StatefulWidget {

  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          FilterPage(null),
          Expanded(
            child: IngredientsPage(null),
          ),
        ],
      ),
    );
  }

  ScaffoldMessengerState showResult(x) => ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text('Selected ingredient : ${Item.formatCase('${x}')}'),
        duration: const Duration(milliseconds: 500),
      ),
    );
}
