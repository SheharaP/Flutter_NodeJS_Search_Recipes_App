import 'package:flutter/material.dart';

import 'package:recipe_app/routes/api_connection.dart';
import 'package:recipe_app/search/search_ingredient.dart';
import 'package:recipe_app/models/ingredient_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FetchItemList _itemList = FetchItemList();

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
                child: SearchItem(),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<ItemList>>(
                future: _itemList.getItemList(),
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
                                  ItemList.formatCase('${data?[index].name}'),
                                ),
                                onTap: () {
                                  debugPrint(
                                      'Item ${(data?[index].name)} selected');
                                  SearchItem.searchIngredientsList(
                                      value: data?[index].name);
                                  showResult(data?[index].name);
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

  ScaffoldMessengerState showResult(x) => ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text('Selected ingredient : ${ItemList.formatCase('${x}')}'),
        duration: const Duration(milliseconds: 500),
      ),
    );
}
