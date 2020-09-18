import 'package:flutter/material.dart';

class NewTweet extends StatelessWidget {
  final _tweetInputController = TextEditingController();

  final Function submitHandler;
  NewTweet({this.submitHandler});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _tweetInputController,
            maxLines: 3,
            decoration: InputDecoration(hintText: 'apa yang anda pikirkan ?'),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton.icon(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.blue,
            label: Text(
              'Tweet',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              submitHandler(_tweetInputController.text);
            },
          )
        ],
      ),
    ));
  }
}
