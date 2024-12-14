import 'package:p_cf/database/database_helper.dart';

class UserVoucherRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addUserVoucher(int userId, int voucherId) async {
    final db = await _dbHelper.database;
    await db.insert('user_voucher', {
      'user_id': userId,
      'voucher_id': voucherId,
      'redeemed_date': DateTime.now().toIso8601String(),
    });
  }

  Future<void> deleteUserVoucher(int userId, int voucherId) async {
    final db = await _dbHelper.database;
    await db.delete(
      'user_voucher',
      where: 'user_id = ? AND voucher_id = ?',
      whereArgs: [userId, voucherId],
    );
  }

  Future<List<Map<String, dynamic>>> getUserVoucherDetails(int userId) async {
    final db = await _dbHelper.database;

    // Lấy thông tin voucher liên quan đến người dùng
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT v.*
      FROM user_voucher uv
      INNER JOIN voucher v ON uv.voucher_id = v.voucher_id
      WHERE uv.user_id = ?
    ''', [userId]);

    return result;
  }
}
