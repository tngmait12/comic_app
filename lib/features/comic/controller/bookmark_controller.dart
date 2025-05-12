import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookmarkController extends GetxController {
  final supabase = Supabase.instance.client;

  final RxList<Map<String, dynamic>> _bookmarks = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> _history = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final response = await supabase
        .from('bookmark')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    if (response != null && response is List) {
      _bookmarks.clear();
      _history.clear();

      for (var row in response) {
        final isBookmark = row['is_bookmark'] == true;
        final chapterName = row['chapter_name'];

        if (isBookmark && chapterName == null) {
          _bookmarks.add(row);
        } else if (!isBookmark && chapterName != null) {
          _history.add(row);
        } else if (isBookmark && chapterName != null) {
          _bookmarks.add(row);
          _history.add(row);
        }
      }
    }
  }

  Future<void> toggleBookmark(String slug) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final existing = await supabase
        .from('bookmark')
        .select()
        .eq('user_id', user.id)
        .eq('slug', slug)
        .maybeSingle();

    if (existing != null) {
      final isBookmarked = existing['is_bookmark'] == true;
      final chapterName = existing['chapter_name'];

      if (isBookmarked) {
        // Người dùng bỏ bookmark
        if (chapterName == null) {
          // Không có lịch sử đọc → xóa luôn bản ghi
          await supabase
              .from('bookmark')
              .delete()
              .match({'user_id': user.id, 'slug': slug});
        } else {
          // Có lịch sử → chỉ bỏ đánh dấu bookmark
          await supabase
              .from('bookmark')
              .update({'is_bookmark': false})
              .match({'user_id': user.id, 'slug': slug});
        }
      } else {
        // Người dùng thêm bookmark
        await supabase
            .from('bookmark')
            .update({'is_bookmark': true})
            .match({'user_id': user.id, 'slug': slug});
      }
    } else {
      // Không có bản ghi → tạo mới
      await supabase.from('bookmark').insert({
        'user_id': user.id,
        'slug': slug,
        'is_bookmark': true,
        'chapter_name': null,
        'created_at': DateTime.now().toIso8601String(),
      });
    }

    await fetchData();
  }

  Future<void> addToHistory(String slug, String chapterName) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final existing = await supabase
        .from('bookmark')
        .select()
        .eq('user_id', user.id)
        .eq('slug', slug)
        .maybeSingle();

    if (existing != null) {
      await supabase.from('bookmark').update({
        'chapter_name': chapterName,
        'is_bookmark': existing['is_bookmark'] ?? false,
      }).match({'user_id': user.id, 'slug': slug});
    } else {
      await supabase.from('bookmark').insert({
        'user_id': user.id,
        'slug': slug,
        'chapter_name': chapterName,
        'is_bookmark': false,
        'created_at': DateTime.now().toIso8601String(),
      });
    }

    await fetchData();
  }

  List<Map<String, dynamic>> get bookmarks => _bookmarks;
  List<Map<String, dynamic>> get history => _history;

  bool isBookmarked(String slug) {
    return _bookmarks.any((item) => item['slug'] == slug);
  }
}


class BindingBookmark extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookmarkController(), fenix: true);
  }
}