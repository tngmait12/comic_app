import 'package:flutter/material.dart';

class comic_loginHeader extends StatelessWidget {
  const comic_loginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              height: 120,
              image: AssetImage('assets/images/logo1.png'),
            ),
          ),
          SizedBox(height: 15,),
          Text("Đăng nhập", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          Text("Vui lòng đăng nhập tài khoản để đọc truyện!", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
