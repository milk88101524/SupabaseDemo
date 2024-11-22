import 'package:flu_note_demo/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  const supaUrl = "https://alzraujcgjopaymhlbik.supabase.co";
  const supaApiKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFsenJhdWpjZ2pvcGF5bWhsYmlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIwODE4MzIsImV4cCI6MjA0NzY1NzgzMn0.ARqw8lUDqRR7Jk8o5EdlleulrqR88LKKNm9qunmlyd8";

  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supaUrl,
    anonKey: supaApiKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
