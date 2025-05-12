import 'package:supabase_flutter/supabase_flutter.dart';

class UserComic {
  final String id;
  final DateTime createdAt;
  final String ten;
  final String email;
  final String diaChi;
  final String sdt;
  final String gioiTinh;
  final String capBac;

  const UserComic({
    required this.id,
    required this.createdAt,
    required this.ten,
    required this.email,
    required this.diaChi,
    required this.sdt,
    required this.gioiTinh,
    required this.capBac,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'created_at': createdAt.toIso8601String(),
      'ten': this.ten,
      'email': this.email,
      'diaChi': this.diaChi,
      'soDienThoai': this.sdt,
      'gioiTinh': this.gioiTinh,
      'capBac': this.capBac,
    };
  }

  factory UserComic.fromMap(Map<String, dynamic> map) {
    return UserComic(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at']),
      ten: map['ten'] as String,
      email: map['email'] as String,
      diaChi: map['diaChi'] as String,
      sdt: map['soDienThoai'] as String,
      gioiTinh: map['gioiTinh'] as String,
      capBac: map['capBac'] as String,
    );
  }
}

class UserSnapshot {
  static Future<void> insert(UserComic newUser) async {
    final supabase = Supabase.instance.client;
    await supabase
        .from('User')
        .insert(newUser.toMap());
  }
}