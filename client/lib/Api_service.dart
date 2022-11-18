import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_app/user_model.dart';

class FetchUserList {
  
  var data = [];
  List<Userlist> results = [];
  String urlList = 'http://192.168.132.179:8080/items/';

  Future<List<Userlist>> getuserList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(Uri.parse(urlList));
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
    var url = Uri.parse('http://192.168.132.179:8080/items/');

      var res = await http.get(url);

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
}
