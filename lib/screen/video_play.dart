import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:x_movie/util.dart';

class VideoPaly extends StatefulWidget {
  const VideoPaly({super.key});

  @override
  State<StatefulWidget> createState() {
    return _VideoPlay();
  }
}

class _VideoPlay extends State<VideoPaly> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();

    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(
            'https://dy2.yle888.vip/20220623/auUqoqRk/index.m3u8'));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: Util.screenWidth(context) * 9 / 16,
                color: Colors.black87,
                child: FlickVideoPlayer(flickManager: flickManager),
              ),
              Positioned(
                left: 20,
                top: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
