import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/models/ingredient_model.dart';
import 'package:recipe_app/routes/flavor_config.dart';
import 'package:recipe_app/search/search_ingredient.dart';

class FetchItemList {
  var data = [];
  List<Item> results = [];

Future<List> getCategoryList({String? query}) async {
  
    var response = await Dio().get('${FlavorConfig.baseUrl}/items');

    if (response.statusCode == 200) {
      final List categories = response.data.toList();

      List<dynamic> foundCategories = [];
      //List<dynamic> uniqueCategories = [];

      for (var element in categories) {
        //print(element['category'].join(', '));
        for (var e in element['category']) {
          foundCategories.add(e);
        }
      }

      //uniqueCategories = foundCategories.toSet().toList();

      return foundCategories.toSet().toList();
    } else {
      throw Exception();
    }
  }

  // Future<List<Item>> getItemList({String? query}) async {
  //   try {
  //     var response = await Dio().get(urlItemList);

  //     if (response.statusCode == 200) {
  //       data = response.data.toList();

  //       print(data);

  //       results = data.map((e) => Item.fromJson(e)).toList();

  //       if (query != null) {
  //         results = results
  //             .where(
  //               (element) => element.name.toLowerCase().contains(
  //                     (query.toLowerCase()),
  //                   ),
  //             )
  //             .toList();
  //       }
  //     } else {
  //       print("fetch error");
  //     }
  //   } on Exception catch (e) {
  //     print('error: $e');
  //   }

  //   return results;
  // }

  static Future<List<dynamic>> getCategoryIngredients({String? category}) async {

    var response = await Dio().get('${FlavorConfig.baseUrl}/items');

    List<dynamic> allItemList = [];

    if (response.statusCode == 200) {

      if (category == ' ') {

        debugPrint('NULL QUERY');

        final List items = response.data.toList();

        for (var element in items) {
          //print(element);
          allItemList.add(element['name']);
        }

        //debugPrint(allItemList);

        return allItemList;

      } else {

        debugPrint('NOT NULL QUERY');

        debugPrint(category);

        final List categories = response.data.toList();

        List<dynamic> foundCategoryItems = [];

        for (var element in categories) {
          for (var e in element['category']) {
            //debugPrint(e);
            if(e == category){
              foundCategoryItems.add(element['name']);
              //debugPrint(element['name']);
              break;
            }
            else{
              continue;
            }
            
          }
        }

        //debugPrint(foundCategoryItems);

        return foundCategoryItems;
      }
    } else {
      throw Exception();
    }
  }

  static Future<List<Item>> searchItemList(String query) async {
    var res = await Dio().get('${FlavorConfig.baseUrl}/items');

    if (res.statusCode == 200) {
      final List items = res.data.toList();
     

      return items.map((e) => Item.fromJson(e)).where((item) {
        final nameLower = item.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}

class FetchRecipeList {
  var data = [];
  List<Recipe> resultRecipes = [];

  Future<List<Recipe>> getRecipeList({String? query}) async {
    try {
      var response = await Dio().get('${FlavorConfig.baseUrl}/recipes');

      if (response.statusCode == 200) {
        data = response.data.toList();
        
        resultRecipes = data.map((e) => Recipe.fromJson(e)).toList();

        if (query != null) {
          resultRecipes = resultRecipes
              .where(
                (element) => element.name.toLowerCase().contains(
                      (query.toLowerCase()),
                    ),
              )
              .toList();
        }
      } else {
        debugPrint("fetch error");
      }
    } on Exception catch (e) {
      debugPrint('error: $e');
    }
    return resultRecipes;
  }

  static Future<List<Recipe>> searchRecipeList(String query) async {
    var res = await Dio().get('${FlavorConfig.baseUrl}/recipes');

    if (res.statusCode == 200) {
      final List recipes = res.data.toList();

      return recipes.map((e) => Recipe.fromJson(e)).where((recipe) {
        final nameLower = recipe.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<Recipe>> searchRecipes() async {
    var res = await Dio().get('${FlavorConfig.baseUrl}/recipes');

    if (res.statusCode == 200) {

      final List recipes = res.data.toList();

      List<String> foundRecipes = [];


      List<dynamic> list = await SearchItem.searchIngredientsList();
      Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

      return recipes.map((e) => Recipe.fromJson(e)).where((recipe) {
        final ingredientsLower = recipe.ingredients;
        debugPrint('===================div==================');
        debugPrint(unOrdDeepEq(ingredientsLower, list));

        if (unOrdDeepEq(ingredientsLower, list)) {
          foundRecipes.add(recipe.name);
        }

        return unOrdDeepEq(ingredientsLower, list);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
