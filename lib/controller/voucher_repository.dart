import 'package:p_cf/model/database_helper.dart';


class Voucher {
  final int id;
  final String title;
  final String description;
  final String image;
  final int requiredPoint;
  final String endDate; // Sử dụng String thay vì DateTime

  Voucher({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.requiredPoint,
    required this.endDate,
  });

  // Convert a Voucher into a Map.
  Map<String, dynamic> toMap() {
    return {
      'voucher_id': id,
      'title': title,
      'description': description,
      'image': image,
      'required_point': requiredPoint,
      'end_date': endDate, // Lưu endDate dưới dạng String
    };
  }

  // Convert a Map into a Voucher.
  factory Voucher.fromMap(Map<String, dynamic> map) {
    return Voucher(
      id: map['voucher_id'],
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      requiredPoint: map['required_point'] as int,
      endDate: map['end_date'] as String, // Đọc endDate dưới dạng String
    );
  }
}


class VoucherRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Lấy tất cả voucher từ database
  Future<List<Voucher>> getAllVouchers() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('voucher');

    return List.generate(
      maps.length,
      (i) => Voucher.fromMap(maps[i]),
    );
  }

  // Lấy voucher theo ID
  Future<Voucher?> getVoucherById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'voucher',
      where: 'voucher_id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Voucher.fromMap(maps.first);
    }
    return null;
  }

  // Thêm voucher mới
  Future<void> insertVoucher(Voucher voucher) async {
    final db = await _dbHelper.database;

    // Kiểm tra dữ liệu
    final existing = await db.query(
      'voucher',
      where: 'title = ?',
      whereArgs: [voucher.title],
    );

    if (existing.isNotEmpty) {
      throw Exception('Voucher title already exists');
    }

    // Kiểm tra ngày kết thúc hợp lệ
    final today = DateTime.now();
    final endDate = DateTime.parse(voucher.endDate);
    if (endDate.isBefore(today)) {
      throw Exception('End date must be in the future');
    }

    await db.insert('voucher', voucher.toMap());
  }

  // Cập nhật voucher
  Future<void> updateVoucher(Voucher voucher) async {
    final db = await _dbHelper.database;
    await db.update(
      'voucher',
      voucher.toMap(),
      where: 'voucher_id = ?',
      whereArgs: [voucher.id],
    );
  }

  // Xóa voucher
  Future<void> deleteVoucher(int id) async {
    final db = await _dbHelper.database;

    // Kiểm tra nếu voucher đã được liên kết với người dùng
    final used = await db.query(
      'user_voucher',
      where: 'voucher_id = ?',
      whereArgs: [id],
    );

    if (used.isNotEmpty) {
      throw Exception('Cannot delete voucher as it is linked to users.');
    }

    await db.delete(
      'voucher',
      where: 'voucher_id = ?',
      whereArgs: [id],
    );
  }
}
