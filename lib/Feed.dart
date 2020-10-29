import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagramClone/Services/ImageServices.dart';
import 'package:instagramClone/storyScreen.dart';

import 'Models/Post.dart';
import 'Models/Stories.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final List<Story> _stories = [
    Story(
        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Jazmin"),
    Story(
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Sylvester"),
    Story(
        "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Lavina"),
    Story(
        "https://images.pexels.com/photos/1124724/pexels-photo-1124724.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Mckenzie"),
    Story(
        "https://images.pexels.com/photos/1845534/pexels-photo-1845534.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Buster"),
    Story(
        "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Carlie"),
    Story(
        "https://images.pexels.com/photos/762020/pexels-photo-762020.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Edison"),
    Story(
        "https://images.pexels.com/photos/573299/pexels-photo-573299.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Flossie"),
    Story(
        "https://images.pexels.com/photos/756453/pexels-photo-756453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Lindsey"),
    Story(
        "https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Freddy"),
    Story(
        "https://images.pexels.com/photos/1832959/pexels-photo-1832959.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "Litzy")
  ];

  final List<Post> posts = [
    Post(
        username: "Manish",
        userImage:
            "https://scontent.fktm12-1.fna.fbcdn.net/v/t1.0-9/65054143_447907485995580_1591014207522865152_o.jpg?_nc_cat=104&ccb=2&_nc_sid=09cbfe&_nc_ohc=siTRagKc8ycAX879zwL&_nc_ht=scontent.fktm12-1.fna&oh=d251d6cb4891dc7d9494ee7307b1fa83&oe=5FBE98E1",
        postImage:
            "https://www.plannthat.com/wp-content/uploads/2017/10/brahmino.png",
        caption: "Nature is Beautiful. Exploring it.."),
    Post(
        username: "Henri",
        userImage:
            "https://s3.amazonaws.com/uifaces/faces/twitter/kevka/128.jpg",
        postImage:
            "https://i.pinimg.com/originals/f8/c5/84/f8c584d89cd2af9ca2e155232a86de6b.png",
        caption: "I love peace."),
    Post(
        username: "Mariano",
        userImage:
            "https://s3.amazonaws.com/uifaces/faces/twitter/ionuss/128.jpg",
        postImage:
            "https://thumbs.dreamstime.com/b/desktop-source-code-technology-background-developer-programer-coding-programming-wallpaper-computer-language-virus-124934719.jpg",
        caption: "Consequatur nihil aliquid omnis consequatur."),
    Post(
        username: "Johan",
        userImage:
            "https://s3.amazonaws.com/uifaces/faces/twitter/vinciarts/128.jpg",
        postImage:
            "https://images.pexels.com/photos/1536619/pexels-photo-1536619.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."),
    Post(
        username: "London",
        userImage:
            "https://s3.amazonaws.com/uifaces/faces/twitter/ssiskind/128.jpg",
        postImage:
            "https://images.pexels.com/photos/247298/pexels-photo-247298.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."),
    Post(
        username: "Jada",
        userImage:
            "https://s3.amazonaws.com/uifaces/faces/twitter/areus/128.jpg",
        postImage:
            "https://images.pexels.com/photos/169191/pexels-photo-169191.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."),
    Post(
        username: "Crawford",
        userImage:
            "https://s3.amazonaws.com/uifaces/faces/twitter/oskarlevinson/128.jpg",
        postImage:
            "https://images.pexels.com/photos/1252983/pexels-photo-1252983.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        caption: "Consequatur nihil aliquid omnis consequatur."),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            TopText(),
            Stories(stories: _stories),

            // posts
            PostsWidget(posts: posts),
          ],
        ),
      ),
    );
  }
}

class PostsWidget extends StatelessWidget {
  const PostsWidget({
    Key key,
    @required this.posts,
  }) : super(key: key);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (ctx, i) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image(
                              image: NetworkImage(posts[i].userImage),
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(posts[i].username),
                        ],
                      ),
                      IconButton(
                        icon: Icon(SimpleLineIcons.options),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                FadeInImage(
                  image: NetworkImage(posts[i].postImage),
                  placeholder: AssetImage(
                    "assets/images/placeholder.png",
                  ),
                  width: MediaQuery.of(context).size.width,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesome.heart_o),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesome.comment_o),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(FontAwesome.send_o),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesome.bookmark_o),
                    ),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: RichText(
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Liked By ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: "Sigmund,",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: " Yessenia,",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: " Dayana",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: " and",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " 1263 others",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                // caption
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  child: RichText(
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: posts[i].username,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: " ${posts[i].caption}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                // post date
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Febuary 2020",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Stories extends StatelessWidget {
  Stories({
    Key key,
    @required List<Story> stories,
  })  : _stories = stories,
        super(key: key);

  final List<Story> _stories;

  final ImageServices imageUploadService = ImageServices();

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        left: 8,
        top: 8,
      ),
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 4),
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(user.uid)
                          .collection("Stories")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        snapshot.data.docs.map((element) {
                          print(element['imageUrl']);
                        });

                        return GestureDetector(
                          onTap: () {
                            if (snapshot.data.docs.length == 0) {
                              imageUploadService.uploadImage(context);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoryScreen(
                                    uid: FirebaseAuth.instance.currentUser.uid,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 68,
                            height: 68,
                            child: snapshot.data.docs.length == 0
                                ? Stack(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: FutureBuilder<DocumentSnapshot>(
                                            future: FirebaseFirestore.instance
                                                .collection("Users")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser.uid)
                                                .get(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return Container(
                                                  width: 65,
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey,
                                                  ),
                                                );
                                              }

                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container(
                                                  width: 65,
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey,
                                                  ),
                                                );
                                              }

                                              return Container(
                                                width: 65,
                                                height: 65,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  // color: Colors.green,
                                                  image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data['profileImage']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                      Positioned(
                                        bottom: 4,
                                        right: 4,
                                        child: Container(
                                          width: 19,
                                          height: 19,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,
                                          ),
                                          child: Icon(
                                            Feather.plus,
                                            color: Colors.white,
                                            size: 19,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    width: 68,
                                    height: 68,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF9B2282),
                                          Color(0xFFEEA863)
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: FutureBuilder<DocumentSnapshot>(
                                          future: FirebaseFirestore.instance
                                              .collection("Users")
                                              .doc(FirebaseAuth
                                                  .instance.currentUser.uid)
                                              .get(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return Container(
                                                width: 65,
                                                height: 65,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                ),
                                              );
                                            }

                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Container(
                                                width: 65,
                                                height: 65,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                ),
                                              );
                                            }

                                            return Container(
                                              width: 65,
                                              height: 65,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(snapshot
                                                      .data['profileImage']),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Your Story"),
                ],
              ),
            ),
            ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: _stories.map((story) {
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF9B2282), Color(0xFFEEA863)],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(story.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(story.name),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class TopText extends StatelessWidget {
  const TopText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Stories",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            "Watch All",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
