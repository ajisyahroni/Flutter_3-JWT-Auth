import 'package:TweetMe/models/Tweet.dart';
import 'package:TweetMe/screens/Dashboard/widgets/NewTweet.dart';
import 'package:TweetMe/screens/Dashboard/widgets/TweetList.dart';
import 'package:TweetMe/services/TweetService.dart';
import 'package:TweetMe/widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Tweet> tweets = [];
  @override
  void initState() {
    super.initState();
    // _fetchTweet();
  }

  void _fetchTweet() async {
    tweets = await TweetService().all();
  }

  String formatDate(DateTime date) {
    return DateFormat.jm().add_yMMMd().format(date);
  }

  void goToProfile(BuildContext context) {
    Navigator.pushNamed(context, 'Profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TweetMe'),
          actions: [
            IconButton(
              icon: Icon(Icons.person_pin),
              onPressed: () {
                // bind goto profile
                goToProfile(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              NewTweet(
                submitHandler: (val) async {
                  // begin transaction to create tweet
                  Loading().showLoading(context);
                  bool onCreateSuccess = await TweetService().create(val);
                  Loading().hideLoading(context);
                  // end

                  // if success
                  if (onCreateSuccess == true) {
                    await TweetService().all();
                    setState(() {});
                  }
                },
              ),
              Container(
                  height: 500,
                  child: SafeArea(
                      child: FutureBuilder(
                    future: TweetService().all(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Tweet>> snapshot) {
                      if (snapshot.hasError) {
                        // log error
                        print(snapshot.error);
                        return Center(
                          child: Text('something has error'),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        tweets = snapshot.data;
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              itemCount: tweets.length,
                              itemBuilder: (_, index) {
                                return TweetList(
                                  tweet: tweets[index].tweet,
                                  dateTime: formatDate(tweets[index].createdAt),
                                  username: '@${tweets[index].username}',
                                  avatar: tweets[index].avatarUser,
                                );
                              }),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )))
            ],
          ),
        ));
  }
}
