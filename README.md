# lifecycle

Describe life cycle of the widget.

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
<summary>
Create state
</summary>
<p>
When Flutter is instructed to build a StatefulWidget,
it immediately calls createState(). This method must exist.
A StatefulWidget rarely needs to be more complicated than this.
</p>
</details>

- [Reference documentation](https://flutterbyexample.com/lesson/stateful-widget-lifecycle#4-didChangeDependencies)
  For help getting started with Flutter development, view the
  [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on
  mobile development, and a full API reference.
