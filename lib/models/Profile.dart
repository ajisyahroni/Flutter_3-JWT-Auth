import 'package:TweetMe/models/Tweet.dart';

class Profile {
  String email;
  String avatar;
  String username;
  List<Tweet> tweets;

  Profile({this.avatar, this.email, this.username, this.tweets});
}
