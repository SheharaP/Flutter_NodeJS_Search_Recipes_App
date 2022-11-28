import 'package:flutter/material.dart';

import 'package:recipe_app/search/found_recipes.dart';
import 'package:recipe_app/search/search_recipe.dart';

//StreamController<List<Recipe>> streamController = StreamController<List<Recipe>>.broadcast();

class Recipes extends StatefulWidget {

  const Recipes({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchRecipe(),
          const FoundRecipes()
        ],
      ),
    );
  }
}
