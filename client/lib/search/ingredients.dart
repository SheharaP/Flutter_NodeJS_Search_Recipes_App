import 'package:flutter/material.dart';
import 'package:recipe_app/search/filter_page.dart';

import 'package:recipe_app/routes/api_connection.dart';

import 'package:recipe_app/search/search_ingredient.dart';
import 'package:recipe_app/models/ingredient_model.dart';

class IngredientsPage extends StatefulWidget {

  String? ingredient;

  IngredientsPage(this.ingredient, {super.key});

  @override
  _IngredientsPageState createState() => _IngredientsPageState();

}

class _IngredientsPageState extends State<IngredientsPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: SearchItem(),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
                future: FetchItemList.getCategoryIngredients(category: widget.ingredient),
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
                              child: ListTile(
                                title: Text(
                                  Item.formatCase('${data?[index]}'),
                                ),
                                onTap: () {
                                  debugPrint(
                                      'Item ${(data?[index])} selected');
                                  SearchItem.searchIngredientsList(
                                      value: data?[index]);
                                  showResult(data?[index]);
                                },
                              ),
                            );
                          });
                }),
          ),
        ],
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
