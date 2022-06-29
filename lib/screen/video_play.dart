import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:x_movie/constants.dart';
import 'package:x_movie/util.dart';

class VideoPaly extends StatefulWidget {
  const VideoPaly({super.key});

  @override
  State<StatefulWidget> createState() {
    return _VideoPlay();
  }
}

class _VideoPlay extends State<VideoPaly> with TickerProviderStateMixin {
  late FlickManager flickManager;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    flickManager = FlickManager(
      autoPlay: false,
      videoPlayerController: VideoPlayerController.network(
        'https://dy2.yle888.vip/20220623/auUqoqRk/index.m3u8',
        formatHint: VideoFormat.hls,
      ),
    );

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Util.setStatusBarTextColor(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 1),
                  height: Util.screenWidth(context) * 9 / 16,
                  color: Colors.black87,
                  child: FlickVideoPlayer(
                    flickManager: flickManager,
                  ),
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
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: 2,
                    width: Util.screenWidth(context),
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(color: Color.fromRGBO(0, 0, 0, 0.1), width: 1),
                ),
              ),
              child: TabBar(
                controller: tabController,
                unselectedLabelColor: Colors.black87,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: xPrimaryColor,
                indicatorColor: xPrimaryColor,
                tabs: const [
                  Text('简介'),
                  Text('评论'),
                ],
              ),
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [const VideoIntro(), CommentWrap()],
            ))
          ],
        ),
      ),
    );
  }
}

class CommentWrap extends StatelessWidget {
  const CommentWrap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
            bottom: Util.bottomSafeHeight(context) + 60,
          ),
          itemBuilder: (context, index) => const Comment(),
          itemCount: 10,
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            alignment: Alignment.topCenter,
            height: Util.bottomSafeHeight(context) + 60,
            width: Util.screenWidth(context),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                ),
              ),
            ),
            child: Container(
              height: 40,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  borderRadius: BorderRadius.circular(5)),
              child: const TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: '请输入评论',
                    hintStyle: TextStyle(color: Color(0xff999999))),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Comment extends StatelessWidget {
  const Comment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://img1.baidu.com/it/u=2625325923,3446322967&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=800',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '回声',
                  style: TextStyle(
                    color: Color(0xff282828),
                    fontSize: 14,
                    height: 1.1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '请问你的配图都是怎么找的呀有没有相关网站推荐一下',
                  style: TextStyle(
                    color: Color(0xff6a6a6a),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '2022-06-29',
                  style: TextStyle(
                    color: Color(0xffc2c2c2),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () {},
              child: Column(
                children: const [
                  SizedBox(height: 10),
                  Icon(
                    Icons.favorite,
                    color: xPrimaryColor,
                    size: 20,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '200',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class VideoIntro extends StatelessWidget {
  const VideoIntro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '星际穿越',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                height: 1.4,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '分类：科幻 · 语言：英语 · 导演：克里斯托弗·诺兰',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xffa5a5a5), height: 1.6),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.message,
                  color: Color(0xffcfcfcf),
                  size: 35,
                ),
              ),
              const SizedBox(width: 50),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.favorite,
                  color: xPrimaryColor,
                  size: 35,
                ),
              ),
              const SizedBox(width: 50),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.share,
                  color: Color(0xffcfcfcf),
                  size: 35,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 15),
            height: 10,
            color: const Color(0xfff6f6f6),
          ),
          const Text(
            'INTRODUCE',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '《星际穿越》是2014年美英联合制作的科幻电影。该片由克里斯托弗·诺兰执导，马修·麦康纳、安妮·海瑟薇领衔主演。该片在物理学家基普·索恩的黑洞理论之上进行改编，主要讲述了一组宇航员通过穿越虫洞来为人类寻找新家园的冒险故事。该片于2014年11月5日在美国公映，11月7日在英国公映，11月12日在中国大陆公映。并于2020年8月2日在中国大陆重映。',
              style: TextStyle(
                color: Colors.black87,
                height: 1.8,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'ACTOR',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '北野武,国舞亚矢,渡边哲,胜村政信,寺岛进,大杉涟,森下能幸,津田宽治,木下邦家,克里斯·布里顿,水森コウ太,逗子とんぼ,矢岛健一',
              style: TextStyle(
                color: Colors.black87,
                height: 1.6,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
