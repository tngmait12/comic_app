import 'package:comic_app/features/authentication/pages/page_auth_reset_password.dart';
import 'package:comic_app/features/comic/pages/page_setting_comic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../../../my_widget/snack_bar.dart';
import '../../../navigation_menu.dart';
import 'package:get/get.dart';

AuthResponse? response;
class AuthController extends GetxController {
  Rx<AuthResponse?> response = Rx<AuthResponse?>(null);

  void updateResponse(AuthResponse newResponse) {
    response.value = newResponse;
  }

  void logout() async{
    await Supabase.instance.client.auth.signOut();
    response.value = null;
  }
}

class PageLoginUser extends StatelessWidget {
  PageLoginUser({super.key});
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: Container()),
            // Create a Email sign-in/sign-up form
            SupaEmailAuth(
              onSignInComplete: (res) {
                authController.updateResponse(res);

                Get.offAll(() => const NavigationMenu());
                Get.snackbar(
                  "Đăng nhập thành công!",
                  "Chúc bạn trải nghiệm vui vẻ",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  duration: Duration(seconds: 2),
                );
              },
              onSignUpComplete: (response) {
                if(response.user!=null){
                  Get.to(() => PageVerifyOTP(email: response.user!.email!));
                }
              },

              onPasswordResetEmailSent: () {
                Get.to(PageVerifyOTPForgotPassword());
              },

              showConfirmPasswordField: true,
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

class PageVerifyOTP extends StatelessWidget {
  const PageVerifyOTP({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veriry Code OTP'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            onSubmit: (String verifycationCode) async{
              response = await Supabase.instance.client.auth.verifyOTP(
                  email: email,
                  token: verifycationCode,
                  type: OtpType.email
              );

              if(response?.session!=null && response?.user!=null){
                final controller = Get.find<NavigationController>();
                controller.selectedIndex.value = 3;
              }
            },
          ),
          SizedBox(height: 50,),
          ElevatedButton(
              onPressed: () async{
                showSnackBar(context, message: "Dang gui ma OTP", second: 600);

                await Supabase.instance.client.auth.resend(
                  type: OtpType.email,
                  email: email,
                );
              },
              child: Text("Resend code OTP")
          ),
        ],
      ),
    );
  }
}

class PageVerifyOTPForgotPassword extends StatelessWidget {
  PageVerifyOTPForgotPassword({super.key});

  final TextEditingController txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Veriry Code OTP'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              label: Text('Enter your email'),
            ),
            controller: txtEmail,
          ),
          SizedBox(height: 16.0,),
          OtpTextField(
            numberOfFields: 6,
            borderColor: Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            onSubmit: (String verifycationCode) async{
              response = await Supabase.instance.client.auth.verifyOTP(
                  email: txtEmail.text.trim(),
                  token: verifycationCode,
                  type: OtpType.email
              );

              if(response?.session!=null && response?.user!=null){
                Get.offAll(PageResetPassword());
              }
            },
          ),
          SizedBox(height: 50,),
          ElevatedButton(
              onPressed: () async{
                showSnackBar(context, message: "Dang gui ma OTP", second: 600);

                await Supabase.instance.client.auth.resend(
                  type: OtpType.email,
                  email: txtEmail.text.trim(),
                );
              },
              child: Text("Resend code OTP")
          ),
        ],
      ),
    );
  }
}

