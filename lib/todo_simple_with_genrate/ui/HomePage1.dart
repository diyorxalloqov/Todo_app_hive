import 'package:database/todo_simple_with_genrate/db/db_service1.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY todo"),
      ),
      body: FutureBuilder(
          future: DBService1().getTasks(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if ((snapshot.data as Box).isEmpty) {
              return const Center(
                child: Text("ma'lumotlar yoq"),
              );
            } else {
              Box data = snapshot.data as Box;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('vazifa $index'),
                    trailing: IconButton(
                      onPressed: () {
                        DBService1().updateTask(index);
                        setState(() {
                          
                        });
                      },
                      icon: CircleAvatar(
                          backgroundColor: data.getAt(index)["done"]
                              ? Colors.green
                              : Colors.red
                          ),
                    ),
                  );
                },
                itemCount: data.length,
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DBService1().writeToBox("Hello ");
          setState(() {
            
          });
        },
        child: const Text("Run"),
      ),
    );
  }
}
