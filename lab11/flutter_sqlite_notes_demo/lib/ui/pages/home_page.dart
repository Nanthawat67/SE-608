import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/note_store.dart';
import 'note_form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<NoteStore>().load());
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<NoteStore>();
    final notes = store.notes;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const NoteFormPage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [

          /// 🔥 Modern App Bar แบบใหญ่
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Notes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          /// 🔥 Summary Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _SummaryCard(count: notes.length),
            ),
          ),

          /// 🔥 List Section
          store.loading
              ? const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : notes.isEmpty
                  ? const SliverFillRemaining(
                      child: _EmptyState(),
                    )
                  : SliverPadding(
                      padding:
                          const EdgeInsets.symmetric(
                              horizontal: 20),
                      sliver: SliverList(
                        delegate:
                            SliverChildBuilderDelegate(
                          (context, index) {
                            final note = notes[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(
                                      bottom: 16),
                              child:
                                  _ModernNoteCard(
                                      note: note),
                            );
                          },
                          childCount: notes.length,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final int count;
  const _SummaryCard({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(24),
        color: Theme.of(context)
            .colorScheme
            .surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor:
                Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.1),
            child: Icon(
              Icons.sticky_note_2,
              color: Theme.of(context)
                  .colorScheme
                  .primary,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                "$count Notes",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge,
              ),
              const SizedBox(height: 4),
              const Text(
                "Keep writing ✨",
                style: TextStyle(
                    color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ModernNoteCard extends StatelessWidget {
  final dynamic note;
  const _ModernNoteCard(
      {required this.note});

  @override
  Widget build(BuildContext context) {
    final store =
        context.read<NoteStore>();

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding:
            const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Theme.of(context)
                  .colorScheme
                  .surface,
              Theme.of(context)
                  .colorScheme
                  .surfaceVariant,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    note.content,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                  Icons.delete_outline),
              onPressed: () async {
                await store
                    .remove(note.id!);
              },
            )
          ],
        ),
      ),
    );
  }
}

class _EmptyState
    extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 90,
            color: Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.3),
          ),
          const SizedBox(height: 20),
          const Text(
            "No notes yet",
            style: TextStyle(
                fontSize: 18),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tap + to create one",
            style:
                TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}