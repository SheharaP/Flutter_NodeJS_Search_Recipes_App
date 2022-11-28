import 'package:flutter/material.dart';
import 'dart:async';

import 'package:recipe_app/routes/api_connection.dart';

import 'package:recipe_app/search/search_ingredient.dart';
import 'package:recipe_app/models/ingredient_model.dart';



class IngredientsPage extends StatefulWidget {
   final Stream<int> stream;

  const IngredientsPage(this.stream, {super.key});

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  final FetchItemList _itemList = FetchItemList();

  bool isVisible = true;

  String category = ' ';

  @override
  void initState(){
    super.initState();
    widget.stream.listen((index) { 
      mySetState(index);
    });
  }

  void mySetState(int index) async{
    List categoryList = await _itemList.getCategoryList();
    setState(() {
      category = categoryList[index];
    });
  }

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
          child: const SearchItem(),
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
              future: FetchItemList.getCategoryIngredients(category: category),
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
                                debugPrint('Item ${(data?[index])} selected');
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
        content: Text('Selected ingredient : ${Item.formatCase('$x')}'),
        duration: const Duration(milliseconds: 500),
      ),
    );

  Widget buildCard({
    required String item,
  }) =>
      Container(
        width: 120,
        child: Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFF603813),
                    ),
                    child: Text(
                      Item.formatCase(item),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    debugPrint('Item pressed : $item');
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
