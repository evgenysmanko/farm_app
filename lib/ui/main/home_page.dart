import 'package:Farm_app/constants/urls.dart';
import 'package:Farm_app/model/news_source.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Farm_app/constants/prefs_constants.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'dart:convert';
import 'news_list.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{

  Future<List<RssItem>> news;

  Future<List<RssItem>> fetchNews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var srcList = jsonDecode(prefs.getString(selectedSourcesKEY));
    List<NewsSource> newsSources = (srcList as List).map((e) => NewsSource.fromJson(e)).toList();
    final response = await http.get(newsSources[0].rss);
    if (response.statusCode == 200) {
      var rss = response.body;
      var rssFeed = new RssFeed.parse(rss);
      return rssFeed.items;
    } else {
      throw Exception('Ошибка загрузки источников');
    }
  }

  @override
  void initState() {
    super.initState();
    news = fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new Scaffold(
        appBar: new AppBar(title: new Text('Farm app')),
        body: FutureBuilder<List<RssItem>>(
          future: news,
          builder: (context, snapshot){
            if(snapshot.hasData) return NewsList(snapshot.data);
            else if (snapshot.hasError) return Text(snapshot.error.toString());
            else return Text("Загрузка");
          },
        )
      ),
    );
  }

}