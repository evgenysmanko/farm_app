import 'package:Farm_app/model/news.dart';
import 'package:Farm_app/ui/main/news_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:webfeed/domain/rss_item.dart';

class NewsCard extends StatelessWidget {

  RssItem _newsItem;

  NewsCard(this._newsItem);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: GestureDetector(
          onTap: () => {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => NewsDetail(_newsItem)))},
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                OctoImage(
                  image: CachedNetworkImageProvider(
                      _newsItem.content != null ?
                      _newsItem.content.images.first :
                      _newsItem.enclosure!= null ?
                      _newsItem.enclosure.url :
                      "https://via.placeholder.com/468x300?text=Not+image"

                  ),
                  errorBuilder: OctoError.icon(color: Colors.red),
                  fit: BoxFit.cover,
                  height: 200,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  progressIndicatorBuilder: (context, progress) {
                    double value;
                    if (progress != null &&
                        progress.expectedTotalBytes != null) {
                      value = progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes;
                    }
                    return CircularProgressIndicator(value: value);
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    _newsItem.title,
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline5,
                  ),
                )
              ],
            ))
        );

  }
}