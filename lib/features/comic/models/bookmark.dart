import 'package:supabase_flutter/supabase_flutter.dart';

class Bookmark {
  final int id;
  final String userId;
  final String slug;
  final DateTime createdAt;

  Bookmark({
    required this.id,
    required this.userId,
    required this.slug,
    required this.createdAt,
  });

  // Tạo từ JSON (Supabase trả về Map<String, dynamic>)
  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'],
      userId: json['user_id'],
      slug: json['slug'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // Chuyển sang Map để insert/update vào Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'slug': slug,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ComicSnapShot{
  // Future<void> insertBookmark(String slug) async {
  //   final supabase = Supabase.instance.client;
  //   final user = supabase.auth.currentUser;
  //
  //   if (user == null) {
  //     throw Exception("User not logged in");
  //   }
  //
  //   final response = await supabase.from('bookmark').insert({
  //     'user_id': user.id,
  //     'slug': slug,
  //     'created_at': DateTime.now().toIso8601String(),
  //   });
  //
  //   if (response.error != null) {
  //     throw Exception("Insert failed: ${response.error!.message}");
  //   }
  // }

  static Future<void> deleteBookmark(String slug) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final response = await supabase
        .from('bookmark')
        .delete()
        .match({
      'user_id': user.id,
      'slug': slug,
    });

    if (response.error != null) {
      throw Exception("Delete failed: ${response.error!.message}");
    }
  }

  static Future<void> insertBookmark({
    required String userId,
    required String slug,
  }) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.from('bookmark').insert({
      'user_id': userId,
      'slug': slug,
      'created_at': DateTime.now().toIso8601String(),
    });

    if (response.error != null) {
      print('Error inserting bookmark: ${response.error!.message}');
    } else {
      print('Bookmark inserted successfully!');
    }
  }
}