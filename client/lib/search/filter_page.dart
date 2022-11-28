import 'package:flutter/material.dart';
import 'package:recipe_app/home_page.dart';
import 'package:recipe_app/models/ingredient_model.dart';
import 'package:recipe_app/routes/api_connection.dart';

class FilterPage extends StatefulWidget {

  FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final FetchItemList _itemList = FetchItemList();

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 16),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_down_outlined)),
          ],
        ),
      ),
      Visibility(
        visible: isVisible,
        child: Container(
          margin:const EdgeInsets.fromLTRB(5, 2, 5, 5),
          height: 45,
          color: Colors.white,
          padding:const EdgeInsets.all(5),
          child: FutureBuilder<List<dynamic>>(
              future: _itemList.getCategoryList(),
              builder: (context, snapshot) {
                var data = snapshot.data;
                
                return snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, _) => const SizedBox(
                          width: 12,
                        ),
                        itemCount: data!.length,
                        itemBuilder: (context, index) =>
                            buildCard(item: data[index], index: index),
                      );
              }),
        ),
      ),
    ]);
  }

  Widget buildCard({
    required String item, required int index,
  }) =>
      SizedBox(
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
                    streamController.add(index);
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
