import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:recipe_app/Api_service.dart';
import 'package:recipe_app/models/user_model.dart';

class SearchUser extends StatelessWidget {

  static List<String?> searchRecipeList = [];

  static Future<List<String?>> searchIngredientsList({String? value}) async {
    // ignore: iterable_contains_unrelated_type
    if (searchRecipeList.contains(value)) {
      debugPrint('Ingredient is already there');
    } else {
      if (value != null) {

        searchRecipeList.add(value);

        // searchRecipeList = searchRecipeList
        //     .where(
        //       (element) => element!.toLowerCase().contains(
        //             (value!.toLowerCase()),
        //           ),
        //     )
        //     .toList();

        print(searchRecipeList);
      }
    }
    return searchRecipeList;
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Userlist?>(
      debounceDuration: Duration(milliseconds: 500),
      textFieldConfiguration: const TextFieldConfiguration(
          decoration: InputDecoration(
        prefixIcon: Icon(Icons.search_outlined),
        border: InputBorder.none,
        hintText: 'Search Ingredients',
      )),
      suggestionsCallback: FetchUserList.searchUserList,
      itemBuilder: (context, Userlist? suggestion) {
        final user = suggestion!;
        //print(user.name);
        return ListTile(
          title: Text(Userlist.formatCase(user.name)),
          onTap: () {
            debugPrint('Item ${(user.name)} selected');
            searchIngredientsList(value: user.name);
          },
        );
      },
      noItemsFoundBuilder: (context) => Container(
        height: 100,
        child: Center(
          child: Text(
            'No ingredients found',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      onSuggestionSelected: (Userlist? suggestion) {
        final user = suggestion!;

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Selected user : ${user.name}'),
            ),
          );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search User'),
    );
  }
}
