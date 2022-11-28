import 'package:flutter/material.dart';

import 'package:recipe_app/routes/api_connection.dart';
import 'package:recipe_app/search/search_recipe.dart';
import 'package:recipe_app/models/recipe_model.dart';



class FoundRecipes extends StatefulWidget {

  //final Stream<List<Recipe>> stream;

  const FoundRecipes({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FoundRecipesState createState() => _FoundRecipesState();
}

class _FoundRecipesState extends State<FoundRecipes> {

  bool showTextField = false;

  final FetchRecipeList _recipeList = FetchRecipeList();
  
  //get displayRecipeList async => mySetState(await _recipeList.getRecipeList());


  // @override
  // void initState(){
  //   super.initState();
  //   widget.stream.listen((index) { 
  //     mySetState(index);
  //   });
  // }

  // void mySetState(List<Recipe> index) async{
  //   List<Recipe> displayRecipeList = await _recipeList.getRecipeList();
  //   setState(() {
  //     displayRecipeList = index;
  //   });
  // }

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
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: SearchRecipe()),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
                future: _recipeList.getRecipeList(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  return snapshot.connectionState == ConnectionState.waiting
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: data?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: ListTile(
                                title: Text(
                                  Recipe.formatCase('${data?[index].name}'),
                                ),
                                onTap: () {
                                  debugPrint(
                                      'Recipe ${(data?[index].name)} selected');
                                  //SearchUser.searchIngredientsList(value : data?[index].name);
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
