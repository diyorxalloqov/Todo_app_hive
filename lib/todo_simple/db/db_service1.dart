import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DBService1 {
  Box? taskBox;

  // Open box
  Future<void> openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    taskBox = await Hive.openBox("task");
  }

  Future<void> writeToBox(String task,) async {
    await openBox();
    await taskBox!.add({
      "task": task,
      "done": false,
      "created_at": DateTime.now().toString(),
    });
  }

  Future<Box> getTasks() async {
    await openBox();
    return taskBox!;
  }

  Future<void> updateTask(int index) async {
    await openBox();
    var foundData = taskBox!.getAt(index);
    await taskBox!.putAt(index, {
      "task": foundData!['task'].toString(),
      "done": !foundData['done'],
      "created_at": DateTime.now().toString(),
      // "img": foundData['img']
    });
  }
}