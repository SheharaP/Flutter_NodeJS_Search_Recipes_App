import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_app/models/user_model.dart';

class FetchUserList {
  
  var data = [];
  List<Userlist> results = [];
  static String urlItemList = 'http://192.168.213.179:8080/items/';

  static String urlRecipeList = 'http://192.168.213.179:8080/recipes/';

  Future<List<Userlist>> getuserList({String? query}) async {

    try {
      var response = await http.get(Uri.parse(urlItemList));
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print(data);
        results = data.map((e) => Userlist.fromJson(e)).toList();

        if (query != null) {
          results = results.where(
                (element) => element.name!.toLowerCase().contains((query.toLowerCase()),),
              ).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }


  static Future<List<Userlist>> searchUserList(String query) async {

      var res = await http.get(Uri.parse(urlItemList));

      if (res.statusCode == 200) {

        final List users = json.decode(res.body);
        print(users);

        return users.map((e) => Userlist.fromJson(e)).where((user){
          final nameLower = user.name!.toLowerCase();
          final queryLower = query!.toLowerCase();

          return nameLower.contains(queryLower);
        }).toList();

      } else {
        throw Exception();
      }
  }

  Future<List<Userlist>> getRecipeList({String? query}) async {

    try {
      var response = await http.get(Uri.parse(urlRecipeList));
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print(data);
        results = data.map((e) => Userlist.fromJson(e)).toList();

        if (query != null) {
          results = results.where(
                (element) => element.name!.toLowerCase().contains((query.toLowerCase()),),
              ).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
