import 'dart:convert';

import 'package:chefmaster_app/utils/app_url.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostProvider with ChangeNotifier {
  void upvote(String recipeId, bool isUpvote) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> requestBody = {
      'recipeID': recipeId,
      'userID': prefs.getString(PrefUserID),
      'userName': prefs.getString(PrefUserName),
      'isUpvote': isUpvote,
    };
    // notifyListeners();
    Uri link = Uri.parse(AppUrl.postUpvote);

    Response response = await post(
      link,
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      Fluttertoast.showToast(
          msg: "Comment failed: " +
              json.decode(utf8convert(response.body))['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  void comment(String recipeId, String comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> requestBody = {
      'recipeID': recipeId,
      'userID': prefs.getString(PrefUserID),
      'content': comment,
    };
    // notifyListeners();
    Uri link = Uri.parse(AppUrl.postComment);

    Response response = await post(
      link,
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      Fluttertoast.showToast(
          msg: "Comment failed: " +
              json.decode(utf8convert(response.body))['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
  }

  Future<Response> postStatus(String recipeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // notifyListeners();
    String url = AppUrl.postStatus;
    url += "?recipeID=$recipeId&userID=${prefs.getString(PrefUserID)}";
    Uri link = Uri.parse(url);

    Response response = await get(
      link,
      headers: {'Content-Type': 'application/json'},
    );


    return response;
  }
}
