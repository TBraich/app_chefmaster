import 'package:flutter/material.dart';
import 'package:chefmaster_app/components/custom_bottom_nav_bar.dart';
import 'package:chefmaster_app/screens/list_items/components/Body.dart';
import 'package:chefmaster_app/utils/enums.dart';
import 'package:chefmaster_app/utils/size_config.dart';

class ListItemsScreen extends StatelessWidget {
  static String routeName = "/screens.list";
  ItemsArguments arguments;

  ListItemsScreen({this.arguments});

  @override
  Widget build(BuildContext context) {
    if (this.arguments == null) {
      this.arguments = ModalRoute.of(context).settings.arguments as ItemsArguments;
    }
    return Scaffold(
      appBar: arguments.state==ListState.name?null:AppBar(
        title: Text(
          arguments.name,
          style: TextStyle(
              // color: Colors.black,
              fontSize: getProportionateScreenWidth(24),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Body(state: arguments.state, requestParam: arguments.param),
      // bottomNavigationBar: arguments.state == ListState.favorite
      //     ? CustomBottomNavBar(selectedMenu: MenuState.favourite)
      //     : null,
    );
  }
}

class ItemsArguments {
  final String name;
  final ListState state;
  final String param;

  ItemsArguments(this.name, this.state, this.param);
}
