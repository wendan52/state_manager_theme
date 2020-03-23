import 'package:flutter/material.dart';

class ShareWidget extends InheritedWidget  {
  final int data;//需要在子树中共享的数据
  ShareWidget({Widget child, this.data}) : super(child: child);

  // 子树中的widget通过该方法获取ShareWidget，从而获取共享数据
  static ShareWidget of(BuildContext context, {bool listen = true}) {
    return listen ? context.dependOnInheritedWidgetOfExactType<ShareWidget>()
    : context.getElementForInheritedWidgetOfExactType<ShareWidget>().widget;
  }

  // 继承 InheritedWidget 实现的方法 返回值 决定当data发生变化时，是否通知子树中依赖data的Widget 更新数据
  @override
  bool updateShouldNotify(ShareWidget oldData) {
    return oldData.data != data;
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void didChangeDependencies() {
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
  @override
  Widget build(BuildContext context) {
    return Text(ShareWidget.of(context, listen: false).data.toString(), style: TextStyle(fontSize: 30.0));
    // return Text(ShareWidget.of(context).data.toString());
  }
}

class InheritedTest extends StatefulWidget {
  @override
  _InheritedTestState createState() => _InheritedTestState();
}

class _InheritedTestState extends State<InheritedTest> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('test')),
      body: Center(
        child: ShareWidget(
          data: count,
          child: Column(
            children: <Widget>[
              Test(),
              FlatButton(
                child: Text("Add",style: TextStyle(fontSize: 30.0)),
                onPressed: () => setState(() => ++count),
              )
            ],
          ),
        ),
      ),
    );
  }
}