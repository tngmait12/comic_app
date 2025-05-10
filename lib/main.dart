import 'package:comic_app/features/comic/models/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:comic_app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  await Supabase.initialize(
    url: 'https://saqyvwcaoakhagodmpve.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNhcXl2d2Nhb2FraGFnb2RtcHZlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY1MzQ1OTYsImV4cCI6MjA2MjExMDU5Nn0.nWCU1Td8jPXTkz0fbqnsOMiJnwZ4nDHDPOQ82n5YT4g',
  );

  runApp(const App());
}

