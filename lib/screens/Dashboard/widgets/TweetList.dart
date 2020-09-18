import 'package:flutter/material.dart';

class TweetList extends StatelessWidget {
  final String tweet;
  final String username;
  final String dateTime;
  final String avatar;
  TweetList({this.tweet, this.dateTime, this.username, this.avatar});

  Widget _buildGap() {
    return SizedBox(
      width: 5.0,
    );
  }

  Widget _buildAvatar(String avatar) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: 50.0,
      height: 50.0,
      child: CircleAvatar(
        // bind avatar
        backgroundImage: NetworkImage(avatar),
      ),
    );
  }

  Widget _buildTweets(String tweet, String dateTime) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 300,
                child: Text(
                  // bind tweet
                  tweet,
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            // bind username
            username,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            // bind datetime
            dateTime,
            style: TextStyle(color: Colors.grey),
          ),
          // RaisedButton.icon(
          //     onPressed: null,
          //     icon: Icon(
          //       Icons.favorite,
          //       color: Colors.pinkAccent[100],
          //     ),
          //     label: Text(
          //       '12',
          //       textAlign: TextAlign.start,
          //     ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Wrap(
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /**
               * ==========================
               * ROW pertama
               * ==========================
               *  */
                  _buildAvatar(avatar),

                  // =====================
                  _buildGap(),
                  // =====================

                  /**
               * ==========================
               * ROW kedua
               * ==========================
               *  */
                  _buildTweets(tweet, dateTime)
                ],
              ),
            )
          ],
        ));
  }
}
