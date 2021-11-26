import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:chefmaster_app/mvvm/models/category.dart';
import 'package:chefmaster_app/mvvm/models/recipe_detail.dart';
import 'package:chefmaster_app/mvvm/models/upload_image.dart';
import 'package:chefmaster_app/mvvm/models/user.dart';
import 'package:chefmaster_app/utils/app_url.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:chefmaster_app/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

// enum Status {
//   NotLoggedIn,
//   NotRegistered,
//   LoggedIn,
//   Registered,
//   Authenticating,
//   Registering,
//   LoggedOut
// }

class AuthProvider with ChangeNotifier {
  Future<Map<String, dynamic>> login(
      String phoneNumber, String password) async {
    var result;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> loginData = {
      'phoneNumber': phoneNumber,
      'password': password
    };

    notifyListeners();

    Uri link = Uri.parse(AppUrl.login);

    Response response = await post(
      link,
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var dataResponse = jsonDecode(utf8convert(response.body));

      notifyListeners();

      prefs.setString(PrefAccessToken, dataResponse['accessToken']);

      saveDataUser(
          prefs: prefs,
          userId: dataResponse['userInfo']['userID'],
          userName: dataResponse['userInfo']['userName'],
          userSurname: dataResponse['userInfo']['userSurname'],
          email: dataResponse['userInfo']["email"],
          phoneNumber: dataResponse['userInfo']["phoneNumber"],
          address: dataResponse['userInfo']["address"],
          imageUrl: dataResponse['userInfo']['imageURL'],
          birthday: dataResponse['userInfo']['birthday']);

      result = {
        'status': true,
        'message': 'Successful',
        'accessToken': dataResponse['accessToken'],
        'tokenType': dataResponse['tokenType'],
        'userID': dataResponse['userInfo']['userID'],
      };
    } else {
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(utf8convert(response.body))['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
      String userName,
      String userSurname,
      String phoneNumber,
      String email,
      String password,
      String birthday,
      String address) async {
    var result;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> registrationData = {
      'userName': userName,
      'userSurname': userSurname,
      'role': '0',
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'birthday': int.parse(
          birthday.replaceAll("-", "").replaceAll(" 00:00:00.000", "")),
      'address': address,
      'imageUrl': 'https://www.computerhope.com/jargon/g/guest-user.jpg',
    };

    Uri link = Uri.parse(AppUrl.register);

    Response response = await post(
      link,
      body: json.encode(registrationData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var dataResponse = jsonDecode(utf8convert(response.body));

      notifyListeners();

      // save pref userID in app
      await prefs.setString(PrefUserID, dataResponse['userID']);

      saveDataUser(
          prefs: prefs,
          userId: dataResponse['userID'],
          userName: dataResponse['userName'],
          userSurname: dataResponse['userSurname'],
          email: dataResponse["email"],
          phoneNumber: dataResponse["phoneNumber"],
          address: dataResponse["address"],
          imageUrl: dataResponse['imageURL'],
          birthday: dataResponse['birthday']);
      result = {
        'status': true,
        'message': 'Successful',
        'userID': dataResponse['userID'],
        'phoneNumber': dataResponse['phoneNumber'],
        'userName': dataResponse['userName']
      };
    } else {
      notifyListeners();
      print(response.body);
      result = {
        'status': false,
        'message': json.decode(utf8convert(response.body))['message']
      };
      prefs.clear();
    }
    return result;
  }

  Future<Map<String, dynamic>> verifyOTP(String otp, String phoneNumber) async {
    var result;

    final Map<String, dynamic> verifyData = {
      'phoneNumber': phoneNumber,
      'otp': otp,
    };
    print("request: " + verifyData.toString());

    Uri link = Uri.parse(AppUrl.verifyOTP);

    Response response = await post(
      link,
      body: json.encode(verifyData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      notifyListeners();

      result = {'status': true, 'message': 'Successful'};
    } else {
      print(response);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();

      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(utf8convert(response.body))['message']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> resendOTP(String phoneNumber) async {
    var result;

    final Map<String, dynamic> verifyData = {
      'phoneNumber': phoneNumber,
    };
    print("request: " + verifyData.toString());

    Uri link = Uri.parse(AppUrl.resendOTP);

    Response response = await post(
      link,
      body: json.encode(verifyData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      notifyListeners();

      result = {'status': true, 'message': 'Successful'};
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

  Future<Map<String, dynamic>> getUserInfo() async {
    Map<String, dynamic> result;
    SharedPreferences pref = await SharedPreferences.getInstance();

    bool gotUserInfo = pref.getBool(PrefGotUserInfo);
    if (gotUserInfo) {
      result = {
        'status': true,
      };
    }

    String userId = pref.getString(PrefUserID);

    String url = AppUrl.getUserInfo;
    url += "?userID=$userId";

    Uri link = Uri.parse(url);

    Response response = await get(
      link,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      notifyListeners();

      var responseBody = json.decode(utf8convert(response.body));

      User user = User(
          userID: responseBody['userID'],
          userName: responseBody['userName'],
          userSurname: responseBody['userSurname'],
          email: responseBody["email"],
          phoneNumber: responseBody["phoneNumber"],
          address: responseBody["address"],
          imageUrl: responseBody['imageURL']);

      result = {'status': true, 'userInfo': user};
      pref.setBool(PrefGotUserInfo, true);
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

  Future<Map<String, dynamic>> getRecipes(String param, {ListState state}) async {
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

      print('====> response Body: ${response.body}');
      // print('====> recipeID from Recipes: ${data.recipes[0].recipeId}');

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

  Future<Map<String, dynamic>> postUploadUrl(String path) async {
    Map<String, dynamic> result;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = AppUrl.getUploadUrl;

    Uri link = Uri.parse(url);

    Response response = await post(
      link,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'pathFile': path}),
    );

    if (response.statusCode == 200) {
      notifyListeners();

      final parsed =
          json.decode(utf8convert(response.body)).cast<String, dynamic>();

      UploadImage data = UploadImage.fromJson(parsed);
      prefs.setString(PrefUserImageURL, data.downloadUrl);

      result = {
        'status': true,
        'uploadUrl': data.uploadUrl,
        'downloadUrl': data.downloadUrl
      };
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

  Future<Map<String, dynamic>> postUploadMultipleUrls(String jsonBody) async {
    Map<String, dynamic> result;
    String url = AppUrl.getMultipleUploadUrls;

    Uri link = Uri.parse(url);

    Response response = await post(
      link,
      headers: {'Content-Type': 'application/json'},
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      notifyListeners();

      final parsed =
          json.decode(utf8convert(response.body)).cast<String, dynamic>();

      UploadMultipleImages data = UploadMultipleImages.fromJson(parsed);

      print("BodyRequest: " + jsonBody);

      result = {
        'status': true,
        'data': data,
      };
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

  Future<Map<String, dynamic>> updateUserImage(
      String userId, String downloadUrl) async {
    Map<String, dynamic> result;
    String url = AppUrl.updateUserImage;

    Uri link = Uri.parse(url);

    Response response = await post(
      link,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userID': userId, "imageURL": downloadUrl}),
    );

    if (response.statusCode == 200) {
      result = {
        'status': true,
      };
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

  Future<Map<String, dynamic>> getCategories(String param) async {
    Map<String, dynamic> result;

    String url = AppUrl.getCategories;
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

      Categories data = Categories.fromJson(parsed);
      print('data: $data');

      result = {'status': true, 'categories': data.categories};
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

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
