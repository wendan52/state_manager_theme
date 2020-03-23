import 'package:flutter/material.dart';

class StatefulPage extends StatefulWidget {
  @override
  _StatefulPageState createState() => _StatefulPageState();
}

class _StatefulPageState extends State<StatefulPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('stateful demo')),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                child: Text('+', style: TextStyle(fontSize: 26.0)),
              ),
              Text(count.toString(), style: TextStyle(fontSize: 26.0)),
              FlatButton(
                onPressed: () {
                  setState(() {
                    count--;
                  });
                },
                child: Text('-', style: TextStyle(fontSize: 26.0)),
              ),
            ],
          ),
        )
      ),
    );
  }
}