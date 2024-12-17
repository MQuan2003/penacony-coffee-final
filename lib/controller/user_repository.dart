import 'package:p_cf/model/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// Thêm người dùng mới
  Future<void> registerUser(
      String username, String email, String password) async {
    final db = await _dbHelper.database;
    await db.insert(
      'user', // Sử dụng bảng `user` đã có
      {
        'username': username,
        'email': email,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm
          .fail, // Nếu có xung đột (username/email trùng), sẽ báo lỗi
    );
  }

  /// Tìm người dùng bằng tên đăng nhập và mật khẩu
  Future<Map<String, dynamic>?> loginUser(
      String username, String password) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'user', // Sử dụng bảng `user` đã có
      where: 'username = ? AND password = ?', // Điều kiện
      whereArgs: [username, password],
    );
    return result.isNotEmpty
        ? result.first
        : null; // Trả về kết quả đầu tiên nếu tìm thấy
  }

  /// Kiểm tra xem người dùng đã tồn tại chưa
  Future<bool> checkUserExists(String username, String email) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'user', // Sử dụng bảng `user` đã có
      where: 'username = ? OR email = ?', // Kiểm tra trùng username hoặc email
      whereArgs: [username, email],
    );
    return result.isNotEmpty;
  }
  /// Đổi mật khẩu người dùng
Future<void> changePassword(String username, String currentPassword, String newPassword) async {
  final db = await _dbHelper.database;

  // Tìm kiếm người dùng bằng username và mật khẩu hiện tại
  final user = await db.query(
    'user',
    where: 'username = ? AND password = ?',
    whereArgs: [username, currentPassword],
  );

  if (user.isEmpty) {
    throw Exception('Invalid username or current password'); // Báo lỗi nếu không tìm thấy
  }

  // Cập nhật mật khẩu mới
  await db.update(
    'user',
    {'password': newPassword},
    where: 'username = ?',
    whereArgs: [username],
  );
}
/// Cập nhật thông tin cá nhân
Future<void> updateUserProfile({
  required int userId,
  String? fullname,
  String? dob,
  String? gender,
  String? avatar,
}) async {
  final db = await _dbHelper.database;

  // Chuẩn bị dữ liệu cần cập nhật
  Map<String, dynamic> updates = {};
  if (fullname != null) updates['fullname'] = fullname;
  if (dob != null) updates['dob'] = dob;
  if (gender != null) updates['gender'] = gender;
  if (avatar != null) updates['avatar'] = avatar;

  if (updates.isEmpty) {
    throw Exception('No fields to update');
  }

  // Cập nhật thông tin trong bảng `user`
  await db.update(
    'user',
    updates,
    where: 'user_id = ?', // Điều kiện: tìm đúng `user_id`
    whereArgs: [userId],
  );
}


}
