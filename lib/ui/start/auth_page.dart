import 'package:Farm_app/ui/start/sources_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) => Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Text(
                    "FarmApp",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.green
                    )
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "Привет!",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 25
                      )
                  ),
                  Text(
                      "Выберите источники, и мы покажем Вам персональную подборку новостей!",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 18
                      )
                  ),
                ],
              ),
              FloatingActionButton.extended(
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SourcesPage()))
                  },
                  backgroundColor: Colors.green,
                  label: Text("Начать"),
                  icon: Icon(Icons.arrow_forward_ios)),
            ],
          ),
        ),
      ))
    );
  }
}

