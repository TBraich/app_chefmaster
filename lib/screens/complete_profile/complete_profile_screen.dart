import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/screens.complete_profile";

  @override
  Widget build(BuildContext context) {
    final SignUpArguments args =
    ModalRoute.of(context).settings.arguments as SignUpArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(args.email, args.password),
    );
  }
}

class SignUpArguments {
  final String email;
  final String password;

  SignUpArguments(this.email, this.password);
}
