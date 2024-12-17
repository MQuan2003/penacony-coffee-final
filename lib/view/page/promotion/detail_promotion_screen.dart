import 'package:flutter/material.dart';

class DetailPromotionScreen extends StatelessWidget {
  final String title;
  final String description;
  final String expiration;
  final String image; // Thêm trường image

  const DetailPromotionScreen({
    super.key,
    required this.title,
    required this.description,
    required this.expiration,
    required this.image, // Truyền thêm image
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị hình ảnh từ link
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                image: DecorationImage(
                  image: AssetImage(image), // Dùng AssetImage hoặc NetworkImage
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Tiêu đề chương trình khuyến mãi
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            // Mô tả chi tiết
            Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const Divider(height: 32.0),
            // Ngày hết hạn
            Text(
              'Ngày hết hạn: $expiration',
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
