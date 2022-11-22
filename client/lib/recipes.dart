import 'package:flutter/material.dart';

import 'package:recipe_app/routes/api_connection.dart';
import 'package:recipe_app/search/search_recipe.dart';
import 'package:recipe_app/models/recipe_model.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  final FetchRecipeList _recipeList = FetchRecipeList();

  bool showTextField = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: SearchRecipe()),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<RecipeList>>(
                future: _recipeList.getRecipeList(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  return snapshot.connectionState == ConnectionState.waiting
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: data?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: ListTile(
                                title: Text(
                                  RecipeList.formatCase('${data?[index].name}'),
                                ),
                                onTap: () {
                                  debugPrint(
                                      'Item ${(data?[index].name)} selected');
                                  //SearchUser.searchIngredientsList(value : data?[index].name);
                                },
                              ),
                            );
                          });
                }),
          ),
        ],
      ),
    );
  }
}
