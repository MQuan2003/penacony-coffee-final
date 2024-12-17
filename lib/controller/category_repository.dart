import 'package:p_cf/model/database_helper.dart';

class Category {
  final int id;
  final String name;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  // Tạo một đối tượng `Category` từ Map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['category_id'],
      name: map['name'],
      icon: map['icon'],
    );
  }

  // Chuyển đổi `Category` thành Map
  Map<String, dynamic> toMap() {
    return {
      'category_id': id,
      'name': name,
      'icon': icon,
    };
  }
}
class CategoryRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Lấy tất cả danh mục từ cơ sở dữ liệu
  Future<List<Category>> getAllCategories() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('categories');

    return List.generate(maps.length, (i) => Category.fromMap(maps[i]));
  }

  // Lấy danh mục theo ID
  Future<Category?> getCategoryById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'category_id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Category.fromMap(maps.first);
    }
    return null;
  }

  // Thêm danh mục mới
  Future<void> insertCategory(Category category) async {
  if (category.name.isEmpty || category.icon.isEmpty) {
    throw Exception('Category name and image cannot be empty');
  }
  final db = await _dbHelper.database;
  await db.insert('categories', category.toMap());
}


  // Cập nhật danh mục
  Future<void> updateCategory(Category category) async {
    final db = await _dbHelper.database;
    await db.update(
      'categories',
      category.toMap(),
      where: 'category_id = ?',
      whereArgs: [category.id],
    );
  }

  // Xóa danh mục
  Future<void> deleteCategory(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'categories',
      where: 'category_id = ?',
      whereArgs: [id],
    );
  }
}
