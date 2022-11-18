import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:recipe_app/Api_service.dart';
import 'package:recipe_app/user_model.dart';

class SearchUser extends StatelessWidget {
  FetchUserList _userList = FetchUserList();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<Userlist?>(
      suggestionsCallback: FetchUserList.searchUserList,
      itemBuilder: (context, Userlist? suggestion) {
        final user = suggestion!;
        print(user.name);
        return ListTile(
          title: Text(user.name),
        );
      },
      noItemsFoundBuilder: (context) => Container(
        height: 100,
        child: Center(
          child: Text(
            'No ingredients found',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      onSuggestionSelected: (Userlist? suggestion) {
        final user = suggestion!;

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Selected user : ${user.name}'),
            ),
          );
      },
    );
  }

  // return FutureBuilder<List<Userlist>>(
  //     future: _userList.getuserList(query: query),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //       List<Userlist>? data = snapshot.data;
  //       return ListView.builder(
  //           itemCount: data?.length,
  //           itemBuilder: (context, index) {
  //             return ListTile(
  //               title: Row(
  //                 children: [
  //                   Container(
  //                     width: 60,
  //                     height: 60,
  //                     decoration: BoxDecoration(
  //                       color: Colors.deepPurpleAccent,
  //                       borderRadius: BorderRadius.circular(10),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         '${data?[index].id}',
  //                         style: TextStyle(
  //                             fontSize: 20,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.white),
  //                         overflow: TextOverflow.clip,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(width: 20),
  //                   Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           '${data?[index].name}',
  //                           style: TextStyle(
  //                               fontSize: 18, fontWeight: FontWeight.w600),
  //                         ),
  //                       ])
  //                 ],
  //               ),
  //             );
  //           });
  //     });

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search User'),
    );
  }
}
