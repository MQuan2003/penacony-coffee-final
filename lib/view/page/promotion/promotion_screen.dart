import 'package:flutter/material.dart';
import 'package:p_cf/controller/promotion_repository.dart';

import 'package:p_cf/widgets/bottomNavigationBar.dart';

import 'detail_promotion_screen.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  PromotionScreenState createState() => PromotionScreenState();
}

class PromotionScreenState extends State<PromotionScreen> {
  final PromotionRepository _repo = PromotionRepository();
  List<Promotion> _promotions = [];

  @override
  void initState() {
    super.initState();
    _loadPromotions();
  }

  Future<void> _loadPromotions() async {
    final promotions = await _repo.getPromotions();
    setState(() {
      _promotions = promotions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Các khuyến mãi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _promotions.length,
                itemBuilder: (context, index) {
                  final promotion = _promotions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      leading: Image.asset(
                        promotion.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        promotion.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Ngày hết hạn: ${promotion.endDate}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPromotionScreen(
                              title: promotion.title,
                              description: promotion.description,
                              expiration: promotion.endDate,
                              image: promotion.image, // Truyền image sang màn hình chi tiết
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 2),
    );
  }
}
