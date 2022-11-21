import 'package:flutter/material.dart';
import 'package:recipe_app/models/ingredient_model.dart';
import 'package:recipe_app/routes/api_connection.dart';

class FilterCategory extends StatefulWidget {
  @override
  State<FilterCategory> createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  late String valueKey = ' ';
  final FetchItemList _itemList = FetchItemList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: _itemList.getCategoryList(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data?.length,
                  itemBuilder: (context, index) {
                    return DropdownButton(
                      value: valueKey,
                      onChanged: (newValue) {
                        print('CATEGORY ${data?[index]}');
                        setState((){
                          //valueKey = newValue!;
                        });
                      }, items: [],
                      // items: data.map((valueItem) {
                      //   return DropdownMenuItem(child: Text(valueItem),);
                      // }),
                    );
                  });
        });

    // DropdownButton(
    //   value: valueKey,
    //   onChanged: (newValue) {
    //     setState((){
    //       valueKey = newValue!;
    //     });
    //   },
    //   items: FetchItemList.getItemList.category,
    // );
  }
}
