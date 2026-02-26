import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/state/event_store.dart';
import 'ui/state/category_store.dart';
import 'ui/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventStore()),
        ChangeNotifierProvider(create: (_) => CategoryStore()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}