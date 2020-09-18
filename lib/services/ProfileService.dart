import 'dart:convert';
import 'dart:io';

import 'package:TweetMe/apis/ApiService.dart';
import 'package:TweetMe/models/Profile.dart';
import 'package:TweetMe/models/Tweet.dart';
import 'package:TweetMe/services/StorageService.dart';

class ProfileService {
  String _profileServiceEndpoint;

  ProfileService() {
    this._profileServiceEndpoint =
        ApiService().setMainPath("/tweets/dashboard");
  }

  Future<Profile> get() async {
    final tokenJwt = await StorageService().readToken();
    final response = await ApiService().client.get(_profileServiceEndpoint,
        headers: {HttpHeaders.authorizationHeader: "Bearer $tokenJwt"});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final profileDataResponse = jsonData['data'];

      final tweets = <Tweet>[];

      for (var singleTweet in profileDataResponse['tweets']) {
        final tweet = Tweet(
            avatarUser: jsonData['avatar'],
            username: jsonData['username'],
            createdAt: DateTime.parse(singleTweet['created_at']),
            tweet: singleTweet['tweet'],
            id: singleTweet['id']);
        tweets.add(tweet);
      }

      return Profile(
          avatar: jsonData['avatar'],
          username: jsonData['username'],
          email: jsonData['email'],
          tweets: tweets);
    }
  }
}
