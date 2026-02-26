import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/note_store.dart';

class NoteFormPage extends StatefulWidget {
  const NoteFormPage({super.key});

  @override
  State<NoteFormPage> createState() =>
      _NoteFormPageState();
}

class _NoteFormPageState
    extends State<NoteFormPage> {
  final _title =
      TextEditingController();
  final _content =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final store =
        context.read<NoteStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Note",
          style: TextStyle(
              fontWeight:
                  FontWeight.bold),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _title,
              decoration:
                  InputDecoration(
                labelText: "Title",
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(16),
                ),
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _content,
              maxLines: 6,
              decoration:
                  InputDecoration(
                labelText: "Content",
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(16),
                ),
              ),
            ),
            const SizedBox(height: 28),
            FilledButton(
              style:
                  FilledButton.styleFrom(
                padding:
                    const EdgeInsets
                        .symmetric(
                        vertical: 16),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius
                          .circular(16),
                ),
              ),
              onPressed: () async {
                if (_title.text
                        .trim()
                        .isEmpty ||
                    _content.text
                        .trim()
                        .isEmpty) {
                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(
                    const SnackBar(
                        content: Text(
                            "Please fill all fields")),
                  );
                  return;
                }

                await store.add(
                  _title.text,
                  _content.text,
                );

                if (context.mounted) {
                  Navigator.pop(
                      context);
                }
              },
              child:
                  const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}