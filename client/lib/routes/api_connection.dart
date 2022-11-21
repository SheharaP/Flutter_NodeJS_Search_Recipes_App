import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/models/ingredient_model.dart';
import 'package:recipe_app/search/search_ingredient.dart';

class FetchItemList {
  var data = [];
  List<ItemList> results = [];
  static String urlItemList = 'http://192.168.213.179:8080/items/';

  Future<List<ItemList>> getItemList({String? query}) async {
    try {

      var response = await Dio().get(urlItemList);

      if (response.statusCode == 200) {

        data = response.data.toList();

        print(data);

        results = data.map((e) => ItemList.fromJson(e)).toList();

        if (query != null) {
          results = results
              .where(
                (element) => element.name.toLowerCase().contains(
                      (query.toLowerCase()),
                    ),
              )
              .toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }

  List<String> categoryResult = [];
  var categoryData = [];

    Future<List<String>> getCategoryList({String? query}) async {
    try {

      var response = await Dio().get(urlItemList);

      if (response.statusCode == 200) {

        categoryData = response.data.category.toList();

        print(categoryData);

        categoryResult = categoryData.map((e) => ItemList.fromJson(e)).cast<String>().toList();

        // if (query != null) {
        //   categoryResult = categoryResult
        //       .where(
        //         (element) => element.name.toLowerCase().contains(
        //               (query.toLowerCase()),
        //             ),
        //       )
        //       .toList();
        // }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return categoryResult;
  }

  static Future<List<ItemList>> searchItemList(String query) async {

    var res = await Dio().get(urlItemList);

    if (res.statusCode == 200) {

      final List items = res.data.toList();
      print(items);

      return items.map((e) => ItemList.fromJson(e)).where((item) {
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
  List<RecipeList> resultRecipes = [];

  static String urlRecipeList = 'http://192.168.213.179:8080/recipes/';

  Future<List<RecipeList>> getRecipeList({String? query}) async {
    try {

      var response = await Dio().get(urlRecipeList);

      if (response.statusCode == 200) {

        data = response.data.toList();
        print(data);

        resultRecipes = data.map((e) => RecipeList.fromJson(e)).toList();

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
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return resultRecipes;
  }

  static Future<List<RecipeList>> searchRecipeList(String query) async {
    
    var res = await Dio().get(urlRecipeList);

    if (res.statusCode == 200) {
      final List recipes = res.data.toList();
      print(recipes);

      return recipes.map((e) => RecipeList.fromJson(e)).where((recipe) {
        final nameLower = recipe.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<RecipeList>> searchRecipes() async {

    var res = await http.get(Uri.parse(urlRecipeList));

    if (res.statusCode == 200) {

      //Future<List<String?>> query =  SearchUser.searchIngredientsList();

      final List recipes = json.decode(res.body);

      List<String> foundRecipes = [];
      //print(recipes);
      
      List<dynamic> list = await SearchItem.searchIngredientsList() ;

      return recipes.map((e) => RecipeList.fromJson(e)).where((recipe) {

        final ingredientsLower = recipe.ingredients;
        print('===================div==================');
        print(ingredientsLower);
        print(list);

        Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
        print(unOrdDeepEq(ingredientsLower, list)); 
        
        if(unOrdDeepEq(ingredientsLower, list)){
          foundRecipes.add(recipe.name);
        }
        print(foundRecipes);
        
        return unOrdDeepEq(ingredientsLower, list);

      }).toList();
    } else {
      throw Exception();
    }
  }
}
