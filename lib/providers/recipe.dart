import 'dart:convert';

import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/utils/app_url.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeDetailProvider with ChangeNotifier {
  Future<Map<String, dynamic>> getRecipes(String param,
      {ListState state}) async {
    Map<String, dynamic> result;

    String url = AppUrl.getRecipes;
    url += param;

    Uri link = Uri.parse(url);

    Response response = await get(
      link,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      notifyListeners();

      final parsed =
          json.decode(utf8convert(response.body)).cast<String, dynamic>();

      Recipes data;

      switch (state) {
        case ListState.favorite:
          data = Recipes.fromJsonForFavorite(parsed);
          break;
        default:
          data = Recipes.fromJson(parsed);
          break;
      }

      result = {'status': true, 'recipes': data.recipes};
    } else {
      print(response);

      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(utf8convert(response.body))['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> getRecipeDetail(String recipeID) async {
    Map<String, dynamic> result;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = AppUrl.getRecipeDetail;
    url += "?recipeID=$recipeID&userID=${prefs.getString(PrefUserID)}";

    Uri link = Uri.parse(url);

    Response response = await get(
      link,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      notifyListeners();

      final parsed =
          json.decode(utf8convert(response.body)).cast<String, dynamic>();

      RecipeDetail data = RecipeDetail.fromJson(parsed);
      print('Data Recipe check: ${response.body}');

      result = {'status': true, 'recipe': data};
    } else {
      print(response);

      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(utf8convert(response.body))['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> createRecipes(String jsonBody) async {
    Map<String, dynamic> result;

    String url = AppUrl.createRecipe;

    Uri link = Uri.parse(url);

    Response response = await post(link,
        headers: {'Content-Type': 'application/json'}, body: jsonBody);

    if (response.statusCode == 200) {
      notifyListeners();

      final parsed =
          json.decode(utf8convert(response.body)).cast<String, dynamic>();

      // RecipeDetail data = RecipeDetail.fromJson(parsed);

      result = {'status': true};
    } else {
      print(response);

      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(utf8convert(response.body))['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> addFavorite(String recipeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> result;
    String url = AppUrl.setFavoriteRecipe;

    url += "?recipeID=$recipeId&userID=${prefs.getString(PrefUserID)}";
    Uri link = Uri.parse(url);

    Response response = await put(
      link,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      notifyListeners();
      result = {'status': true};
    } else {
      print(response);
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(utf8convert(response.body))['message']
      };
    }
    return result;
  }
}
