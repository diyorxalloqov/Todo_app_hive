import 'package:database/db/archive_db_service.dart';
import 'package:flutter/material.dart';

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Archived"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await ArchiveService().clear();
                setState(() {});
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: FutureBuilder(
          future: ArchiveService().getTodo(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            } else if (snapshot.data is String) {
              return Center(
                child: Text(snapshot.data.toString()),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) async {
                      await ArchiveService().deleteItemarch(index);
                      
                    },
                    background: Row(
                      children: [
                        Expanded(
                            child: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete),
                        )),
                        Expanded(
                            child: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete),
                        )),
                      ],
                    ),
                    child: Padding(
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
                            title: Text(
                              snapshot.data[index],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: (snapshot.data as List).length,
              );
            }
          }),
    );
  }
}
