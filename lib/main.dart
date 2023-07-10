import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_svg/svg.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatefulWidget {
  @override
  _RecipeAppState createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    // Parse the JSON data and update the recipes list
    String jsonData = '''
      {
        "recipes": [
          {
            "title": "Pasta Carbonara",
            "description": "Creamy pasta dish with bacon and cheese.",
            "ingredients": ["spaghetti", "bacon", "egg", "cheese"]
          },
          {
            "title": "Caprese Salad",
            "description": "Simple and refreshing salad with tomatoes, mozzarella, and basil.",
            "ingredients": ["tomatoes", "mozzarella", "basil"]
          },
          {
            "title": "Banana Smoothie",
            "description": "Healthy and creamy smoothie with bananas and milk.",
            "ingredients": ["bananas", "milk"]
          },
          {
            "title": "Chicken Stir-Fry",
            "description": "Quick and flavorful stir-fried chicken with vegetables.",
            "ingredients": ["chicken breast", "broccoli", "carrot", "soy sauce"]
          },
          {
            "title": "Grilled Salmon",
            "description": "Delicious grilled salmon with lemon and herbs.",
            "ingredients": ["salmon fillet", "lemon", "olive oil", "dill"]
          },
          {
            "title": "Vegetable Curry",
            "description": "Spicy and aromatic vegetable curry.",
            "ingredients": ["mixed vegetables", "coconut milk", "curry powder"]
          },
          {
            "title": "Berry Parfait",
            "description": "Layered dessert with fresh berries and yogurt.",
            "ingredients": ["berries", "yogurt", "granola"]
          }
        ]
      }
    ''';

    Map<String, dynamic> jsonMap = json.decode(jsonData);
    List<dynamic> recipeList = jsonMap['recipes'];

    recipes = recipeList.map((json) => Recipe.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food Recipes'),
        ),
        body: Stack(
          children: [
            backscreen(context),
            Container(
               child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(recipes[index].title),
              subtitle: Text(recipes[index].description),
              leading: Icon(Icons.no_food),
            );
          },
        ),
            )
          ],
        ),
      ),
    );
  }
}

class Recipe {
  final String title;
  final String description;
  final List<String> ingredients;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }
}


SvgPicture backscreen(context){
  return SvgPicture.asset('assets/img.svg',
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height:MediaQuery.of(context).size.height ,
    fit: BoxFit.cover,
  );
}