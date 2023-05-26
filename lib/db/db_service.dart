import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class DBService {
  Box? todobox;

  Future<void> openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    todobox = await Hive.openBox("Todo");
  }

  Future<void> writeToDB(String userdata) async {
    await openBox();
    if (!await findsame(userdata)) {
      await todobox!.add({
        'vazifa': userdata,
        "done": false,
        "created_at": DateTime.now().toString()
      });
      // await todobox!.add({"Todo":userdata,"done":true}); //////
    } else {
      Fluttertoast.showToast(
        msg: "Bu malumot mavjud",
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
    }
    // await closeBox();
  }

  Future<dynamic> getTodos() async {
    await openBox();
    try {
      await openBox();
      return todobox!;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteItem(int index) async {
    await openBox();
    await todobox!.deleteAt(index);
    // await closeBox();
    return;
  }

  Future<void> updateItem(int index, String newdata) async {
    await openBox();
    var alldata = todobox!.getAt(index);
    await todobox!.putAt(index, {
      "vazifa": alldata![newdata].toString(), //"vazifa"
      "done": alldata!["done"],
      "created_at": DateTime.now().toString()
    });
    return;
  }

  Future<bool> findsame(String value) async {
    await openBox();
    bool isFound = false;
    for (int i = 0; i < todobox!.length; i++) {
      if (todobox!.getAt(i) == value) {
        isFound = true;
      } else {
        isFound = false;
      }
    }
    return isFound;
  }
}
