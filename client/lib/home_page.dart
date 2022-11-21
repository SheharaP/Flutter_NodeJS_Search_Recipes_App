import 'package:flutter/material.dart';

import 'package:recipe_app/Api_service.dart';
import 'package:recipe_app/search.dart';
import 'package:recipe_app/models/user_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FetchUserList _userList = FetchUserList();

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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: SearchUser()),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Userlist>>(
                future: _userList.getuserList(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: ListTile(
                            title: Text(
                              Userlist.formatCase('${data?[index].name}'),
                            ),
                            onTap: () {
                              debugPrint('Item ${(data?[index].name)} selected');
                              SearchUser.searchIngredientsList(value : data?[index].name);
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
}
