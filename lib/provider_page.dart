import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_manager_theme/model/count.dart';

class ProviderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('provider count demo')),
      body: ChangeNotifierProvider(
        create: (_) => CountModel(),
        child: Column(
          children: <Widget>[
            CountText(),
            Center(
              child: Consumer<CountModel>(
                builder: (context, counter, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          counter.add();
                        },
                        child: Text('+', style: TextStyle(fontSize: 26.0)),
                      ),
                      Text(counter.count.toString(), style: TextStyle(fontSize: 26.0)),
                      FlatButton(
                        onPressed: () {
                          counter.dec();
                        },
                        child: Text('-', style: TextStyle(fontSize: 26.0)),
                      )
                    ],
                  );
                }
              )
            )
          ]
        )
      )
    );
  }
}

class CountText extends StatefulWidget {
  @override
  _CountTextState createState() => _CountTextState();
}

class _CountTextState extends State<CountText> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('------change------');
  }

  @override
  Widget build(BuildContext context) {
    // return Text(
    //   Provider.of<CountModel>(context).count.toString(),
    //   style: TextStyle(fontSize: 26.0)
    // );
    return Consumer<CountModel>(
      builder: (_, counter, __) {
        return Text(counter.count.toString(),
          style: TextStyle(fontSize: 26.0)
        );
      },
    );
  }
}