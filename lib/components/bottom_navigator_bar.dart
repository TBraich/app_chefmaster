import 'package:flutter/material.dart';
import 'package:chefmaster_app/screens/add_recipe/add_recipe_screen.dart';
import 'package:chefmaster_app/screens/app_setting/setting_screen.dart';
import 'package:chefmaster_app/screens/fail_screen/faile_404_screen.dart';
import 'package:chefmaster_app/screens/home/home_screen.dart';
import 'package:chefmaster_app/screens/list_favorite_items/list_favorite_screen.dart';
import 'package:chefmaster_app/screens/profile_detail/ProfilePage.dart';
import 'package:chefmaster_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavScreen extends StatefulWidget {
  static String routeName = "/nav";

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  Fail404Screen fail404screen = new Fail404Screen();
  String userId;

  _BottomNavScreenState() {
    _getUserId();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = <Widget>[
      HomeScreen(),
      ListFavoriteScreen(),
      CreateNewRecipe(),
      ProfilePage(),
      SettingScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        items: [
          Icons.restaurant,
          Icons.favorite_border,
          Icons.add,
          Icons.person_outline,
          Icons.menu
        ]
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                    label: '',
                    icon: value == Icons.add
                        ? Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: _currentIndex == key
                                    ? kPrimaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    width: 2.5, color: kPrimaryColor)),
                            child: Icon(value))
                        : Container(
                            padding: value == Icons.add
                                ? EdgeInsets.all(10)
                                : EdgeInsets.symmetric(
                                    vertical: 6.0,
                                    horizontal: 16.0,
                                  ),
                            decoration: BoxDecoration(
                              color: _currentIndex == key
                                  ? kPrimaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Icon(value),
                          ),
                  ),
                ))
            .values
            .toList(),
      ),
    );
  }

  Future<void> _getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getString(PrefUserID);
    });
  }
}
