import 'package:flutter/cupertino.dart';

class OrderViewModel with ChangeNotifier {

  final List<Map<String, dynamic>> _myOrderList = [];

  List<Map<String, dynamic>> get myOrderList => _myOrderList;
}