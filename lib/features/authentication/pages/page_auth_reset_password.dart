import 'package:comic_app/features/authentication/pages/page_auth_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class PageResetPassword extends StatelessWidget {
  PageResetPassword({super.key});
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            SupaResetPassword(
              accessToken: supabase.auth.currentSession?.accessToken,
              onSuccess: (UserResponse response) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Đổi mật khẩu thành công"),
                    duration: Duration(seconds: 3),
                  ),
                );
                Get.find<AuthController>().logout();
                Get.offAll(() => PageLoginUser());
              },
              onError: (error) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Có lỗi xảy ra khi đổi mật khẩu"),
                    duration: Duration(seconds: 3),
                  ),
                );
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
