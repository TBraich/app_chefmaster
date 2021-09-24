import 'package:flutter/material.dart';
import 'package:chefmaster_app/screens/list_items/components/Body.dart';
import 'package:chefmaster_app/utils/enums.dart';
import 'package:chefmaster_app/utils/size_config.dart';


class ListItemsScreen extends StatelessWidget {
  static String routeName = "/screens.favorite_list";
  @override
  Widget build(BuildContext context) {
    final ItemsArguments itemsArgs =
    ModalRoute.of(context).settings.arguments as ItemsArguments;
    print(itemsArgs.param);
    return Scaffold(
      appBar: AppBar(
        title:Text(
          itemsArgs.name,
          style: TextStyle(
              // color: Colors.black,
              fontSize: getProportionateScreenWidth(24),
          fontWeight: FontWeight.bold),
        ),
      ),
      body: Body(state: itemsArgs.state, requestParam: itemsArgs.param),
    );
  }
}

class ItemsArguments {
  final String name;
  final ListState state;
  final String param;

  ItemsArguments(this.name, this.state, this.param);
}