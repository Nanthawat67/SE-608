import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/event.dart';
import '../state/event_store.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  State<EventFormScreen> createState() =>
      _EventFormScreenState();
}

class _EventFormScreenState
    extends State<EventFormScreen> {
  final _title = TextEditingController();
  final _start = TextEditingController();
  final _end = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final store = context.read<EventStore>();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _title,
                decoration:
                    const InputDecoration(labelText: "Title")),
            TextField(
                controller: _start,
                decoration:
                    const InputDecoration(labelText: "Start Time (HH:mm)")),
            TextField(
                controller: _end,
                decoration:
                    const InputDecoration(labelText: "End Time (HH:mm)")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final event = Event(
                  title: _title.text,
                  categoryId: 1,
                  eventDate: "2026-01-01",
                  startTime: _start.text,
                  endTime: _end.text,
                  status: "pending",
                  priority: 1,
                );
                await store.add(event);
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}