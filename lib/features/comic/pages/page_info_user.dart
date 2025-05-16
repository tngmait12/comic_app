import 'package:comic_app/features/comic/models/profile_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants.dart';

class PageInfoUser extends StatefulWidget {
  const PageInfoUser({super.key});

  @override
  State<PageInfoUser> createState() => _PageInfoUserState();
}

class _PageInfoUserState extends State<PageInfoUser> {
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtDiaChi = TextEditingController();
  TextEditingController txtSdt = TextEditingController();
  String? gioiTinh = "Nam";
  String? capBac = 'Bình Thường';
  List<String> capBacOptions = ['Bình Thường', 'Cao Cấp'];

  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.navigate_before_outlined,
              color: Colors.white,
              size: SIZE_ICO,
            )
        ),
        title: Text("Thông tin người dùng", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.shadow,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/avatar_sample.jpg'),
              ),
              SizedBox(height: 30,),
              _buildTextField('Tên', txtTen),
              SizedBox(height: 16,),
              SizedBox(height: 16,),
              _buildTextField('Địa chỉ', txtDiaChi),
              SizedBox(height: 16,),
              _buildTextField('Số điện thoại', txtSdt),
              SizedBox(height: 16,),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Giới tính:", style: TextStyle(color: Colors.white),)),
              Row (
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text("Nam", style: TextStyle(color: Colors.white)),
                      value: "Nam", //Giá trị cố định
                      groupValue: gioiTinh, //Giá trị thay đổi, khi value = groupValue thì radio sẽ được chọn
                      onChanged: (value) {
                        setState(() {
                          gioiTinh = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text("Nữ", style: TextStyle(color: Colors.white)),
                      value: "Nu", //Giá trị cố định
                      groupValue: gioiTinh, //Giá trị thay đổi
                      onChanged: (value) {
                        setState(() {
                          gioiTinh = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Container(
                alignment: Alignment.centerLeft,
                child: Text("Lựa chọn cấp bậc:", style: TextStyle(color: Colors.white),)),
              DropdownButton<String>(
                isExpanded: true,
                value: capBac, //Giá trị thay đổi, khi value bằng với value của menu item thì item đó sẽ được chọn
                items: capBacOptions.map(
                      (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Row(
                      children: [
                        Text(e, style: TextStyle(color: Colors.blue),),
                      ],
                    ), //Cố định
                  ),
                ).toList(),
                onChanged: (value) { //value của dropdownMenuItem được chọn
                  setState(() {
                    capBac = value;
                  });
                },
              ),
              SizedBox(height: 24,),
              ElevatedButton(
                onPressed: () async {
                  final user = supabase.auth.currentUser;
                  final userId = user?.id; // Lấy ID từ Supabase Authentication
                  final DateTime created = DateTime.now();
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Đang lưu thông tin"),
                        duration: Duration(seconds: 5),
                      )
                  );
                  Profile profile = Profile(
                      createdAt: created,
                      ten: txtTen.text,
                      diaChi: txtDiaChi.text,
                      sdt: txtSdt.text,
                      gioiTinh: gioiTinh ?? "Nam",
                      capBac: capBac ?? "Bình thường",
                      user_id: userId.toString()
                  );
                  await ProfileSnapshot.upsertProfile(profile);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Đã lưu thông tin"),
                        duration: Duration(seconds: 5),
                      )
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  shape: const StadiumBorder(),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                child: Text('Lưu cập nhật', style: TextStyle(fontSize: 16, color: Colors.white)),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.shadow,
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.cyan),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
