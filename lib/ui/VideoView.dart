import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String url;
  final bool play;

  VideoView({
    Key key,
    this.url,
    this.play,
  }) : super(key: key);

  @override
  _VideoViewState createState() => new _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    print(widget.url);
    super.initState();
    videoPlayerController = new VideoPlayerController.network(widget.url);
    videoPlayerController.setLooping(true);
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (widget.play) {
            videoPlayerController.play();
          } else {
            videoPlayerController.pause();
          }
          return Container(
            key: PageStorageKey(widget.url),
            child: VideoPlayer(videoPlayerController),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
