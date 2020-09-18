import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
  hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  showLoading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
            child: Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 15.0,
              ),
              Text(
                'Loading',
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ));
      },
    );
  }
}
