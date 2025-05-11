import 'package:comic_app/features/comic/models/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:comic_app/app.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/authentication/pages/page_auth_user.dart';

void main() async{
  await Supabase.initialize(
    url: 'https://cefzpxihvfhzulvhsmmy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNlZnpweGlodmZoenVsdmhzbW15Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY2MjYyODMsImV4cCI6MjA2MjIwMjI4M30.qiv0QBQU5OlADTWsLWU32EYxfxqb71XdcWJYgYG4KxI',
  );
  Get.put(AuthController());
  runApp(const App());
}

