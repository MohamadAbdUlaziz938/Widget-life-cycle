import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

/// The lifecycle has the following simplified steps:
/*
1- createState()
2- mounted == true
3- initState()
4- didChangeDependencies()
5- build()
6- didUpdateWidget()
7- setState()
8- deactivate()
9- dispose()
10- mounted == false
 */

/// 1- create state
/*
  When Flutter is instructed to build a StatefulWidget,
  it immediately calls createState(). This method must exist.
  A StatefulWidget rarely needs to be more complicated than this.
 */

/// 2. mounted is true
/*
  When createState creates the state class, a buildContext is assigned to that state.
  A BuildContext is, overly simplified, the place in the widget tree in which this widget is placed. Here's a longer explanation.
  All widgets have a bool this.mounted property. It is turns true when the buildContext is assigned. It is an error to call setState when a widget is unmounted.
  tip: This property is useful when a method on your state calls setState() but it isn't clear when or how often that method will be called. Perhaps its being called in response to a stream updating. You can use if (mounted) {... to make sure the State exists before calling setState().
  */
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// initState
  /*
  This is the first method called when the widget is created (after the class constructor, of course.)
  initState is called once and only once. It must also call super.initState().
  This @override method is the best time to:
  Initialize data that relies on the specific BuildContext for the created instance of the widget.
  Initialize properties that rely on this widgets 'parent' in the tree.
  Subscribe to Streams, ChangeNotifiers, or any other object that could change the data on this widget.
  */

  @override
  void initState() {
    super.initState();
    print("***** init state *****");
  }

  /// didChangeDependencies
  /*
  The didChangeDependencies method is called immediately after initState on the first time the widget is built.
  It will also be called whenever an object that this widget depends on data from is called. For example, if it relies on an InheritedWidget, which updates.
  build is always called after didChangeDependencies is called, so this is rarely needed. However, this method is the first change you have to call BuildContext.inheritFromWidgetOfExactType. This essentially would make this State 'listen' to changes on a Widget it's inheriting data from.
  The docs also suggest that it could be useful if you need to do network calls (or any other expensive action) when an InheritedWidget updates.
  didChangeDependencies called when the dependencies of state change.
  */
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("**** didChangeDependencies mounted $mounted");
  }

  /// didUpdateWidget
  /*
  didUpdateWidget() is called if the parent widget changes and has to rebuild this widget (because it needs to give it different data), but it's being rebuilt with the same runtimeType, then this method is called.
  This is because Flutter is re-using the state, which is long lived. In this case, required is to initialize some data again, as one would in initState().
  If the state's build() method relies on a Stream or other object that can change, unsubscribe from the old object and re-subscribe to the new instance in didUpdateWidget().
  tip: This method is basically the replacement for 'initState()' if it is expected the Widget associated with the widgets's state nrrds to to be rebuilt!
  Flutter always called build() after this, so any subsequent further calls to setState is redundant.
  */

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    print("***** didUpdateWidget called ${oldWidget.title}");
    super.didUpdateWidget(oldWidget);
    /*   if (oldWidget.importantProperty != widget.importantProperty) {
      _init();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    print("***** rebuild *****");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ChildWidget(counter: _counter)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /// 8- deactivate()
/*
  This is rarely used.
  'deactivate()' is called when State is removed from the tree,
  but it might be reinserted before the current frame change is finished.
  This method exists basically because State objects can be moved from one point in a tree to another
  */

  /// 9- dispose
/*
   dispose()' is called when the State object is removed, which is permanent.
   This method is where to unsubscribe and cancel all animations, streams, etc.
*/

  /// 10. mounted is false
/*
The state object can never remount, and an error is thrown is setState() is called.
*/
}

/*
At the time build is called, context is available to us and is passed as an argument.
Now moving on, initstate is called before the state loads its dependencies and for that reason no context is available and you get an error for that if you use context in initstate.
However, didChangeDependencies is called just a few moments after the state loads its dependencies and context is available at this moment so here you can use context.
However both of them are called before build is called.
The only difference is that one is called before the state loads its dependencies and the other is called a few moments after the state loads its dependencies.
*/
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
    if (oldWidget.counter == widget.counter-1) {
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
