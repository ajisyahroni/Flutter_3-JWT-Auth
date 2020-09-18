import 'dart:convert';
import 'dart:io';

import 'package:TweetMe/apis/ApiService.dart';
import 'package:TweetMe/models/Tweet.dart';
import 'package:TweetMe/services/StorageService.dart';

class TweetService {
  String _tweetServiceEndpoint;
  TweetService() {
    this._tweetServiceEndpoint = ApiService().setMainPath("/tweets");
  }

  String setPath(String path) {
    return _tweetServiceEndpoint + path;
  }

  Future<bool> create(String tweetText) async {
    final createTweetPath = setPath("/create");
    final tokenJwt = await StorageService().readToken();

    print(tokenJwt);
    print(tweetText);
    final response = await ApiService().client.post(createTweetPath,
        headers: {HttpHeaders.authorizationHeader: "Bearer $tokenJwt"},
        body: {"tweet": tweetText});

    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      return jsonData['success'];
    }
  }

  Future<List<Tweet>> all() async {
    // this will create API_URL/tweets/all
    final allTweetPath = setPath("/all");
    final response = await ApiService().client.get(allTweetPath);

    if (response.statusCode == 200) {
      print('fired');

      final responseBody = json.decode(response.body);
      final tweetDataResponse = responseBody['data'];

      List<Tweet> tweets = (tweetDataResponse as List<dynamic>)
          .map((dynamic item) => Tweet.fromJson(item))
          .toList();

      return tweets;

      // for (var singleTweet in tweetDataResponse) {
      //   final tweet = Tweet(
      //       id: singleTweet['id'],
      //       tweet: singleTweet['tweet'],
      //       username: singleTweet['user']['username'],
      //       avatarUser: singleTweet['user']['avatar'],
      //       createdAt: DateTime.parse(singleTweet['created_at']));
      //   tweets.add(tweet);
      // }
      // return tweets;
    }
  }
}
