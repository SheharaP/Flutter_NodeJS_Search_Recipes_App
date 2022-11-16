import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:recipe_app/learn_flutter.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String baseURL = 'http://10.0.2.2:8080/items';

  Future<List> searchIngredients() async {
    try {
      var response = await http.get(Uri.parse(baseURL));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error('Server error');
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 20),
      width: double.infinity,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(5),
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          hintText: "Search bar",
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: const Color(0xFF000000),
        ),
      ),
    );
  }
}
