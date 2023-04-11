import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChildWidget extends StatefulWidget {
  const ChildWidget({Key? key, required this.counter}) : super(key: key);
  final int counter;

  @override
  State<ChildWidget> createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("----- ChildWidget init state");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kDebugMode) {
      print("----- ChildWidget didChangeDependencies");
    }
    // will rebuild the widget after perform this function.
    // check orientation, has focus ...
  }

  @override
  void didUpdateWidget(covariant ChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.counter == widget.counter - 1) {
      if (kDebugMode) {
        print("----- ChildWidget didUpdateWidget ---> widgets are equal");
      }
    } else {
      if (kDebugMode) {
        print("----- ChildWidget didUpdateWidget");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("----- rebuild ChildWidget");
    return Center(
      child: Text("Counter ${widget.counter}"),
    );
  }
}
