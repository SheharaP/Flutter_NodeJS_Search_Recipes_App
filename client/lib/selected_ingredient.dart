import 'package:flutter/material.dart';

import 'package:recipe_app/search.dart';
import 'package:recipe_app/models/user_model.dart';

class SelectedIngredients extends StatefulWidget {
  const SelectedIngredients({super.key});

  @override
  State<SelectedIngredients> createState() => _SelectedIngredientsState();
}

class _SelectedIngredientsState extends State<SelectedIngredients> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String?>>(
        future: SearchUser.searchIngredientsList(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          print(data);
          return ListView.builder(
              shrinkWrap: true,
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: ListTile(
                    title: Text(
                      Userlist.formatCase('${data?[index]}'),
                    ),
                  ),
                );
              });
        });
  }
}
