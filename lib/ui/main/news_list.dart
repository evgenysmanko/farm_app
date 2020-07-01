import 'package:Farm_app/model/news.dart';
import 'package:Farm_app/model/news_source.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'news_card.dart';


class NewsList extends StatelessWidget {
  var listOfNews = [
    News('Первая новость',
        'https://m.newsland.com/static/u/u/news/2019/07/4e8585d8b2a74ac2b5bd71a4b67082bd.jpg'),
    News('Вторая новость',
        'https://storage.needpix.com/rsynced_images/cow-3258490_1280.jpg'),
    News('Третья новость',
        'https://infotolium.com/uploads/posts/2016-09/1474288686_2-how-to-harvest-meet-autumn-worldwide.jpg'),
  ];

  List<RssItem> _news;

  NewsList(this._news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _news.length,
      itemBuilder: (BuildContext context, int index) {
        return NewsCard(_news[index]);
      }
    );
  }
}
