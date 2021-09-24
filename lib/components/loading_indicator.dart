import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.transparent,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
            ]
        )
    );
  }
}

Widget _getLoadingIndicator() {
  return Padding(
      child: Container(
          child: CircularProgressIndicator(),
          width: 32,
          height: 32
      ),
      padding: EdgeInsets.only(bottom: 16)
  );
}
