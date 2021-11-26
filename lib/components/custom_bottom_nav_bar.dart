import 'package:flutter/material.dart';
import 'package:chefmaster_app/mvvm/views/add_recipe/add_recipe_screen.dart';
import 'package:chefmaster_app/mvvm/views/app_setting/setting_screen.dart';
import 'package:chefmaster_app/mvvm/views/home/home_screen.dart';
import 'package:chefmaster_app/mvvm/views/list_items/list_items_screen.dart';
import 'package:chefmaster_app/mvvm/views/profile_detail/ProfilePage.dart';
import 'package:chefmaster_app/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class CustomBottomNavBar extends StatefulWidget {
  final MenuState selectedMenu;

  const CustomBottomNavBar({Key key, this.selectedMenu}) : super(key: key);

  @override
  _CustomBottomNavBarState createState() =>
      _CustomBottomNavBarState(selectedMenu);
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final MenuState selectedMenu;

  _CustomBottomNavBarState(this.selectedMenu);

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.restaurant,
                    size: 28,
                    color: MenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () {
                    selectedMenu == MenuState.home
                        ? Navigator.pushNamed(context, HomeScreen.routeName)
                        : Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
                  }),
              IconButton(
                icon: Icon(Icons.favorite_border,
                  size: 28,
                  color: MenuState.favourite == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  Navigator.pushNamed(context, ListItemsScreen.routeName,
                      arguments: ItemsArguments(
                          "Favorite Recipes",
                          ListState.favorite,
                          "?userID=${pref.getString(PrefUserID).toString()}"));
                },
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, CreateNewRecipe.routeName);
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.person_outline,
                  size: 28,
                  color: MenuState.profile == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfilePage.routeName),
              ),
              IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 28,
                  color: MenuState.setting == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, SettingScreen.routeName);
                },
              ),
            ],
          )),
    );
  }
}
