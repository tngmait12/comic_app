
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> signUp({required String email, required String password, required String fullName, required String phoneNumber}) async {
  try {
    final response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
      phone: phoneNumber,
      data: {
        'displayname': fullName,
      }
    );

    if (response.user != null) {
      print('Đăng ký thành công! Kiểm tra email để xác nhận.');
    }
  } on AuthException catch (error) {
    print('Lỗi xác thực: ${error.message}');
  } catch (e) {
    print('Lỗi không xác định: $e');
  }
}