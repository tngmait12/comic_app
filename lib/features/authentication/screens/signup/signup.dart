import 'package:flutter/material.dart';

import 'widgets/signup_form.dart';

class comic_signupScreen extends StatelessWidget {
  const comic_signupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text("Tạo tài khoản mới", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              Text("Vui lòng điền vào các ô trống bên dưới!", style: TextStyle(fontSize: 18)),
              SizedBox(height: 30),
              const comic_signupForm(),
            ],
          ),
        ),
      ),
    );;
  }
}
