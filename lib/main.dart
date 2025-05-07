import 'package:flutter/material.dart';
import 'package:comic_app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  /// Connect Supabase
  await Supabase.initialize(
    url: "https://cefzpxihvfhzulvhsmmy.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNlZnpweGlodmZoenVsdmhzbW15Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY2MjYyODMsImV4cCI6MjA2MjIwMjI4M30.qiv0QBQU5OlADTWsLWU32EYxfxqb71XdcWJYgYG4KxI"
  );
  runApp(const App());
}

