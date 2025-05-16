import 'package:supabase_flutter/supabase_flutter.dart';

class Profile {
  final int? id;
  final DateTime createdAt;
  final String ten;
  final String diaChi;
  final String sdt;
  final String gioiTinh;
  final String capBac;
  final String user_id;

  const Profile({
    this.id,
    required this.createdAt,
    required this.ten,
    required this.diaChi,
    required this.sdt,
    required this.gioiTinh,
    required this.capBac,
    required this.user_id
  });

  Map<String, dynamic> toMap() {
    final map = {
      'created_at': createdAt.toIso8601String(),
      'ten': ten,
      'diaChi': diaChi,
      'soDienThoai': sdt,
      'gioiTinh': gioiTinh,
      'capBac': capBac,
      'user_id': user_id,
    };
    if (id != null) {
      map['id'] = id.toString();
    }
    return map;
  }


  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at']),
      ten: map['ten'] as String,
      diaChi: map['diaChi'] as String,
      sdt: map['soDienThoai'] as String,
      gioiTinh: map['gioiTinh'] as String,
      capBac: map['capBac'] as String,
      user_id: map['user_id'] as String
    );
  }
}

class ProfileSnapshot {
  static Future<void> upsertProfile(Profile newUser) async {
    final supabase = Supabase.instance.client;
    await supabase
        .from('Profile')
        .upsert(newUser.toMap(), onConflict: 'user_id').select();
  }

  static Future<Profile?> getProfileByUserId(String userId) async {
    final supabase = Supabase.instance.client;
    final data = await supabase
        .from('Profile')
        .select()
        .eq('user_id', userId)
        .single();

    if (data != null) {
      return Profile.fromMap(data);
    }
    return null;
  }
}