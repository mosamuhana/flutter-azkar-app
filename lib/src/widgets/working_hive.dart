// https://github.com/hey-om7/FlutterPackage_workingHive/blob/main/lib/working_hive.dart
//library working_hive;

import 'package:hive/hive.dart';
import 'dart:async';

class WorkingHive {
  String initPath = '';
  String boxName = '';

  Future initiateHive() async {
    try {
      if (initPath.length == 0) {
        print('Please add an initPath value in order to initated');
      } else {
        Hive.init(initPath);
      }
    } catch (e) {
      print('error initiating' + e.toString());
    }
  }

  Box get box => Hive.box('boxName');

  Future write(String key, dynamic data) async {
    var box = await Hive.openBox(boxName);
    box.put(key, data);
    print('successfully saved data:$data for key:$key');
  }

  Future read(String key) async {
    var box = await Hive.openBox(boxName);
    return box.get(key);
  }

  Future delete(String key) async {
    var box = await Hive.openBox(boxName);
    try {
      box.delete(key).then((value) => print('deleted value from key: $key'));
    } catch (e) {
      print('working hive plugin error: ' + e.toString());
    }
  }
}
