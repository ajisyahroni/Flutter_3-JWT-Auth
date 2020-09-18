import 'dart:convert';

import 'package:flutter/foundation.dart';

class Tweet {
  int id;
  String tweet;
  String username;
  String avatarUser;
  DateTime createdAt;

  Tweet(
      {@required this.id,
      @required this.tweet,
      @required this.avatarUser,
      @required this.username,
      @required this.createdAt});

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return Tweet(
        id: json['id'] as int,
        tweet: json['tweet'] as String,
        username: json['user']['username'] as String,
        avatarUser: json['user']['avatar'] as String,
        createdAt: DateTime.parse(json['created_at']));
  }
}
