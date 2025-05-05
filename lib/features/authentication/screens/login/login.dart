import 'package:flutter/material.dart';

import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class comic_loginScreen extends StatelessWidget {
  const comic_loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              const comic_loginHeader(),
              const comic_loginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
