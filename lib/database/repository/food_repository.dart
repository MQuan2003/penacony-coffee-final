import 'package:p_cf/database/database_helper.dart';

class Food {
  final int id;
  final int categoryId;
  final String name;
  final double price;
  final String description;
  final bool isBestSeller;
  final String image;

  Food({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.description,
    required this.isBestSeller,
    required this.image,
  });

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['food_id'],
      categoryId: map['category_id'],
      name: map['name'],
      price: map['price'],
      description: map['description'] ?? '',
      isBestSeller: map['is_best_seller'] == 1,
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'food_id': id,
      'category_id': categoryId,
      'name': name,
      'price': price,
      'description': description,
      'is_best_seller': isBestSeller ? 1 : 0,
      'image': image,
    };
  }
}

class FoodRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Food>> getAllFoods() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('foods');

    return List.generate(maps.length, (i) => Food.fromMap(maps[i]));
  }

  Future<Food?> getFoodById(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'foods',
      where: 'food_id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Food.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Food>> getBestSellers() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'foods',
      where: 'is_best_seller = ?',
      whereArgs: [true],
    );

    return List.generate(maps.length, (i) => Food.fromMap(maps[i]));
  }

  Future<void> insertFood(Food food) async {
    final db = await _dbHelper.database;
    await db.insert('foods', food.toMap());
  }

  Future<void> updateFood(Food food) async {
    final db = await _dbHelper.database;
    await db.update(
      'foods',
      food.toMap(),
      where: 'food_id = ?',
      whereArgs: [food.id],
    );
  }

  Future<void> deleteFood(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'foods',
      where: 'food_id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Food>> searchFoods(String keyword) async {
  final db = await _dbHelper.database;
  final List<Map<String, dynamic>> maps = await db.query(
    'foods',
    where: 'name LIKE ?',
    whereArgs: ['%$keyword%'],
  );
  return List.generate(maps.length, (i) => Food.fromMap(maps[i]));
}


  Future<List<Food>> getAllFoodsSortedByPrice() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'foods',
      orderBy: 'price ASC',
    );
    return List.generate(maps.length, (i) => Food.fromMap(maps[i]));
  }


}
