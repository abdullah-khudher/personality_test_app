import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  const BaseView({
    Key? key,
    required this.builder,
    required this.model,
    this.onModelReady,
  }) : super(key: key);

  final Widget Function(BuildContext context, T model, Widget? child) builder;

  final T model;
  final void Function(T)? onModelReady;

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseView<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (BuildContext context) => model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }
}