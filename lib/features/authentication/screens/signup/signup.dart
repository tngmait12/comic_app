import 'package:comic_app/features/authentication/screens/signup/widgets/signup.dart';
import 'package:flutter/material.dart';

import 'widgets/signup_form.dart';

class comic_signupScreen extends StatefulWidget {
  const comic_signupScreen({super.key});

  @override
  State<comic_signupScreen> createState() => _comic_signupScreenState();
}

class _comic_signupScreenState extends State<comic_signupScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();

  void _register() {
    final email = _emailController.text.trim();
    final name = _emailController.text.trim();
    final phone = _emailController.text.trim();
    final password = _passwordController.text;
    signUp(email: email, password: password, fullName: name, phoneNumber: phone,);
  }

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
              comic_signupForm(emailController: _emailController, passwordController: _passwordController, onRegister: _register, phoneController: _phoneController, nameController: _nameController,),
            ],
          ),
        ),
      ),
    );
  }
}
