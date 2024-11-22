import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _noteStream =
      Supabase.instance.client.from("Note").stream(primaryKey: ["id"]);
  TextEditingController textEditingController = TextEditingController();

  void addNewNote() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Note"),
          content: TextField(
            controller: textEditingController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                saveNote();
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void saveNote() async {
    await Supabase.instance.client.from("Note").insert(
      {
        "note_name": textEditingController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _noteStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final noteList = snapshot.data!;
            // 如果資料為空，顯示提示訊息
            if (noteList.isEmpty) {
              return const Center(
                child: Text("No notes available. Add a new note!"),
              );
            }
            return ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                final note = noteList[index];
                return Text(note["note_name"]);
              },
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          onPressed: addNewNote,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
