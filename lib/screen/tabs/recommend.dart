import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:x_movie/components/recommend/recommend_item.dart';
import 'package:x_movie/models/movie.dart';
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
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    Util.dio.get('/movie/recommend').then((res) {
      if (res.data['msg'] != '') {
        Toast.show(
          res.data['msg'],
        );
        return;
      }
      List<Movie> moviesTem = [];
      for (var i = 0; i < res.data['data'].length; i++) {
        moviesTem.add(Movie.formatJson(res.data['data'][i]));
      }
      setState(() {
        movies = moviesTem;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    Util.setStatusBarTextColor(statusBarStyle);
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
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
                color: Color(0xff010101),
                size: 25,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => RecommendItem(
          movie: movies[index],
          onTab: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => VideoPaly(movie: movies[index]),
              ),
            )
                .then((value) {
              Timer(const Duration(milliseconds: 300), () {
                Util.setStatusBarTextColor(statusBarStyle);
              });
            });
          },
        ),
        itemCount: movies.length,
      ),
    );
  }
}
