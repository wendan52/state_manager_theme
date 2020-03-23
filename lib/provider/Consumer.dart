import 'package:flutter/material.dart';
import 'package:state_manager_theme/provider/ChangeNotifierProvider.dart';

// 便捷类，会获得当前context和指定数据类型的Provider
class Consumer<T> extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  Consumer({
    Key key,
    this.child,
    @required this.builder
  }) : assert(builder != null) , super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context),//自动获取Model
    );
  }
}