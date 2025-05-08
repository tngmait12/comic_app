import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<String> updateImage({
  required File image,
  required String bucket,
  required String path,
  bool upsert = false
}) async {
  await supabase.storage
      .from(bucket)
      .update(
    path,
    image,
    fileOptions: FileOptions(cacheControl: '3600', upsert: upsert),
  );
  String publicUrl = supabase.storage.from(bucket).getPublicUrl(path);
  return publicUrl + "?ts=${DateTime.now().microsecond}";
}

Future<void> deleteImage({required String bucket, required String path}) async {
  await supabase.storage.from('avatars').remove([path]);
}

Future<Map<int, T>> getMapData<T>({
  required String table,
  required T Function(Map<String, dynamic> map) fromJson,
  required int Function(T t) getId
}) async {
  final data = await supabase.from(table).select();
  var iterable = data.map(
        (e) => fromJson(e),
  );
  Map<int, T> _maps = Map.fromIterable(iterable, key: (t) => getId(t), value: (t) => t,);
  return _maps;
}
