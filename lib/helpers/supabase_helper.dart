import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<String> uploadImage({
  required File image,
  required String bucket,
  required String path,
  bool upsert = false
}) async {
  await supabase.storage
      .from(bucket)
      .upload(
    path,
    image,
    fileOptions: FileOptions(cacheControl: '3600', upsert: upsert),
  );
  String url = supabase.storage.from(bucket).getPublicUrl(path);
  return url;
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
