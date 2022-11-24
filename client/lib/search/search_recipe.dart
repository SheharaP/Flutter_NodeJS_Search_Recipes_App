import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:recipe_app/routes/api_connection.dart';
import 'package:recipe_app/models/recipe_model.dart';

class SearchRecipe extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Recipe?>(
      debounceDuration: Duration(milliseconds: 500),
      textFieldConfiguration: const TextFieldConfiguration(
          decoration: InputDecoration(
        prefixIcon: Icon(Icons.search_outlined),
        border: InputBorder.none,
        hintText: 'Search Recipes',
      )),
      suggestionsCallback: FetchRecipeList.searchRecipeList,
      itemBuilder: (context, Recipe? suggestion) {
        final user = suggestion!;
        //print(user.name);
        return ListTile(
          title: Text(Recipe.formatCase(user.name)),
          // onTap: () {
          //   debugPrint('Item ${(user.name)} selected');
          //   searchIngredientsList(value: user.name);
          // },
        );
      },
      noItemsFoundBuilder: (context) => Container(
        height: 100,
        child: const Center(
          child: Text(
            'No ingredients found',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      onSuggestionSelected: (Recipe? suggestion) {
        final user = suggestion!;

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Selected recipe : ${user.name}'),
            ),
          );
      },
    );
  }

}
