import 'package:Farm_app/model/news.dart';
import 'package:Farm_app/model/news_source.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class SourceCard extends StatefulWidget {
  final void Function(NewsSource newsSource) _updateSource;
  NewsSource _source;
  SourceCard(this._source, this._updateSource);

  @override
  State<StatefulWidget> createState() {
    return SourceCardState(_updateSource, _source);
  }
}

class SourceCardState extends State<SourceCard>{
  final void Function(NewsSource newsSource) _updateSource;
  NewsSource _source;
  bool _selected = true;


  SourceCardState(this._updateSource, this._source);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
          onTap: (){
            setState(() {
              _updateSource(_source);
              _selected = !_selected;
            });
          },
          child: Container(
              color: _selected? Colors.white : Colors.green,
              height: 100,
              child: Row(
                children: <Widget>[
                  OctoImage(
                    image: CachedNetworkImageProvider(_source.imgUrl),
                    errorBuilder: OctoError.icon(color: Colors.red),
                    fit: BoxFit.fitWidth,
                    width: 120,
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
                  Flexible(
                      child: Container(
                        width: double.infinity,
                        child: Text(_source.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18)),
                      ))
                ],
              ))),
    );
  }
}