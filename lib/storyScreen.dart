import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  final String uid;

  const StoryScreen({@required this.uid});

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animController;
  VideoPlayerController _videoController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    // final Story firstStory = widget.stories.first;
    // _loadStory(story: firstStory, animateToPage: false);

    // // _animController.addStatusListener((status) {
    // //   if (status == AnimationStatus.completed) {
    // //     _animController.stop();
    // //     _animController.reset();
    // //     setState(() {
    // //       if (_currentIndex + 1 < widget.stories.length) {
    // //         _currentIndex += 1;
    // //         _loadStory(story: widget.stories[_currentIndex]);
    // //       } else {
    // //         // Out of bounds - loop story
    // //         // You can also Navigator.of(context).pop() here
    // //         _currentIndex = 0;
    // //         _loadStory(story: widget.stories[_currentIndex]);
    // //       }
    // //     });
    // }
    // });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {},
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(widget.uid)
              .collection("Stories")
              .orderBy(
                "createdDate",
                descending: true,
              )
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went Wrong"),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return SafeArea(
              child: Column(
                children: [
                  Positioned(
                    top: 40.0,
                    left: 10.0,
                    right: 10.0,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: snapshot.data.docs
                              .asMap()
                              .map((i, e) {
                                return MapEntry(
                                  i,
                                  AnimatedBar(
                                    animController: _animController,
                                    position: i,
                                    currentIndex: _currentIndex,
                                  ),
                                );
                              })
                              .values
                              .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 1.5,
                            vertical: 10.0,
                          ),
                          child: UserInfo(uid: widget.uid),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.018,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: PageView.builder(
                      controller: _pageController,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          child: Container(
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data.docs[i]['storyLink'],
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Send Message",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            FontAwesome.send_o,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
//   }
//   final Story story = widget.stories[_currentIndex];
//   return Scaffold(
//     backgroundColor: Colors.black,
//     body: GestureDetector(
//       onTapDown: (details) => _onTapDown(details, story),
//       child: Stack(
//         children: <Widget>[
//           PageView.builder(
//             controller: _pageController,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: widget.stories.length,
//             itemBuilder: (context, i) {
//               final Story story = widget.stories[i];
//               switch (story.media) {
//                 case MediaType.image:
//                   return CachedNetworkImage(
//                     imageUrl: story.url,
//                     fit: BoxFit.cover,
//                   );
//                 case MediaType.video:
//                   if (_videoController != null &&
//                       _videoController.value.initialized) {
//                     return FittedBox(
//                       fit: BoxFit.cover,
//                       child: SizedBox(
//                         width: _videoController.value.size.width,
//                         height: _videoController.value.size.height,
//                         child: VideoPlayer(_videoController),
//                       ),
//                     );
//                   }
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//           Positioned(
//             top: 40.0,
//             left: 10.0,
//             right: 10.0,
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   children: widget.stories
//                       .asMap()
//                       .map((i, e) {
//                         return MapEntry(
//                           i,
//                           AnimatedBar(
//                             animController: _animController,
//                             position: i,
//                             currentIndex: _currentIndex,
//                           ),
//                         );
//                       })
//                       .values
//                       .toList(),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 1.5,
//                     vertical: 10.0,
//                   ),
//                   child: UserInfo(user: story.user),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

//   void _onTapDown(TapDownDetails details, Story story) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double dx = details.globalPosition.dx;
//     if (dx < screenWidth / 3) {
//       setState(() {
//         if (_currentIndex - 1 >= 0) {
//           _currentIndex -= 1;
//           _loadStory(story: widget.stories[_currentIndex]);
//         }
//       });
//     } else if (dx > 2 * screenWidth / 3) {
//       setState(() {
//         if (_currentIndex + 1 < widget.stories.length) {
//           _currentIndex += 1;
//           _loadStory(story: widget.stories[_currentIndex]);
//         } else {
//           // Out of bounds - loop story
//           // You can also Navigator.of(context).pop() here
//           _currentIndex = 0;
//           _loadStory(story: widget.stories[_currentIndex]);
//         }
//       });
//     } else {
//       if (story.media == MediaType.video) {
//         if (_videoController.value.isPlaying) {
//           _videoController.pause();
//           _animController.stop();
//         } else {
//           _videoController.play();
//           _animController.forward();
//         }
//       }
//     }
//   }

//   void _loadStory({Story story, bool animateToPage = true}) {
//     _animController.stop();
//     _animController.reset();
//     switch (story.media) {
//       case MediaType.image:
//         _animController.duration = story.duration;
//         _animController.forward();
//         break;
//       case MediaType.video:
//         _videoController = null;
//         _videoController?.dispose();
//         _videoController = VideoPlayerController.network(story.url)
//           ..initialize().then((_) {
//             setState(() {});
//             if (_videoController.value.initialized) {
//               _animController.duration = _videoController.value.duration;
//               _videoController.play();
//               _animController.forward();
//             }
//           });
//         break;
//     }
//     if (animateToPage) {
//       _pageController.animateToPage(
//         _currentIndex,
//         duration: const Duration(milliseconds: 1),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
// }

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    Key key,
    @required this.animController,
    @required this.position,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final String uid;
  UserInfo({
    @required this.uid,
  });
  @override
  Widget build(BuildContext context) {
    print(uid);
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("Users").doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey[300],
                  // backgroundImage: CachedNetworkImageProvider(""),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    "username",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey[300],
                  // backgroundImage: CachedNetworkImageProvider(""),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    " ",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          }

          return Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[300],
                backgroundImage:
                    CachedNetworkImageProvider(snapshot.data['profileImage']),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  snapshot.data['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_vert,
                  size: 30.0,
                  color: Colors.white,
                ),
                // onPressed: () => Navigator.of(context).pop(),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        backgroundColor: Colors.white,
                        content: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.height * 0.05,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Delete the image from here
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "Report",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                "Copy link",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        });
  }
}
