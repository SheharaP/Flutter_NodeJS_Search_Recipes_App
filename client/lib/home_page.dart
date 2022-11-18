import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:recipe_app/Api_service.dart';

import 'package:recipe_app/search.dart';

import 'package:recipe_app/user_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchUserList _userList = FetchUserList();

  String formatCase(String text) {
    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }

  bool showTextField = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: SearchUser()
              ),
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
                              formatCase('${data?[index].name}'),
                            ),
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
