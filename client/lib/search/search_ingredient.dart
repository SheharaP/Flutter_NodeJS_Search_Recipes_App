import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:recipe_app/routes/api_connection.dart';
import 'package:recipe_app/models/ingredient_model.dart';

class SearchItem extends StatelessWidget {

  static List<String?> searchRecipeList = [];

  const SearchItem({super.key});

  static Future<List<String?>> searchIngredientsList({String? value}) async {
    // ignore: iterable_contains_unrelated_type
    
    if (searchRecipeList.contains(value)) {
      debugPrint('Ingredient is already there');
    } else {
      if (value != null) {

        searchRecipeList.add(value);
      }
    }
    return searchRecipeList;
  }

    static Future<List<String?>> deleteIngredientsList({String? value}) async {
    // ignore: iterable_contains_unrelated_type
    
    if (searchRecipeList.contains(value)) {
      searchRecipeList.remove(value);
    } else {
      debugPrint('Ingredient is not there');
    }
    return searchRecipeList;
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Item?>(
      debounceDuration:const Duration(milliseconds: 500),
      textFieldConfiguration: const TextFieldConfiguration(
          decoration: InputDecoration(
        prefixIcon: Icon(Icons.search_outlined),
        border: InputBorder.none,
        hintText: 'Search Ingredients',
      )),
      suggestionsCallback: FetchItemList.searchItemList,
      itemBuilder: (context, Item? suggestion) {
        final item = suggestion!;
        //print(user.name);
        return ListTile(
          title: Text(Item.formatCase(item.name)),
          onTap: () {
            debugPrint('Item ${(item.name)} selected');
            searchIngredientsList(value: item.name);
          },
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
      onSuggestionSelected: (Item? suggestion) {
        final item = suggestion!;

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Selected user : ${item.name}'),
            ),
          );
      },
    );
  }
}
