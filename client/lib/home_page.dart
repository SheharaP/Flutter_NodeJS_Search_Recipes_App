import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:recipe_app/search_bar.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String baseURL = 'http://10.0.2.2:8080/items';

  Future<List> getIngredients() async {
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Search(),
        Container(
          child: FutureBuilder<List>(
            future: getIngredients(),
            builder: (context, snapshot) {
              print(snapshot.data);
              //print(snapshot);
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, i) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          formatCase(snapshot.data![i]['name']),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No data found'),
                );
              }
            },
          ),
        ),
      ],
    ));
  }
}
