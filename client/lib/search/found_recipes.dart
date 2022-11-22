import 'package:flutter/material.dart';
import 'package:recipe_app/routes/api_connection.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/search/search_ingredient.dart';

import '../models/ingredient_model.dart';

class FoundRecipeList extends StatefulWidget {
  const FoundRecipeList({super.key});

  @override
  State<FoundRecipeList> createState() => _FoundRecipeListState();
}

class _FoundRecipeListState extends State<FoundRecipeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<RecipeList>>(
            future: FetchRecipeList.searchRecipes(),
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
                              ItemList.formatCase('${data?[index].name}'),
                            ),
                            onTap: () {
                              debugPrint(
                                  'Item ${(data?[index].name)} selected');
                              SearchItem.searchIngredientsList(
                                  value: data?[index].name);
                            },
                          ),
                        );
                      });
            }),
      ),
    );
  }
}
