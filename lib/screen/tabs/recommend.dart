import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_movie/constants.dart';
import 'package:x_movie/screen/video_play.dart';
import 'package:x_movie/util.dart';

const statusBarStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  statusBarIconBrightness: Brightness.dark,
);

class Recommend extends StatefulWidget {
  const Recommend({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Recommend();
  }
}

class _Recommend extends State<Recommend> {
  @override
  Widget build(BuildContext context) {
    Util.setStatusBarTextColor(statusBarStyle);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOT',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.2,
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.search,
                color: Colors.black54,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => RecommendItem(),
        itemCount: 20,
      ),
    );
  }
}

class RecommendItem extends StatelessWidget {
  const RecommendItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => VideoPaly()))
            .then((value) {
          Timer(const Duration(milliseconds: 300), () {
            Util.setStatusBarTextColor(statusBarStyle);
          });
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
              height: Util.screenWidth(context) * 0.44,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://img0.baidu.com/it/u=3544693497,3993142312&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                width: Util.screenWidth(context),
                color: const Color.fromRGBO(0, 0, 0, 0.2),
                child: const Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 6),
                          SizedBox(
                            width: 200,
                            child: Text(
                              '星际穿越',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '类型：科幻',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black38),
                          )
                        ],
                      ),
                      const Text(
                        '9.8',
                        style: TextStyle(
                          color: xPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      '《星际穿越》是2014年美英联合制作的科幻电影。该片由克里斯托弗·诺兰执导，马修·麦康纳、安妮·海瑟薇领衔主演。该片在物理学家基普·索恩的黑洞理论之上进行改编，主要讲述了一组宇航员通过穿越虫洞来为人类寻找新家园的冒险故事。该片于2014年11月5日在美国公映，11月7日在英国公映，11月12日在中国大陆公映。并于2020年8月2日在中国大陆重映。',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
