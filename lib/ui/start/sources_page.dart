import 'dart:convert';
import 'package:Farm_app/constants/urls.dart';
import 'package:Farm_app/ui/main/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:Farm_app/model/news_source.dart';
import 'package:Farm_app/ui/start/source_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Farm_app/constants/prefs_constants.dart';

class SourcesPage extends StatefulWidget {
  @override
  createState() {
    return _SourcePageState();
  }
}

class _SourcePageState extends State<SourcesPage> {
  Future<List<NewsSource>> fetchNewsSource() async {
    final response =
        await http.get(listOfNewsSourcesURL);
    if (response.statusCode == 200) {
      var srcList = jsonDecode(response.body);
      return (srcList as List).map((e) => NewsSource.fromJson(e)).toList();
    } else {
      throw Exception('Ошибка загрузки источников');
    }
  }

  _updateSource(NewsSource newsSource) {
    setState(() {
      if (!selectedSources.containsKey(newsSource.id)) {
        selectedSources[newsSource.id] = newsSource;
      } else {
        selectedSources.remove(newsSource.id);
      }
    });
  }

  Map<int, NewsSource> selectedSources = Map();

  Future<List<NewsSource>> newsSources;

  @override
  void initState() {
    super.initState();
    newsSources = fetchNewsSource();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: new AppBar(
            title: Text("Выбрано: " + selectedSources.length.toString())),
        body: FutureBuilder<List<NewsSource>>(
          future: newsSources,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SourceCard(snapshot.data[index], _updateSource);
                      }));
            } else if (snapshot.hasError) {
              return Text("Возникла ошибка");
            } else {
              return Center(
                  child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text(
                    "Загрузка источников...",
                    textAlign: TextAlign.center,
                  )
                ],
              ));
            }
          },
        ),
        floatingActionButton: Visibility(
          child: FloatingActionButton.extended(
              onPressed: () async{
                final prefs = await SharedPreferences.getInstance();
                String json = jsonEncode(selectedSources.values.toList());
                prefs.setString(selectedSourcesKEY, json);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
              },
              icon: Icon(Icons.check_circle),
              label: Text("Готово"),
              backgroundColor: Colors.green),
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: selectedSources.length > 0,
        ),
      ),
    );
  }
}
