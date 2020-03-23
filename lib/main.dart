import 'package:flutter/material.dart';
import 'package:state_manager_theme/provider_page.dart';
import 'package:state_manager_theme/inherited_page.dart';
import 'package:state_manager_theme/provider/ChangeNotifierProvider.dart';
import 'package:state_manager_theme/provider/Consumer.dart';
import 'package:state_manager_theme/provider/ThemeModel.dart';
import 'package:state_manager_theme/stateful_page.dart';
const List<Map<String, dynamic>> themeColorLists = [
  {'cnName': '小红', 'value': 0xFFC91B3A},
  {'cnName': '小橙', 'value': 0xFFF7852A},
  {'cnName': '小黄', 'value': 0xFFFFC800},
  {'cnName': '小绿', 'value': 0xFF00BC12},
  {'cnName': '小青', 'value': 0xFF00E09E},
  {'cnName': 'Flutter蓝', 'value': 0xFF3391EA},
  {'cnName': '小紫', 'value': 0xFFBF3EFF},
  {'cnName': '小灰', 'value': 0xFF949494},
  {'cnName': '小黑', 'value': 0xFF212121},
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      data: ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, themeModel) {
          return MaterialApp(
            title: 'theme demo',
            theme: ThemeData(primaryColor: Color(themeModel.themeColor)),
            home: HomePage(),
            routes: {
              'provider_count': (context) {
                return ProviderPage();
              },
              'inherit_count': (context) {
                return InheritedTest();
              },
              'stateful': (context) {
                return StatefulPage();
              },
            },
          );
        },
      )
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _routeName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('theme demo'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() { _routeName = result; });
              Navigator.of(context).pushNamed(_routeName);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'provider_count',
                child: Text('provider_count'),
              ),
              const PopupMenuItem<String>(
                value: 'inherit_count',
                child: Text('inherit_count'),
              ),
              const PopupMenuItem<String>(
                value: 'stateful',
                child: Text('stateful'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: Consumer<ThemeModel>(
          builder: (context, themeModel) {
            return ListView.builder(
              itemCount: themeColorLists.length,
              itemBuilder: (BuildContext context, int index) {
                var curTheme = themeColorLists[index];
                return GestureDetector(
                  onTap: () {
                    themeModel.changeTheme(curTheme['value']);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(
                        color: Color(0xFFEBEBEB)
                      ))
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 40.0,
                          width: 40.0,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          color: Color(curTheme['value']),
                        ),
                        Expanded(child: Text(curTheme['cnName'], style: TextStyle(color: Color(curTheme['value'])))),
                        curTheme['value'] == themeModel.themeColor ? Icon(Icons.check_circle_outline, color: Color(curTheme['value'])) : SizedBox()
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}