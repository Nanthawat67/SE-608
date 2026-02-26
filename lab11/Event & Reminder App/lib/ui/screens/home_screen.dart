import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/event_store.dart';
import 'event_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<EventStore>().load());
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<EventStore>();

    return Scaffold(
      appBar: AppBar(title: const Text("Event App")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const EventFormScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: store.events.length,
        itemBuilder: (_, i) {
          final e = store.events[i];
          return ListTile(
            title: Text(e.title),
            subtitle: Text(
                "${e.eventDate} ${e.startTime}-${e.endTime}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () =>
                  store.remove(e.id!),
            ),
          );
        },
      ),
    );
  }
}