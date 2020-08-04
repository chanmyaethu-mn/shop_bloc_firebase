import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loading;
    if (Platform.isAndroid) {
      loading = Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
        color: Colors.transparent
      );
    } else if (Platform.isIOS) {
      loading = Container(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return loading;
  }
}
