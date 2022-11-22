import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/ingredient_model.dart';

import 'package:recipe_app/routes/api_connection.dart';
import 'package:recipe_app/search/search_ingredient.dart';

class FilterCategory extends StatefulWidget {
  @override
  State<FilterCategory> createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  late String valueKey = ' ';
  final FetchItemList _itemList = FetchItemList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        buildCard(),
        SizedBox(width: 10,),
        buildCard(),
        SizedBox(width: 10,),
        buildCard(),
        SizedBox(width: 10,),
        buildCard(),
        SizedBox(width: 10,),
        buildCard(),
        SizedBox(width: 10,),
      ],

    );

  }

  Widget buildCard() => Container(
    width: 200,
    height: 200,
    color: Colors.brown,
  );
}




              // Container(
              //   margin: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              //   width: double.infinity,
              //   decoration: const BoxDecoration(
              //     color: Colors.white,
              //   ),
              //   child: FilterCategory(),
              // ),