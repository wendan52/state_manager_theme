import 'package:flutter/material.dart';

// 一个通用的InheritedWidget，保存任需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  final T data;

  InheritedProvider({
    @required this.data,
    Widget child
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    // 每次更新都会调用依赖其的子孙节点的`didChangeDependencies`
    return true;
  }
}
