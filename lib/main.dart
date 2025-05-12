import 'package:comic_app/features/comic/models/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:comic_app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  await Supabase.initialize(
    url: 'https://ivkqmluotqyeblnyguuh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml2a3FtbHVvdHF5ZWJsbnlndXVoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY5NjcxMTYsImV4cCI6MjA2MjU0MzExNn0.aTv9uo_bBU0CvQ3rATD-WKYonptuz-D9HitA_kfd3oA',
  );

  runApp(const App());
}

