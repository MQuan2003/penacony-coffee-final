import 'package:flutter/material.dart';

class FoodDetailScreen extends StatelessWidget {
  final Map<String, dynamic> food;
  final String previousPageTitle;

  const FoodDetailScreen({
    super.key,
    required this.food,
    this.previousPageTitle = 'Chi tiết món ăn',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(previousPageTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình ảnh món ăn
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey[200],
                  image: food['image'] != null && food['image'].toString().isNotEmpty
                      ? DecorationImage(
                          image: food['image'].toString().startsWith('http')
                              ? NetworkImage(food['image'])
                              : AssetImage(food['image']) as ImageProvider,
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/images/default_food.png'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Tên món ăn
              Text(
                food['name'] ?? 'Không rõ tên',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),

              // Giá món ăn
              Text(
                food['price'] != null
                    ? '${food['price'].toString()} đ'
                    : 'Không rõ giá',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),

              // Mô tả món ăn
              Text(
                food['description'] ?? 'Không có mô tả cho món ăn này.',
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 24.0),

             ],
          ),
        ),
      ),
    );
  }
}
