import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../../helpers/supabase_helper.dart';

AuthResponse? response;

class PageComicLogin extends StatelessWidget {
  const PageComicLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
                child: Container()
            ),
            SupaEmailAuth(
              onSignInComplete: (res) {
                response = res;
                Navigator.of(context).pop();
              },
              onSignUpComplete: (res) {
                if(res.user!=null) {
                  Get.to(() => PageVerifyOTP(email: res.user!.email!));
                }
              },
              showConfirmPasswordField: true,
            ),
            Expanded(
                child: Container()
            ),
          ],
        ),
      ),
    );
  }
}

class PageVerifyOTP extends StatelessWidget {
  PageVerifyOTP({super.key, required this.email});
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xác thực mã OTP"),
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
            //runs when every textfield is filled
            onSubmit: (String verificationCode) async {
              response = await Supabase.instance.client.auth.verifyOTP(
                  email: email,
                  token: verificationCode,
                  type: OtpType.email
              );
              if(response?.session!=null && response?.user!=null) {
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(builder: (context) => PageProfileUser()),
                //       (route) => false,
                // );
                Get.to(PageProfileUser());
              }
            }, // end onSubmit
          ),
          SizedBox(height: 50,),
          ElevatedButton(
              onPressed: () async{
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Đang gửi mã OTP ..."),
                    duration: Duration(hours: 1),
                  ),
                );
                final response = await supabase.auth.signInWithOtp(
                    email: email
                );
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Mã otp đã gửi vào $email của bạn"),
                  ),
                );
              },
              child: Text("Gửi lại mã OTP")
          ),
        ],
      ),
    );
  }
}

class PageProfileUser extends StatefulWidget {
  const PageProfileUser({super.key});

  @override
  State<PageProfileUser> createState() => _PageProfileUserState();
}

class _PageProfileUserState extends State<PageProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile User"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
