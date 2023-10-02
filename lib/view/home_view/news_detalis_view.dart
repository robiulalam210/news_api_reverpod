import 'package:flutter/material.dart';

class NewsDetalisView extends StatelessWidget {
  NewsDetalisView({super.key,required this.news});

  var news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [

            Text(news.title.toString())
          ],
        ),
      ),
    );
  }
}
