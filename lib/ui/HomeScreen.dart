import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinkvilla_video_app_demo/model/Video.dart';
import 'package:pinkvilla_video_app_demo/ui/VideoView.dart';
import 'package:pinkvilla_video_app_demo/utils/Constants.dart';
import 'package:pinkvilla_video_app_demo/utils/ScreenUtil.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Video> _videoList = [];
  ScrollController _scrollController;
  double itemHeight;
  int firstVisibleItemIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    getVideoList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 1080, height: 2160, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      body: Container(
        width: ScreenUtil.screenWidthDp,
        height: ScreenUtil.screenHeightDp,
        child: ListView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            physics: PageScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _videoList.length,
            itemBuilder: (BuildContext context, int index) {
              Video video = _videoList.elementAt(index);
              itemHeight = ScreenUtil.screenHeightDp;
              return Container(
                width: ScreenUtil.screenWidthDp,
                height: itemHeight,
                key: new PageStorageKey(
                  "keydata$index",
                ),
                child: Stack(
                  children: <Widget>[
                    VideoView(
                      play: firstVisibleItemIndex == index ? true : false,
                      url: video.url,
                    ),
                    Positioned(
                      bottom: 20,
                      right: 100,
                      left: 20,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ClipOval(
                                  child: Image.network(
                                    video.user.headshot,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    video.user.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                video.title,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              child: Text(
                                video.likeCount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Image.asset(
                                'assets/arrow-forward.png',
                                color: Colors.white,
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Container(
                              child: Text(
                                video.shareCount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Icon(
                                Icons.comment,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              child: Text(
                                video.commentCount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  void getVideoList() async {
    try {
      final response = await http.get(
        URLConstants.API_VIDEO_FEED,
      );
      if (response.statusCode == 200) {
        List jsonVideoList = jsonDecode(response.body);
        setState(() {
          _videoList = jsonVideoList.map((i) => Video.fromJson(i)).toList();
        });
      }
    } catch (e) {
      setState(() {
        _videoList = [];
      });
      print("getVideoList Error : " + e.toString());
    }
  }

  void _scrollListener() {
    double scrollOffset = _scrollController.position.pixels;
    double viewportHeight = _scrollController.position.viewportDimension;
    double scrollRange = _scrollController.position.maxScrollExtent -
        _scrollController.position.minScrollExtent;
    setState(() {
      firstVisibleItemIndex =
          (scrollOffset / (scrollRange + viewportHeight) * _videoList.length)
              .floor();
    });
    print(firstVisibleItemIndex);
  }
}
