import 'package:flutter/material.dart';

import 'package:recipe_app/search/found_recipes.dart';
import 'package:recipe_app/search/search_ingredient.dart';
import 'package:recipe_app/models/ingredient_model.dart';

class SelectedIngredients extends StatefulWidget {
  const SelectedIngredients({super.key});

  @override
  State<SelectedIngredients> createState() => _SelectedIngredientsState();
}

class _SelectedIngredientsState extends State<SelectedIngredients> {
  void updateUI() {
    setState(() {
      const SelectedIngredients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: FutureBuilder<List<String?>>(
            future: SearchItem.searchIngredientsList(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              return snapshot.connectionState == ConnectionState.waiting
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                    title: Text(
                                      Item.formatCase('${data?[index]}'),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                          Icons.delete_outline_sharp),
                                      onPressed: () {
                                        showResult(data?[index]);
                                        debugPrint('Delete ${data?[index]}');
                                        SearchItem.deleteIngredientsList(
                                            value: data?[index]);
                                        updateUI();
                                      },
                                    )),
                              ),
                            ],
                          ),
                        );
                      });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
            onPressed: () {
              SearchItem.searchRecipeList = [];
              updateUI();
            },
            child: const Text('Reset'),
          ),
          OutlinedButton( 
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const FoundRecipes();
                  },
                ),
              );
              //streamController.add(await FetchRecipeList.searchRecipes());
            },
            child: const Text('Get Recipes!'),
          ),
        ],
      ),
    ]);
  }

  ScaffoldMessengerState showResult(x) => ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text('Deleted ingredient : ${Item.formatCase('$x')}'),
        duration: const Duration(milliseconds: 500),
      ),
    );
}
