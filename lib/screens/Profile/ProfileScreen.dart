import 'package:TweetMe/models/Profile.dart';
import 'package:TweetMe/services/ProfileService.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile profile;
  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  void _fetchProfile() async {
    await ProfileService().get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: ProfileService().get(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text('something has error'),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                profile = snapshot.data;
                print(snapshot);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Card(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              width: 70.0,
                              height: 70.0,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://semantic-ui.com/images/avatar/large/elliot.jpg"),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '@asep.kuman',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.blue),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'asep.kuman@gmail.com',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (_, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://semantic-ui.com/images/avatar/large/elliot.jpg"),
                              ),
                              title: Text('some'),
                              subtitle: Text('sub'),
                            );
                          }),
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
