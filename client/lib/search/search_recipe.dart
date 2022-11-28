import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:recipe_app/routes/api_connection.dart';
import 'package:recipe_app/models/recipe_model.dart';

class SearchRecipe extends StatelessWidget {
  const SearchRecipe({super.key});


  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Recipe?>(
      debounceDuration: const Duration(milliseconds: 500),
      textFieldConfiguration: const TextFieldConfiguration(
          decoration: InputDecoration(
        prefixIcon: Icon(Icons.search_outlined),
        border: InputBorder.none,
        hintText: 'Search Recipes',
      )),
      suggestionsCallback: FetchRecipeList.searchRecipeList,
      itemBuilder: (context, Recipe? suggestion) {
        final recipe = suggestion!;
        //print(user.name);
        return ListTile(
          title: Text(Recipe.formatCase(recipe.name)),
          // onTap: () {
          //   debugPrint('Item ${(user.name)} selected');
          //   searchIngredientsList(value: user.name);
          // },
        );
      },
      noItemsFoundBuilder: (context) => const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'No ingredients found',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      onSuggestionSelected: (Recipe? suggestion) {
        final recipe = suggestion!;

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Selected recipe : ${recipe.name}'),
            ),
          );
      },
    );
  }

}
