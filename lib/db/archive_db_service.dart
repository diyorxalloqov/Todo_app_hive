import 'package:hive_flutter/adapters.dart';

class ArchiveService {
  Box? arch;

  Future<void> openBoxarch() async {
    arch = await Hive.openBox("TodoArch");
  }

  Future<void> writeToDBArchive(String data) async {
    await openBoxarch();
    await arch!.add(data);
  }

  Future<dynamic> getTodo() async {
    try {
      await openBoxarch();
      return arch!.values.toList();
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deleteItemarch(int index) async {
    await openBoxarch();
    await arch!.deleteAt(index);
    return;
  }

  Future<void> clear() async {
    await openBoxarch();
    await arch!.clear();
  }
}
