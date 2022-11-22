import 'package:flutter/material.dart';
import 'package:recipe_app/models/ingredient_model.dart';

class ChosenCategory extends StatelessWidget {

  const ChosenCategory({super.key, required String item});
  
  get item => ChosenCategory;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: item,
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
                  itemBuilder: (context, index) => buildCard(item: data[index]),
                );
        });
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
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
