import 'package:flutter/material.dart';
import 'package:state_manager_theme/provider/InheritedProvider.dart';

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;

  ChangeNotifierProvider({
    Key key,
    this.child,
    this.data
  });
  
  // 方便子树中的widget获取共享数据
  static T of<T> (BuildContext context, {bool listen = true}) {
    final provider = listen
    ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
    : context.getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()?.widget as InheritedProvider<T>;
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  
  @override
  void initState() {
    // model添加监视器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model监听
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    // 当provider更新时，数据不相等，解绑旧数据监听，添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  void update() {
    // 数据发生变化(model类调用notifyListeners)，重新构建InheritedProvider
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}