import 'package:flutter/material.dart';
import 'package:recipe_app/models/ingredient_model.dart';
import 'package:recipe_app/routes/api_connection.dart';

class FilterPage extends StatelessWidget {
  FilterPage({super.key});


   final FetchItemList _itemList = FetchItemList();

   static String? filterCategory(String item) {
    print('Recieved ${item}');
    return item;
  }
   
  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.fromLTRB(5, 20, 5, 5),
            height: 50,
            color: Colors.white,
            padding: EdgeInsets.all(5),
            child: FutureBuilder<List<dynamic>>(
                future: _itemList.getCategoryList(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  print(data);
                  return snapshot.connectionState == ConnectionState.waiting
                      ? const CircularProgressIndicator()
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, _) => const SizedBox(
                            width: 12,
                          ),
                          itemCount: data!.length,
                          itemBuilder: (context, index) =>
                              buildCard(item: data[index]),
                        );
                }),
          );
  }

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
                      ItemList.formatCase(item),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    debugPrint('Item pressed : ${item}');
                    filterCategory(item);
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
