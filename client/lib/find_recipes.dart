import 'package:flutter/material.dart';

import 'package:recipe_app/search.dart';

class FindRecipes extends StatefulWidget {
  const FindRecipes({super.key});

  @override
  State<FindRecipes> createState() => _FindRecipesState();
}

class _FindRecipesState extends State<FindRecipes> {

  Future<List<String?>> searchRecipeList = SearchUser.searchIngredientsList();

  void searchRecipes () {
    
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}