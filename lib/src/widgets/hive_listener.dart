// https://github.com/malibayram91/hive_listener
//library hive_listener;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveListener<T> extends StatefulWidget {
  final Box<T> box;
  final List<String>? keys;

  /// if you want to close your box when disposing set [closeOnDispose] to true
  final bool closeOnDispose;
  final Widget Function(BuildContext context, Box<T> bx) builder;

  const HiveListener({
    Key? key,
    required this.box,
    required this.builder,
    this.closeOnDispose = false,
    this.keys,
  }) : super(key: key);

  @override
  _HiveListenerState createState() => _HiveListenerState();
}

class _HiveListenerState<T> extends State<HiveListener<T>> {
  late Box<T> _box;
  bool _boxOpened = false;

  void _valueChanged() {
    _box = widget.box;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _box = widget.box;
    _boxOpened = Hive.isBoxOpen(_box.name);
    if (_boxOpened)
      _box.listenable(keys: widget.keys).addListener(_valueChanged);
    else
      Hive.openBox<T>(_box.name).then((value) {
        _box = value;
        _boxOpened = _box.isOpen;
        _box.listenable(keys: widget.keys).addListener(_valueChanged);
        if (mounted) setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    if (_boxOpened)
      _box.listenable(keys: widget.keys).removeListener(_valueChanged);

    if (widget.closeOnDispose) widget.box.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_boxOpened)
      return widget.builder(context, _box);
    else
      return Center(child: CircularProgressIndicator());
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (BuildContext context, Box<dynamic> box, Widget? widget) {
        return Switch(
          value: box.get('darkMode') ?? false,
          onChanged: (val) {
            box.put('darkMode', val);
          },
        );
      },
    );
  }
}
