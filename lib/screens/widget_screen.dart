import 'package:flutter/material.dart';

class WidgetScreen extends StatefulWidget {
  const WidgetScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WidgetScreenState();
}

class _FibonacciNum {
  static int _sum1 = 0;
  static int _sum2 = 1;
  static int _nextPosition = 0;

  final int _position;
  final int _value;

  static _FibonacciNum next() {
    int value = _nextPosition < 2 ? _nextPosition : _sum1 + _sum2;
    _sum1 = _sum2;
    _sum2 = value;
    return _FibonacciNum(_nextPosition++, value);
  }

  const _FibonacciNum(this._position, this._value);

  Widget asWidget(void Function(_FibonacciNum) onRemove) {
    return Dismissible(
      key: ValueKey<int>(_position),
      child: ExpansionTile(
        title: Text(_value.toString()),
        children: [
          ListTile(title: Text("Value #$_position"))
        ],
      ),
      onDismissed: (direction) => onRemove(this),
    );
  }

  static void reset() {
    _sum1 = 0;
    _sum2 = 1;
    _nextPosition = 0;
  }
}

class _WidgetScreenState extends State<WidgetScreen> {
  final int maxShownNums = 15;
  final List<_FibonacciNum> _fibonacciList = [];

  void _updateFibonacciList() {
    while(_fibonacciList.length < maxShownNums) {
      _fibonacciList.add(_FibonacciNum.next());
    }
  }

  void _onFibonacciDismissed(_FibonacciNum num) {
    setState(() {
      _fibonacciList.remove(num);
      _updateFibonacciList();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _updateFibonacciList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _FibonacciNum.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dismissible + ExpansionTile"),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          for(_FibonacciNum i in _fibonacciList)
            i.asWidget(_onFibonacciDismissed)
        ],
      )
    );
  }
}