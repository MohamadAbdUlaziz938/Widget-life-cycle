# lifecycle

Describing the life cycle of the stateful widget.

## Getting Started

The lifecycle has the following simplified steps:

1. createState()
2. mounted == true
3. initState()
4. didChangeDependencies()
5. build()
6. didUpdateWidget()
7. setState()
8. deactivate()
9. dispose()
10. mounted == false

## Details
<details>
<summary>Create state</summary>
<p>
When Flutter is instructed to build a StatefulWidget,
it immediately calls createState(). This method must exist.
A StatefulWidget rarely needs to be more complicated than this.
</p>
</details>

<details>
<summary>Mounted is true</summary>
<p>
  When createState creates the state class, a buildContext is assigned to that state.
  A BuildContext is, overly simplified, the place in the widget tree in which this widget is placed. Here's a longer explanation.
  All widgets have a bool this.mounted property. It is turns true when the buildContext is assigned. It is an error to call setState when a widget is unmounted.
  tip: This property is useful when a method on your state calls setState() but it isn't clear when or how often that method will be called. Perhaps its being called in response to a stream updating. You can use if (mounted) {... to make sure the State exists before calling setState().
</p>
</details>

<details>
<summary>initState</summary>
<p>
  This is the first method called when the widget is created (after the class constructor, of course.)
  initState is called once and only once. It must also call super.initState().
  This @override method is the best time to:
  Initialize data that relies on the specific BuildContext for the created instance of the widget.
  Initialize properties that rely on this widgets 'parent' in the tree.
  Subscribe to Streams, ChangeNotifiers, or any other object that could change the data on this widget.
</p>
</details>  

<details>
<summary>didChangeDependencies</summary>
<p>
  The didChangeDependencies method is called immediately after initState on the first time the widget is built.
  It will also be called whenever an object that this widget depends on data from is called. For example, if it relies on an InheritedWidget, which updates.
  build is always called after didChangeDependencies is called, so this is rarely needed. However, this method is the first change you have to call BuildContext.inheritFromWidgetOfExactType. This essentially would make this State 'listen' to changes on a Widget it's inheriting data from.
  The docs also suggest that it could be useful if you need to do network calls (or any other expensive action) when an InheritedWidget updates.
  didChangeDependencies called when the dependencies of state change.
</p>
</details>

<details>
<summary>didUpdateWidget</summary>
<p>
  didUpdateWidget() is called if the parent widget changes and has to rebuild this widget (because it needs to give it different data), but it's being rebuilt with the same runtimeType, then this method is called.
  This is because Flutter is re-using the state, which is long lived. In this case, required is to initialize some data again, as one would in initState().
  If the state's build() method relies on a Stream or other object that can change, unsubscribe from the old object and re-subscribe to the new instance in didUpdateWidget().
  tip: This method is basically the replacement for 'initState()' if it is expected the Widget associated with the widgets's state nrrds to to be rebuilt!
  Flutter always called build() after this, so any subsequent further calls to setState is redundant.
</p>
</details>

<details>
<summary>deactivate</summary>
<p>
  This is rarely used.
  'deactivate()' is called when State is removed from the tree,
  but it might be reinserted before the current frame change is finished.
  This method exists basically because State objects can be moved from one point in a tree to another
</p>
</details>

<details>
<summary>dispose</summary>
<p>
   dispose()' is called when the State object is removed, which is permanent.
   This method is where to unsubscribe and cancel all animations, streams, etc.
</p>
</details>

- [Reference documentation](https://flutterbyexample.com/lesson/stateful-widget-lifecycle#4-didChangeDependencies)
  For help getting started with Flutter development, view the
  [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on
  mobile development, and a full API reference.
