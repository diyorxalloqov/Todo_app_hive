// // ignore_for_file: file_names

import 'package:database/db/archive_db_service.dart';
import 'package:database/db/db_service.dart';
import 'package:database/ui/archive_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textcontroller = TextEditingController();

  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();

  final TextEditingController _updatecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Todo",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Archive()));
              },
              icon: const Icon(Icons.archive)),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              maxLength: 50,
              key: _key,
              autocorrect: true,
              maxLines: 1,
              autofocus: true,
              controller: _textcontroller,
              validator: (value) {
                // xatoni korsatish uchun ishlatiladi
                if (value!.isEmpty) {
                  return "Iltimos bo'sh qoldirmang";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: "Vazifani kiriting",
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "Bajariladigan vazifalar",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: DBService().getTodos(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if ((snapshot.data as Box).isEmpty) {
                  return const Center(
                    child: Text("Vazifalar mavjud emas"),
                  );
                } else {
                  Box data1 = snapshot.data as Box;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 80,
                          width: double.infinity,
                          child: Card(
                            elevation: 10,
                            shape: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            color: Colors.grey.shade400,
                            child: ListTile(
                              /********* */
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                        "${data1.getAt(index)['vazifa']} Tahrirlash"),
                                    content: TextFormField(
                                      controller: _updatecontroller,
                                      decoration: const InputDecoration(
                                          hintText: "tahrirlash"),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Orqaga"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          setState(() {});
                                          _updatecontroller.clear();
                                          Future.delayed(Duration.zero).then(
                                              (value) =>
                                                  Navigator.pop(context));
                                        },
                                        child: const Text("Tahrirlash"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              leading: IconButton(
                                  onPressed: () async {
                                    data1.getAt(index)['done'] =
                                        !data1.getAt(index)['done'];
                                    setState(() {});
                                  },
                                  icon: data1.getAt(index)["done"]
                                      ? const Icon(Icons.check_box_outlined)
                                      : const Icon(
                                          Icons.check_box_outline_blank),
                                  color: data1.getAt(index)["done"]
                                      ? Colors.green
                                      : Colors.red),
                              title: Text(
                                data1.getAt(index)["vazifa"],
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Text((data1
                                      .getAt(index)['created_at']
                                      .substring(0, 10))
                                  .toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(
                                                "${(data1.getAt(index)["vazifa"].toString())} o'chirilsinmi"),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Orqaga")),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await DBService()
                                                      .deleteItem(index);
                                                  setState(() {});
                                                  Future.delayed(Duration.zero)
                                                      .then((value) =>
                                                          Navigator.pop(
                                                              context));
                                                },
                                                child: const Text("O'chirish"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 30,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await DBService().deleteItem(index);
                                      await ArchiveService().writeToDBArchive(
                                          data1.getAt(index)['vazifa']);
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.archive_outlined,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: data1.length,
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_key.currentState!.validate()) {
            await DBService().openBox();
            await DBService().writeToDB(_textcontroller.text);
            _textcontroller.clear();
          }
          setState(() {});
        },
        label: const Text("Qo'shish"),
      ),
    );
  }
}
