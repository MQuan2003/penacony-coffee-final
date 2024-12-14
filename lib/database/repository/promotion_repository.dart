import 'package:p_cf/database/database_helper.dart';

class Promotion {
  final int id;
  final String title;
  final String description;
  final String image;
  final String startDate;
  final String endDate;

  Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
  });

  // Convert a Promotion into a Map.
  Map<String, dynamic> toMap() {
    return {
      'promotion_id': id,
      'title': title,
      'description': description,
      'image': image,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  // Convert a Map into a Promotion.
  factory Promotion.fromMap(Map<String, dynamic> map) {
    return Promotion(
      id: map['promotion_id'],
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      startDate: map['start_date'] as String,
      endDate: map['end_date'] as String,
    );
  }
}

class PromotionRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Insert a new promotion into the database
  Future<void> insertPromotion(Promotion promotion) async {
    final db = await _dbHelper.database;
    await db.insert('promotion', promotion.toMap());
  }

  // Get all promotions from the database
  Future<List<Promotion>> getPromotions() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('promotion');

    return List.generate(
      maps.length,
      (i) => Promotion.fromMap(maps[i]),
    );
  }
}
