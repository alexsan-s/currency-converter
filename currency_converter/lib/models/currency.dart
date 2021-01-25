import 'dart:async';

import 'package:flutter/material.dart';

class Currency {
  String _controller;

  String get controller => _controller;

  final StreamController<String> _blocController =
      StreamController<String>.broadcast();

  Stream<String> get stream => _blocController.stream;

  void change(String value) {
    _controller = value;
    _blocController.sink.add(controller);
  }

  void close() {
    _blocController.close();
  }
}

class Value {
  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  final StreamController<TextEditingController> _blocController =
      StreamController<TextEditingController>.broadcast();

  Stream<TextEditingController> get stream => _blocController.stream;

  void change(String value) {
    _controller.text = value;
    _blocController.sink.add(controller);
  }

  void close() {
    _blocController.close();
  }
}

class Name {
  String _name;

  String get name => _name;

  final StreamController<String> _blocController =
      StreamController<String>.broadcast();

  Stream<String> get stream => _blocController.stream;

  void change(String value) {
    _name = value;
    _blocController.sink.add(name);
  }

  void close() {
    _blocController.close();
  }
}

class Bid {
  double _bid;

  double get bid => _bid;

  final StreamController<double> _blocController =
      StreamController<double>.broadcast();

  Stream<double> get stream => _blocController.stream;

  void change(double value) {
    _bid = value.toDouble();
    _blocController.sink.add(bid);
  }

  void close() {
    _blocController.close();
  }
}
