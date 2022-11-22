import 'package:flutter/material.dart';
import 'package:recipe_app/home_page.dart';
import 'package:recipe_app/search/filter_page.dart';

import 'package:recipe_app/selected_ingredient.dart';
import 'package:recipe_app/recipes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentPage = 0;
  List<Widget> pages = [
    const HomePage(),
    const SelectedIngredients(),
    Recipes(),
    FilterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe9dac1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFe9dac1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'Images/recipe_app_logo.png',
              fit: BoxFit.contain,
              height: 70,
            ),
          ],
        ),
        //const Text(
        //   'Ingredients',
        //   style: TextStyle(color: Colors.black),
        // ),
        elevation: 0,
      ),
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFFe9dac1),
        destinations: const [
          NavigationDestination(
              icon: ImageIcon(
                AssetImage("Images/ingredients_nav.png"),
                size: 35,
              ),
              label: 'Ingredients'),
          NavigationDestination(
              icon: Icon(Icons.list_alt_sharp, size: 30), label: 'Selected Items'),
          NavigationDestination(
              icon: ImageIcon(
                AssetImage("Images/recipes_nav.png"),
                size: 35,
              ),
              label: 'Recipes'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
    );
  }
}
